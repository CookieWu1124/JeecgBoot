package org.jeecg.modules.proposal.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.jeecg.modules.proposal.entity.ProposalImprovementType;

/**
 * 改善性质 Mapper
 */
public interface ProposalImprovementTypeMapper extends BaseMapper<ProposalImprovementType> {

    /** 未被提案引用时物理删除，释放 type_code 唯一索引 */
    @Delete("DELETE FROM proposal_improvement_type WHERE id = #{id}")
    int physicalDeleteById(@Param("id") String id);
}
