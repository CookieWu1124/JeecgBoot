package org.jeecg.modules.proposal.service.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jeecg.common.exception.JeecgBootBizTipException;
import org.jeecg.common.util.oConvertUtils;
import org.jeecg.modules.proposal.entity.Proposal;
import org.jeecg.modules.proposal.entity.ProposalImprovementType;
import org.jeecg.modules.proposal.mapper.ProposalImprovementTypeMapper;
import org.jeecg.modules.proposal.mapper.ProposalMapper;
import org.jeecg.modules.proposal.service.IProposalImprovementTypeService;
import org.jeecg.modules.proposal.vo.ImprovementTypeOption;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
public class ProposalImprovementTypeServiceImpl extends ServiceImpl<ProposalImprovementTypeMapper, ProposalImprovementType>
        implements IProposalImprovementTypeService {

    private static final Pattern TYPE_CODE_PATTERN = Pattern.compile("^[A-Za-z][A-Za-z0-9_]{0,31}$");
    private static final String STATUS_ACTIVE = "active";

    @Autowired
    private ProposalMapper proposalMapper;

    @Override
    public List<ImprovementTypeOption> listOptions(boolean enabledOnly) {
        LambdaQueryWrapper<ProposalImprovementType> qw = new LambdaQueryWrapper<ProposalImprovementType>()
                .orderByAsc(ProposalImprovementType::getSortNo)
                .orderByAsc(ProposalImprovementType::getTypeCode);
        if (enabledOnly) {
            qw.eq(ProposalImprovementType::getTypeStatus, STATUS_ACTIVE);
        }
        return list(qw).stream().map(this::toOption).collect(Collectors.toList());
    }

    @Override
    public void assertEnabledCodes(String improvementTypesJson) {
        List<String> codes = parseCodes(improvementTypesJson);
        if (codes.isEmpty()) {
            throw new JeecgBootBizTipException("请选择改善性质");
        }
        List<ProposalImprovementType> enabled = list(new LambdaQueryWrapper<ProposalImprovementType>()
                .eq(ProposalImprovementType::getTypeStatus, STATUS_ACTIVE));
        if (enabled.isEmpty()) {
            throw new JeecgBootBizTipException("改善性质尚未配置，请联系管理员");
        }
        Map<String, String> enabledNames = enabled.stream()
                .collect(Collectors.toMap(ProposalImprovementType::getTypeCode, ProposalImprovementType::getTypeName, (a, b) -> a));
        Map<String, String> allNames = list().stream()
                .collect(Collectors.toMap(ProposalImprovementType::getTypeCode, ProposalImprovementType::getTypeName, (a, b) -> a));
        for (String code : codes) {
            if (!enabledNames.containsKey(code)) {
                String name = allNames.getOrDefault(code, code);
                throw new JeecgBootBizTipException("改善性质「" + name + "」已停用或无效，请重新选择");
            }
        }
    }

    @Override
    public void attachTypeLabels(Collection<Proposal> proposals) {
        if (proposals == null || proposals.isEmpty()) {
            return;
        }
        Map<String, String> nameMap = list().stream().collect(Collectors.toMap(
                ProposalImprovementType::getTypeCode,
                ProposalImprovementType::getTypeName,
                (a, b) -> a,
                LinkedHashMap::new));
        for (Proposal proposal : proposals) {
            if (proposal == null) {
                continue;
            }
            proposal.setImprovementTypesLabel(formatLabel(proposal.getImprovementTypes(), nameMap));
        }
    }

    @Override
    public void saveConfig(ProposalImprovementType entity) {
        if (entity == null) {
            throw new JeecgBootBizTipException("参数不能为空");
        }
        if (oConvertUtils.isEmpty(entity.getTypeName())) {
            throw new JeecgBootBizTipException("请填写性质名称");
        }
        entity.setTypeName(entity.getTypeName().trim());
        if (oConvertUtils.isEmpty(entity.getTypeStatus())) {
            entity.setTypeStatus(STATUS_ACTIVE);
        }
        if (entity.getSortNo() == null) {
            entity.setSortNo(0);
        }
        if (oConvertUtils.isNotEmpty(entity.getId())) {
            ProposalImprovementType db = getById(entity.getId());
            if (db == null) {
                throw new JeecgBootBizTipException("改善性质不存在");
            }
            entity.setTypeCode(db.getTypeCode());
        } else {
            if (oConvertUtils.isEmpty(entity.getTypeCode())) {
                throw new JeecgBootBizTipException("请填写性质编码");
            }
            entity.setTypeCode(entity.getTypeCode().trim());
            if (!TYPE_CODE_PATTERN.matcher(entity.getTypeCode()).matches()) {
                throw new JeecgBootBizTipException("性质编码须以字母开头，仅含字母数字下划线");
            }
            long dup = count(new LambdaQueryWrapper<ProposalImprovementType>()
                    .eq(ProposalImprovementType::getTypeCode, entity.getTypeCode()));
            if (dup > 0) {
                throw new JeecgBootBizTipException("性质编码已存在");
            }
        }
        saveOrUpdate(entity);
    }

    @Override
    public void deleteConfig(String id) {
        if (oConvertUtils.isEmpty(id)) {
            throw new JeecgBootBizTipException("id 不能为空");
        }
        ProposalImprovementType db = getById(id);
        if (db == null) {
            throw new JeecgBootBizTipException("改善性质不存在");
        }
        Long used = proposalMapper.selectCount(new LambdaQueryWrapper<Proposal>()
                .like(Proposal::getImprovementTypes, "\"" + db.getTypeCode() + "\""));
        if (used != null && used > 0) {
            throw new JeecgBootBizTipException("已有提案使用该性质，请改为停用而非删除");
        }
        // 未被引用时物理删除，释放唯一索引，便于重新使用同一编码
        getBaseMapper().physicalDeleteById(id);
    }

    private ImprovementTypeOption toOption(ProposalImprovementType entity) {
        ImprovementTypeOption opt = new ImprovementTypeOption();
        opt.setCode(entity.getTypeCode());
        opt.setLabel(entity.getTypeName());
        opt.setTypeStatus(entity.getTypeStatus());
        opt.setSortNo(entity.getSortNo());
        opt.setDescription(entity.getDescription());
        return opt;
    }

    static List<String> parseCodes(String raw) {
        if (oConvertUtils.isEmpty(raw)) {
            return new ArrayList<>();
        }
        String text = raw.trim();
        try {
            List<String> parsed = JSON.parseArray(text, String.class);
            if (parsed != null) {
                return parsed.stream()
                        .filter(oConvertUtils::isNotEmpty)
                        .map(String::trim)
                        .filter(s -> !s.isEmpty())
                        .collect(Collectors.toList());
            }
        } catch (Exception ignored) {
            // 兼容逗号串
        }
        String stripped = text.replaceAll("^\\[|]$", "");
        List<String> codes = new ArrayList<>();
        for (String part : stripped.split("[,，/|]")) {
            String code = part.replaceAll("[\"'\\s]", "");
            if (!code.isEmpty()) {
                codes.add(code);
            }
        }
        return codes;
    }

    private String formatLabel(String raw, Map<String, String> nameMap) {
        List<String> codes = parseCodes(raw);
        if (codes.isEmpty()) {
            return null;
        }
        return codes.stream()
                .map(c -> nameMap.getOrDefault(c, c))
                .collect(Collectors.joining(" / "));
    }
}
