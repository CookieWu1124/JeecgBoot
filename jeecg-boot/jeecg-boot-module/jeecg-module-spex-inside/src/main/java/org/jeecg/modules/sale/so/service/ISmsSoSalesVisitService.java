package org.jeecg.modules.sale.so.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.jeecg.modules.sale.so.entity.SmsSoSalesVisit;
import com.baomidou.mybatisplus.extension.service.IService;
import org.jeecg.modules.sale.so.vo.MyTodoVO;

import java.util.List;
import java.util.Map;

/**
 * @Description: 项目拜访跟进记录
 * @Author: jeecg-boot
 * @Date:   2026-08-01
 * @Version: V1.0
 */
public interface ISmsSoSalesVisitService extends IService<SmsSoSalesVisit> {

    void saveMain(SmsSoSalesVisit smsSoSalesVisit);

    void updateMain(SmsSoSalesVisit smsSoSalesVisit);

    List<SmsSoSalesVisit> exportList(SmsSoSalesVisit smsSoSalesVisit, Map<String, String[]> parameterMap);

    IPage<MyTodoVO> queryMyTodo(Page<MyTodoVO> page, String loginUserId);

    void comment(SmsSoSalesVisit smsSoSalesVisit);
}
