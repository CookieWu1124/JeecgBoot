package org.jeecg.modules.proposal.service;

import org.jeecg.common.util.oConvertUtils;
import org.jeecg.modules.proposal.entity.*;
import org.jeecg.modules.proposal.vo.DeptBriefVo;
import org.jeecg.modules.proposal.vo.ProposalDetailVo;
import org.jeecg.modules.proposal.vo.UserBriefVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * 管理端列表/详情：批量查出用户、部门，嵌到业务记录上，避免前端 N+1。
 */
@Component
public class ProposalOrgFillHelper {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void fillDeptLeaders(List<ProposalDeptLeader> rows) {
        if (rows == null || rows.isEmpty()) {
            return;
        }
        Map<String, DeptBriefVo> deptMap = loadDeptsByIds(collect(rows, ProposalDeptLeader::getDeptId));
        Map<String, UserBriefVo> userMap = loadUsers(collect(rows, ProposalDeptLeader::getLeaderUserId));
        for (ProposalDeptLeader row : rows) {
            row.setDept(deptMap.get(row.getDeptId()));
            row.setLeader(userMap.get(row.getLeaderUserId()));
        }
    }

    public void fillCommitteeMembers(List<ProposalCommitteeMember> rows) {
        if (rows == null || rows.isEmpty()) {
            return;
        }
        Map<String, UserBriefVo> userMap = loadUsers(collect(rows, ProposalCommitteeMember::getUserId));
        for (ProposalCommitteeMember row : rows) {
            row.setUser(userMap.get(row.getUserId()));
        }
    }

    public void fillApprovers(List<ProposalApprover> rows) {
        if (rows == null || rows.isEmpty()) {
            return;
        }
        Map<String, UserBriefVo> userMap = loadUsers(collect(rows, ProposalApprover::getUserId));
        for (ProposalApprover row : rows) {
            row.setUser(userMap.get(row.getUserId()));
        }
    }

    public void fillProposals(List<Proposal> rows) {
        if (rows == null || rows.isEmpty()) {
            return;
        }
        Set<String> userIds = new LinkedHashSet<>();
        Set<String> deptIds = new LinkedHashSet<>();
        for (Proposal row : rows) {
            addId(userIds, row.getProposerId());
            addId(userIds, row.getDeptLeaderId());
            addId(deptIds, row.getDeptId());
        }
        Map<String, UserBriefVo> userMap = loadUsers(userIds);
        Map<String, DeptBriefVo> deptMap = loadDeptsByIds(deptIds);
        for (Proposal row : rows) {
            row.setProposer(userMap.get(row.getProposerId()));
            row.setDeptLeader(userMap.get(row.getDeptLeaderId()));
            row.setDept(deptMap.get(row.getDeptId()));
        }
    }

    public void fillDetail(ProposalDetailVo vo) {
        if (vo == null) {
            return;
        }
        Set<String> userIds = new LinkedHashSet<>();
        Set<String> deptIds = new LinkedHashSet<>();
        Proposal proposal = vo.getProposal();
        if (proposal != null) {
            addId(userIds, proposal.getProposerId());
            addId(userIds, proposal.getDeptLeaderId());
            addId(deptIds, proposal.getDeptId());
        }
        if (vo.getCommitteeReviews() != null) {
            for (ProposalCommitteeReview review : vo.getCommitteeReviews()) {
                addId(userIds, review.getReviewerId());
            }
        }
        if (vo.getStatusLogs() != null) {
            for (ProposalStatusLog log : vo.getStatusLogs()) {
                addId(userIds, log.getOperatorId());
            }
        }
        if (vo.getApplicationApproval() != null) {
            addId(userIds, vo.getApplicationApproval().getApproverId());
        }
        Map<String, UserBriefVo> userMap = loadUsers(userIds);
        Map<String, DeptBriefVo> deptMap = loadDeptsByIds(deptIds);
        if (proposal != null) {
            proposal.setProposer(userMap.get(proposal.getProposerId()));
            proposal.setDeptLeader(userMap.get(proposal.getDeptLeaderId()));
            proposal.setDept(deptMap.get(proposal.getDeptId()));
        }
        if (vo.getCommitteeReviews() != null) {
            for (ProposalCommitteeReview review : vo.getCommitteeReviews()) {
                review.setReviewer(userMap.get(review.getReviewerId()));
            }
        }
        if (vo.getStatusLogs() != null) {
            for (ProposalStatusLog log : vo.getStatusLogs()) {
                log.setOperator(userMap.get(log.getOperatorId()));
            }
        }
        if (vo.getApplicationApproval() != null) {
            vo.getApplicationApproval().setApprover(userMap.get(vo.getApplicationApproval().getApproverId()));
        }
    }

