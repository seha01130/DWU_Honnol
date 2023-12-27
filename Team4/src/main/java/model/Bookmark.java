package model;

public class Bookmark {
	
	    private int postId;
	    private String memberId;
	    
	    public Bookmark() {}   // 기본 생성자
	    
	    public Bookmark(int postId, String memberId) {
	        super();
	        this.postId = postId;
	        this.memberId = memberId;
	    }

	    public int getPostId() {
	        return postId;
	    }

	    public void setPostId(int postId) {
	        this.postId = postId;
	    }

	    public String getMemberId() {
	        return memberId;
	    }

	    public void setMemberId(String memberId) {
	        this.memberId = memberId;
	    }     
}
