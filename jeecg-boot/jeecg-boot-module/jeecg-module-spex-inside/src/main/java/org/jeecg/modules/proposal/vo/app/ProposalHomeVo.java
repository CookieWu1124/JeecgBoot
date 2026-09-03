package org.jeecg.modules.proposal.vo.app;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
@Schema(description = "app home")
public class ProposalHomeVo {

    private String greeting;
    private String userName;
    private String deptDesc;
    /** 首页小广播标语；空则前端不展示 */
    private String broadcastSlogan;
    private long todoCount;
    private long doingCount;
    private long approvedCount;
    private List<TodoItem> todoItems = new ArrayList<>();
    private List<FeedItem> feeds = new ArrayList<>();
    /** 与我相关的未读动态数（铃铛角标） */
    private long unreadCount;

    @Data
    public static class TodoItem {
        private String proposalId;
        private String proposalNo;
        private String title;
        private String status;
        private String statusLabel;
        private String actionHint;
        /** review=委员待审，approve=批准人待核定，assign=部门负责人待指派 */
        private String kind;
    }

    @Data
    public static class FeedItem {
        private String proposalId;
        private String proposalNo;
        private String title;
        private String action;
        private String actionLabel;
        private String remark;
        private String time;
    }
}