    public boolean userExists(String userId) {
        if (oConvertUtils.isEmpty(userId)) {
            return false;
        }
        Integer n = jdbcTemplate.queryForObject("select count(1) from sys_user where id = ?", Integer.class, userId);
        return n != null && n > 0;
    }

    public boolean deptExists(String deptId) {
        if (oConvertUtils.isEmpty(deptId)) {
            return false;
        }
        Integer n = jdbcTemplate.queryForObject("select count(1) from sys_depart where id = ?", Integer.class, deptId);
        return n != null && n > 0;
    }

    //update-begin---author:spex ---date:2026-09-01  for：【提案管理】按部门名/提案人姓名查 id，列表用 MP in-----------
    /** 未传关键词返回 null（不加条件）；无匹配返回空列表 */
    public List<String> findDeptIdsByNameLike(String name) {
        if (oConvertUtils.isEmpty(name)) {
            return null;
        }
        return jdbcTemplate.queryForList(
                "select id from sys_depart where depart_name like concat('%', ?, '%')",
                String.class, name.trim());
    }

    public List<String> findUserIdsByRealnameLike(String name) {
        if (oConvertUtils.isEmpty(name)) {
            return null;
        }
        return jdbcTemplate.queryForList(
                "select id from sys_user where realname like concat('%', ?, '%')",
                String.class, name.trim());
    }
    //update-end---author:spex ---date:2026-09-01  for：【提案管理】按部门名/提案人姓名查 id，列表用 MP in-----------

