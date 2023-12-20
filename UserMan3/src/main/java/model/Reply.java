package model;

import java.util.Date;

public class Reply {
    private int replyId;
    private String content;
    private Date createDate;
    private int postId;
    private String memberId;
        
    public Reply() {}
    
    public Reply(int replyId, String content, Date createDate, int postId, String memberId) {
        super();
        this.replyId = replyId;
        this.content = content;
        this.createDate = createDate;
        this.postId = postId;
        this.memberId = memberId;
            }

    public int getReplyId() {
        return replyId;
    }

    public void setReplyId(int replyId) {
        this.replyId = replyId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }
    
    
}
