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
    private long todoCount;
    private long doingCount;
    private long doneCount;
    private List<TodoItem> todoItems = new ArrayList<>();
    private List<FeedItem> feeds = new ArrayList<>();

    @Data
    public static class TodoItem {
        private String proposalId;
        private String proposalNo;
        private String title;
        private String status;
        private String statusLabel;
        private String actionHint;
    }

    @Data
    public static class FeedItem {
        private String proposalId;
        private String proposalNo;
        private String title;
        private String action;
        private String remark;
        private String time;
    }
}
