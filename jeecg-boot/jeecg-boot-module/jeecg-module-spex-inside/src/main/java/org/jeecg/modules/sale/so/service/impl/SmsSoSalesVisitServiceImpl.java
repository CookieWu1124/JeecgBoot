package org.jeecg.modules.sale.so.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.jeecg.modules.sale.config.BaseException;
import org.jeecg.modules.sale.so.entity.SmsSoSalesVisit;
import org.jeecg.modules.sale.so.mapper.SmsSoSalesVisitMapper;
import org.jeecg.modules.sale.so.service.ISmsSoSalesVisitService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.jeecg.common.system.query.QueryGenerator;
import org.jeecg.modules.sale.so.utils.DictUtil;
import org.jeecg.modules.sale.so.utils.PreDealUtils;
import org.jeecg.modules.sale.so.vo.MyTodoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import static org.jeecg.modules.sale.so.constant.BaseConstant.ACTIVE_Y;

/**
 * @Description: 项目拜访跟进记录
 * @Author: jeecg-boot
 * @Date:   2026-08-01
 * @Version: V1.0
 */

@Service
public class SmsSoSalesVisitServiceImpl extends ServiceImpl<SmsSoSalesVisitMapper, SmsSoSalesVisit> implements ISmsSoSalesVisitService {

    @Autowired
    private DictUtil dictUtil;
    @Autowired
    private PreDealUtils preDealUtils;

    @Override
    public void saveMain(SmsSoSalesVisit smsSoSalesVisit) {
        if (StringUtils.isEmpty(smsSoSalesVisit.getProjectId())) {
            throw new BaseException("项目id不能为空");
        }
        this.save(smsSoSalesVisit);
    }

    @Override
    public void updateMain(SmsSoSalesVisit smsSoSalesVisit) {
        if (StringUtils.isEmpty(smsSoSalesVisit.getId())) {
            throw new BaseException("id不能为空");
        }
        this.updateById(smsSoSalesVisit);

    }

    @Override
    public List<SmsSoSalesVisit> exportList(SmsSoSalesVisit smsSoSalesVisit, Map<String, String[]> parameterMap) {
        QueryWrapper<SmsSoSalesVisit> queryWrapper = QueryGenerator.initQueryWrapper(smsSoSalesVisit, parameterMap);
        queryWrapper.eq("active", ACTIVE_Y);
        queryWrapper.orderByDesc("create_time");
        List<SmsSoSalesVisit> list = this.list(queryWrapper);
        if (CollectionUtils.isNotEmpty(list)) {
            list.forEach(ac->{
                ac.setVisitType(dictUtil.getNameByKey("sms_so_sales_visit_type", ac.getVisitType()));
            });
        }
        return list;
    }

    @Override
    public IPage<MyTodoVO> queryMyTodo(Page<MyTodoVO> page, String loginUserId) {
        // 3天
        return this.baseMapper.selectMyTodoList(page, loginUserId,3);
    }

    @Override
    public void comment(SmsSoSalesVisit smsSoSalesVisit) {
        SmsSoSalesVisit comment = new  SmsSoSalesVisit();
        preDealUtils.preDealEntityById(comment);
        comment.setId(smsSoSalesVisit.getId());
        comment.setCommentUserId(comment.getUpdateNo());
        comment.setCommentUserName(comment.getUpdateBy());
        comment.setCommentTime(new Date());
        comment.setVisitComment(smsSoSalesVisit.getVisitComment());
        this.updateById(comment);
    }
}
