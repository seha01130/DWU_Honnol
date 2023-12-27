package model;

public class MemberInfo {
	private String nickname;
	private String memberId;
	private String profilePicture;
	private int rating;

	public MemberInfo() { }		// 기본 생성자
	
	public MemberInfo(String nickname,String memberId) {
		this.nickname = nickname;
		this.profilePicture = "";
		this.rating = 0;
		this.memberId = memberId; 
		
	}

	public MemberInfo(String nickname, String profilePicture, int rating, String memberId) {
		this.nickname = nickname;
		this.profilePicture = profilePicture;
		this.rating = rating;
		this.memberId = memberId; 
		
	}
	
	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
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
	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	@Override
	public String toString() {
		return "MemberInfo [memberId=" + memberId + ", nickname=" + nickname + "]";
	}
}