    //update-begin---author:spex ---date:2026-09-03  for：【首页】部门·组别文案（对齐原型）-----------
    /**
     * 首页副标题：部门 · 组别。员工多挂在组别；挂部门级时只显示部门名。
     */
    public String buildUserDeptGroupDesc(String userId) {
        if (oConvertUtils.isEmpty(userId)) {
            return "";
        }
        String sql = "select leaf.org_type as leaf_type, leaf.depart_name as leaf_name, "
                + "parent.depart_name as parent_name "
                + "from sys_user_depart ud "
                + "join sys_depart leaf on leaf.id = ud.dep_id and leaf.del_flag = '0' "
                + "left join sys_depart parent on parent.id = leaf.parent_id and parent.del_flag = '0' "
                + "where ud.user_id = ? "
                + "order by case leaf.org_type when 'GROUP' then 0 when 'DEPT' then 1 else 2 end "
                + "limit 1";
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql, userId);
        if (rows.isEmpty()) {
            return "";
        }
        Map<String, Object> row = rows.get(0);
        String leafType = row.get("leaf_type") == null ? "" : String.valueOf(row.get("leaf_type"));
        String leafName = row.get("leaf_name") == null ? "" : String.valueOf(row.get("leaf_name")).trim();
        String parentName = row.get("parent_name") == null ? "" : String.valueOf(row.get("parent_name")).trim();
        if ("GROUP".equalsIgnoreCase(leafType) && oConvertUtils.isNotEmpty(parentName) && oConvertUtils.isNotEmpty(leafName)) {
            return parentName + " · " + leafName;
        }
        if (oConvertUtils.isNotEmpty(leafName)) {
            return leafName;
        }
        return parentName;
    }
    //update-end---author:spex ---date:2026-09-03  for：【首页】部门·组别文案（对齐原型）-----------

    public Map<String, UserBriefVo> loadUsers(Collection<String> userIds) {
        List<String> ids = distinctIds(userIds);
        if (ids.isEmpty()) {
            return Collections.emptyMap();
        }
        String sql = "select id, realname, work_no, username, position_type, org_code from sys_user where id in ("
                + placeholders(ids.size()) + ")";
        List<UserBriefVo> users = jdbcTemplate.query(sql, (rs, i) -> {
            UserBriefVo vo = new UserBriefVo();
            vo.setId(rs.getString("id"));
            vo.setRealname(rs.getString("realname"));
            String workNo = rs.getString("work_no");
            String username = rs.getString("username");
            vo.setWorkNo(oConvertUtils.isNotEmpty(workNo) ? workNo : username);
            vo.setUsername(username);
            vo.setPositionType(rs.getString("position_type"));
            vo.setOrgCode(rs.getString("org_code"));
            return vo;
        }, ids.toArray());
        Map<String, UserBriefVo> map = users.stream().collect(Collectors.toMap(UserBriefVo::getId, Function.identity(), (a, b) -> a));
        fillUserDeptNames(map);
        return map;
    }

    private void fillUserDeptNames(Map<String, UserBriefVo> userMap) {
        if (userMap.isEmpty()) {
            return;
        }
        Set<String> orgCodes = userMap.values().stream()
                .map(UserBriefVo::getOrgCode)
                .filter(oConvertUtils::isNotEmpty)
                .collect(Collectors.toCollection(LinkedHashSet::new));
        if (orgCodes.isEmpty()) {
            return;
        }
        Map<String, String> nameByOrg = loadDeptNamesByOrgCodes(orgCodes);
        for (UserBriefVo user : userMap.values()) {
            if (oConvertUtils.isNotEmpty(user.getOrgCode())) {
                user.setDeptName(nameByOrg.get(user.getOrgCode()));
            }
        }
    }

    private Map<String, DeptBriefVo> loadDeptsByIds(Collection<String> deptIds) {
        List<String> ids = distinctIds(deptIds);
        if (ids.isEmpty()) {
            return Collections.emptyMap();
        }
        String sql = "select id, depart_name, org_code from sys_depart where id in (" + placeholders(ids.size()) + ")";
        List<DeptBriefVo> depts = jdbcTemplate.query(sql, (rs, i) -> {
            DeptBriefVo vo = new DeptBriefVo();
            vo.setId(rs.getString("id"));
            vo.setDepartName(rs.getString("depart_name"));
            vo.setOrgCode(rs.getString("org_code"));
            return vo;
        }, ids.toArray());
        return depts.stream().collect(Collectors.toMap(DeptBriefVo::getId, Function.identity(), (a, b) -> a));
    }

    private Map<String, String> loadDeptNamesByOrgCodes(Collection<String> orgCodes) {
        List<String> codes = distinctIds(orgCodes);
        if (codes.isEmpty()) {
            return Collections.emptyMap();
        }
        String sql = "select org_code, depart_name from sys_depart where org_code in (" + placeholders(codes.size()) + ")";
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql, codes.toArray());
        return rows.stream().collect(Collectors.toMap(
                r -> String.valueOf(r.get("org_code")),
                r -> r.get("depart_name") == null ? "" : String.valueOf(r.get("depart_name")),
                (a, b) -> a));
    }

    private static <T> List<String> collect(List<T> rows, Function<T, String> getter) {
        Set<String> ids = new LinkedHashSet<>();
        for (T row : rows) {
            addId(ids, getter.apply(row));
        }
        return new ArrayList<>(ids);
    }

    private static void addId(Set<String> ids, String id) {
        if (oConvertUtils.isNotEmpty(id)) {
            ids.add(id);
        }
    }

    private static List<String> distinctIds(Collection<String> ids) {
        if (ids == null || ids.isEmpty()) {
            return Collections.emptyList();
        }
        Set<String> unique = new LinkedHashSet<>();
        for (String id : ids) {
            addId(unique, id);
        }
        return new ArrayList<>(unique);
    }

    private static String placeholders(int size) {
        return String.join(",", Collections.nCopies(size, "?"));
    }
}
