package org.jeecg.modules.sale.so.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import org.jeecg.modules.sale.so.entity.SmsSoSalesVisit;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.jeecg.modules.sale.so.vo.MyTodoVO;

/**
 * @Description: 项目拜访跟进记录
 * @Author: jeecg-boot
 * @Date:   2026-08-01
 * @Version: V1.0
 */
public interface SmsSoSalesVisitMapper extends BaseMapper<SmsSoSalesVisit> {

    IPage<MyTodoVO> selectMyTodoList(Page<MyTodoVO> page, @Param("saleUserId") String saleUserId, @Param("days") int days);
}
