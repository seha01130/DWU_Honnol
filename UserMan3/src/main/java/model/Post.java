package model;

import java.util.Date;
import java.util.List;

public class Post {
    private int postId;
    private int isPublic;
    private Date createDate;
    private String title;
    private String image;
    private String content;
    private String memberId;
    private int locationId;
    private int myBookmarks;
    private String nickname;
    private String profilePicture;
    
    private List<Reply> replyList;
    
    public Post() {}   // 기본 생성자
    
    public Post(int postId, int isPublic, Date createDate, String title, String image, String content, String memberId,
            int loactionId, int myBookmarks, String nickname, String profilePicture) {
        super();
        this.postId = postId;
        this.isPublic = isPublic;
        this.createDate = createDate;
        this.title = title;
        this.image = image;
        this.content = content;
        this.memberId = memberId;
        this.locationId = loactionId;
        this.myBookmarks = myBookmarks;
        this.nickname = nickname;
        this.profilePicture = profilePicture;
    }

    public Post(int postId, int isPublic, Date createDate, String title, String image, String content, String memberId,
            int locationId, int myBookmarks) {
        super();
        this.postId = postId;
        this.isPublic = isPublic;
        this.createDate = createDate;
        this.title = title;
        this.image = image;
        this.content = content;
        this.memberId = memberId;
        this.locationId = locationId;
        this.myBookmarks = myBookmarks;
    }

    public Post(int postId, int isPublic, String title, String content) {
        super();
        this.postId = postId;
        this.isPublic = isPublic;
        this.title = title;
        this.content = content;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getIsPublic() {
        return isPublic;
    }

    public void setIsPublic(int isPublic) {
        this.isPublic = isPublic;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public int getMyBookmarks() {
        return myBookmarks;
    }

    public void setMyBookmarks(int myBookmarks) {
        this.myBookmarks = myBookmarks;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getProfilePicture() {
        return profilePicture;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }

    public List<Reply> getReplyList() {
        return replyList;
    }

    public void setReplyList(List<Reply> replyList) {
        this.replyList = replyList;
    }        
}
