package model.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Event;
import model.Member;
import model.Post;
import model.MemberInfo;
import model.dao.EventDAO;
import model.dao.MemberDAO;
import model.dao.PostDAO;

/**
 * 사용자 관리 API를 사용하는 개발자들이 직접 접근하게 되는 클래스.
 * UserDAO를 이용하여 데이터베이스에 데이터 조작 작업이 가능하도록 하며,
 * 데이터베이스의 데이터들을 이용하여 비지니스 로직을 수행하는 역할을 한다.
 * 비지니스 로직이 복잡한 경우에는 비지니스 로직만을 전담하는 클래스를 
 * 별도로 둘 수 있다.
 */
public class MemberManager {
	private static MemberManager userMan = new MemberManager();
	private MemberDAO memberDAO;
	private PostDAO postDAO;
	private EventDAO eventDAO;
	private MemberManager() {
		try {
			memberDAO = new MemberDAO();
		} catch (Exception e) {
			e.printStackTrace();
		}			
	}
	
	public static MemberManager getInstance() {
		return userMan;
	}
	
	public int create(Member member) throws SQLException, ExistingMemberException {
		if (memberDAO.existingMember(member.getMemberId()) == true) {
			throw new ExistingMemberException(member.getMemberId() + "는 존재하는 아이디입니다.");
		}
		return memberDAO.create(member);
	}

	/* 프로필 수정 */
	public int update1(Member member) throws SQLException, MemberNotFoundException {
		return memberDAO.update1(member);
	}

	public int update2(MemberInfo memberInfo) throws SQLException, MemberNotFoundException {
		return memberDAO.update2(memberInfo);
	}	

	
	public int remove(String deleteId) throws SQLException, MemberNotFoundException {
		
		// 사용자가 작성한 게시글의 postId를 null로 업데이트
		List<Post> memberPosts = memberDAO.getPostList(deleteId);
		for (Post post : memberPosts) {
			post.setPostId(0);
			postDAO.updatePost(post);
		}

		// 사용자가 참여한 이벤트의 eventId를 null로 업데이트
		List<Event> memberEvents = memberDAO.getMyEvents(deleteId);
		for (Event event : memberEvents) {
			event.setEventId(0);
			eventDAO.updateEvent(event);
		}
		return memberDAO.remove(deleteId);
	}
	
	public Member findMember(String memberId)
			throws SQLException, MemberNotFoundException {
			Member member = memberDAO.findMember(memberId);
			if (member == null) {
				throw new MemberNotFoundException(memberId + "는 존재하지 않는 아이디입니다.");
			}		
			return member;
		}
	
		//수정하려는 멤버 정보 전달-password
	public Member findProfile1(String memberId) throws SQLException {
		return memberDAO.findProfile1(memberId);
	}
		
	//수정하려는 멤버인포 정보 전달-nickname, profilePicture
	public MemberInfo findProfile2(String memberId) throws SQLException {
		return memberDAO.findProfile2(memberId);
	}
	
	public List<Member> findMemberList() throws SQLException {
			return memberDAO.findMemberList();
	}
	
	public Boolean findMemberList(String memberId) throws SQLException {
		return memberDAO.existingMember(memberId);
	}
	
	public List<Post> getPostList(String memberId) throws SQLException, MemberNotFoundException {
		List<Post> memberPosts = memberDAO.getPostList(memberId);
		return memberPosts;
	}
	
	//필요한가? 필요하면 아래 참고하여 작성하기
	//public List<Member> findMemberList(int currentPage, int countPerPage)
	//	throws SQLException {
	//	return memberDAO.findMemberList(currentPage, countPerPage); ?????????
	//}

//	public List<User> findUserList(int currentPage, int countPerPage) throws SQLException {
//		String sql = "SELECT userId, name, email, NVL(commId, 0) AS commId, cName " 
//					+ "FROM USERINFO u LEFT OUTER JOIN Community c ON u.commId = c.cId "
//					+ "ORDER BY userId";
//		jdbcUtil.setSqlAndParameters(sql, null,					// JDBCUtil에 query문 설정
//				ResultSet.TYPE_SCROLL_INSENSITIVE,				// cursor scroll 가능
//				ResultSet.CONCUR_READ_ONLY);						
//		
//		try {
//			ResultSet rs = jdbcUtil.executeQuery();				// query 실행			
//			int start = ((currentPage-1) * countPerPage) + 1;	// 출력을 시작할 행 번호 계산
//			if ((start >= 0) && rs.absolute(start)) {			// 커서를 시작 행으로 이동
//				List<User> userList = new ArrayList<User>();	// User들의 리스트 생성
//				do {
//					User user = new User(			// User 객체를 생성하여 현재 행의 정보를 저장
//						rs.getString("userId"),
//						null,
//						rs.getString("name"),
//						rs.getString("email"),
//						null,
//						rs.getInt("commId"),
//						rs.getString("cName"));
//					userList.add(user);							// 리스트에 User 객체 저장
//				} while ((rs.next()) && (--countPerPage > 0));		
//				return userList;							
//			}
//		} catch (Exception ex) {
//			ex.printStackTrace();
//		} finally {
//			jdbcUtil.close();		// resource 반환
//		}
//		return null;
//	}
	public boolean login(String memberId, String password)
		throws SQLException, MemberNotFoundException, PasswordMismatchException {
		Member member = findMember(memberId);

		if (!member.matchPassword(password)) {
			throw new PasswordMismatchException("비밀번호가 일치하지 않습니다.");
		}
		return true;
	}

	/* 아이디 중복 확인 */ 
	public boolean IsDuplicatedMemberId(String memberId) {
		try {
			return memberDAO.existingMember(memberId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	/* 이메일 중복 확인 */
	public boolean IsDuplicatedMemberEmail(String memberEmail) {
		try {
			return memberDAO.existingMember(memberEmail);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	public MemberDAO getMemberDAO() {
		return this.memberDAO;
	}

	public void update(Member updateMember) {
		// TODO Auto-generated method stub
		
	}
}
