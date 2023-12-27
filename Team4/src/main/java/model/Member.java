package model;

import java.util.List;

public class Member {
	private String memberId;
	private String password;
	private String email;
	private List<Post> posts;
	private List<Event> events;

	public Member() { }		// 기본 생성자
	
	public Member(String memberId, String password, String email, List<Post> posts, List<Event> events) {
		this.memberId = memberId; 
		this.password = password;
		this.email = email;
		this.posts = posts;
		this.events = events;
	}
	
	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public List<Post> getPosts() {
		return posts;
	}

	public void setPosts(List<Post> posts) {
		this.posts = posts;
	}

	public List<Event> getEvents() {
		return events;
	}
	
	public void setEvents(List<Event> events) {
		this.events = events;
	}
	
	/* 비밀번호 검사 */
	public boolean matchPassword(String password) {
		if (password == null) {
			return false;
		}
		return this.password.equals(password);
	}
	
	public boolean isSameMember(String memberId) {
		return this.memberId.equals(memberId);
    }

	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", password=" + password
				+ ", email=" + email + ", posts=" + posts + ", events=" + events + "]";
	}
}
