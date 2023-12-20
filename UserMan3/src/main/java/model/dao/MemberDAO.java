package model.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Event;
import model.Member;
import model.MemberInfo;
import model.Post;

import java.util.*;

public class MemberDAO {
	private JDBCUtil jdbcUtil = null;

	public MemberDAO() {			
		jdbcUtil = new JDBCUtil();	// JDBCUtil 객체 생성
	}

	/**
	 * 사용자 관리 테이블에 새로운 사용자 생성.
	 */
	public int create(Member member) throws SQLException {
		String sql = "INSERT INTO Member VALUES (?, ?, ?, ?, ?)";		
		Object[] param = new Object[] { member.getMemberId(), 
				member.getPassword(), member.getEmail(), null, null };				
		jdbcUtil.setSqlAndParameters(sql, param);	// JDBCUtil 에 insert문과 매개 변수 설정

		try {				
			int result = jdbcUtil.executeUpdate();	// insert 문 실행
			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		} finally {		
			jdbcUtil.commit();
			jdbcUtil.close();	// resource 반환
		}		
		return 0;			
	}

	/**
	 * 기존의 멤버 정보를 수정.
	 */
	public int update1(Member member) throws SQLException {
		String sql = "UPDATE Member "
				+ "SET password=? "
				+ "WHERE memberId=?";
		Object[] param = new Object[] { member.getPassword(),
				member.getMemberId() };				
		jdbcUtil.setSqlAndParameters(sql, param);	// JDBCUtil에 update문과 매개 변수 설정

		try {				
			int result = jdbcUtil.executeUpdate();	// update 문 실행
			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		}
		finally {
			jdbcUtil.commit();
			jdbcUtil.close();	// resource 반환
		}		
		return 0;
	}
	
	/**
	 * 기존의 멤버인포 정보를 수정.
	 */
	public int update2(MemberInfo memberInfo) throws SQLException {
		String sql = "UPDATE MemberInfo "
				+ "SET nickname=?, profilePicture=? "
				+ "WHERE memberId=?";
		Object[] param = new Object[] { memberInfo.getNickname(), memberInfo.getProfilePicture(), 
				memberInfo.getMemberId() };		
		
		jdbcUtil.setSqlAndParameters(sql, param);	// JDBCUtil에 update문과 매개 변수 설정

		try {			
			int result = jdbcUtil.executeUpdate();	// update 문 실행
			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		}
		finally {
			jdbcUtil.commit();
			jdbcUtil.close();	// resource 반환
		}		
		return 0;
	}

	/**
	 * 사용자 ID에 해당하는 사용자를 삭제.
	 */
	public int remove(String memberId) throws SQLException {
		String sql = "DELETE FROM Member WHERE memberId=?";		
		jdbcUtil.setSqlAndParameters(sql, new Object[] { memberId });	// JDBCUtil에 delete문과 매개 변수 설정

		try {				
			int result = jdbcUtil.executeUpdate();	// delete 문 실행
			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		}
		finally {
			jdbcUtil.commit();
			jdbcUtil.close();	// resource 반환
		}		
		return 0;
	}


	/**
	 * 멤버가 작성한 포스트 목록을 현재 페이지와 페이지당 출력할 포스트 수를 이용하여
	 * 해당하는 포스트 정보만을 List에 저장하여 반환.
	 */
	//	public List<Post> getPostList(int memberId, int currentPage, int countPerPage) throws SQLException {
	//	    List<Post> posts = new ArrayList<>();
	//	    String sql = "SELECT * FROM Post WHERE memberId=?";
	//	    jdbcUtil.setSqlAndParameters(sql, new Object[]{ memberId });
	//
	//	    ResultSet rs = jdbcUtil.executeQuery();
	//
	//	    int start = ((currentPage - 1) * countPerPage) + 1;
	//
	//	    try {
	//	        // Move the cursor to the starting row
	//	        if ((start >= 0) && rs.absolute(start)) {
	//	            while ((rs.next()) && (countPerPage-- > 0)) {
	//	                Post post = new Post(
	//	                        rs.getInt("postId"),
	//	                        null,
	//	                        null,
	//	                        rs.getString("title"),
	//	                        rs.getString("image"),
	//	                        rs.getString("content"),
	//	                        memberId,
	//	                        null,
	//	                        null,
	//	                        null
	//	                );
	//	                posts.add(post);
	//	            }
	//	            return posts;
	//	        }
	//	    } catch (SQLException e) {
	//	        e.printStackTrace(); // 오류 처리 로직을 추가하세요.
	//	    } finally {
	//	        jdbcUtil.close(); // 리소스 반환
	//	    }
	//	    return null;
	//	}
	public List<Post> getPostList(String memberId) throws SQLException {
		List<Post> posts = new ArrayList<>();
		String sql = "SELECT * FROM Post WHERE memberId=?";
		jdbcUtil.setSqlAndParameters(sql, new Object[]{ memberId });

		ResultSet rs = jdbcUtil.executeQuery();

		try {
			// Move the cursor to the starting row
			while (rs.next()) {
				Post post = new Post(
						rs.getInt("postId"),
						0,
						null,
						rs.getString("title"),
						rs.getString("image"),
						rs.getString("content"),
						memberId,
						0,
						0
						//null
						);
				posts.add(post);
			}
			return posts;
		} catch (SQLException e) {
			e.printStackTrace(); // 오류 처리 로직을 추가하세요.
		} finally {
			jdbcUtil.close(); // 리소스 반환
		}
		return null;
	}

	public int applyForEvent(String memberId, int eventId) throws SQLException {
		// 멤버가 특정 이벤트에 신청하는 메서드
		String query = "INSERT INTO AppliedEvent VALUES (?, ?)";
		jdbcUtil.setSqlAndParameters(query, new Object[] { memberId, eventId });
		try {				
			int result = jdbcUtil.executeUpdate();	// insert 문 실행
			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		} finally {		
			jdbcUtil.commit();
			jdbcUtil.close();	// resource 반환
		}		
		return 0;			
	}

	public int cancelEventApplication(String memberId, int eventId) throws SQLException {
		// 멤버가 특정 이벤트 참여를 취소하는 메서드
		String query = "DELETE FROM AppliedEvent WHERE memberId=? AND eventId=?";
		jdbcUtil.setSqlAndParameters(query, new Object[]{ memberId, eventId });
		try {
			int result = jdbcUtil.executeUpdate();    // delete 문 실행
			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close();    // 리소스 반환
		}
		return 0;
	}

	public List<Member> getAttendeeIds(int eventId) throws SQLException {
		// 특정 이벤트에 참여한 멤버 ID 목록을 가져오는 메서드
		List<Member> attendeeIds = new ArrayList<>();
		String query = "SELECT memberId " +
				"FROM AppliedEvent " +
				"WHERE eventId=?";
		jdbcUtil.setSqlAndParameters(query, new Object[]{ eventId });
		try {
			ResultSet rs = jdbcUtil.executeQuery();

			while (rs.next()) {
				String memberId = rs.getString("memberId");
				Member member = new Member(
						memberId,
						rs.getString("password"),
						rs.getString("email"),
						getPostList(memberId), // 해당 멤버의 게시글 목록 가져오기
						getMyEvents(memberId));
				attendeeIds.add(member);
			}
			return attendeeIds;
		} catch (SQLException e) {
			e.printStackTrace(); // 오류 처리 로직을 추가하세요.
		} finally {
			jdbcUtil.close();        // 리소스 반환
		}
		return null;
	}

	/**
	 * 멤버가 신청한 이벤트 목록을 현재 페이지와 페이지당 출력할 이벤트 수를 이용하여
	 * 해당하는 이벤트 정보만을 List에 저장하여 반환.
	 */
	//	public List<Event> getMyEvents(int memberId, int currentPage, int countPerPage) throws SQLException {
	//		List<Event> appliedEvents = new ArrayList<>();
	//		String query = "SELECT * FROM AppliedEvent WHERE memberId=?";
	//		jdbcUtil.setSqlAndParameters(query, new Object[]{ memberId });
	//
	//		try {
	//			ResultSet resultSet = jdbcUtil.executeQuery();
	//
	//			int start = ((currentPage - 1) * countPerPage) + 1;
	//
	//			// Move the cursor to the starting row
	//			if ((start >= 0) && resultSet.absolute(start)) {
	//				while ((resultSet.next()) && (countPerPage-- > 0)) {
	//					Event event = new Event(
	//							resultSet.getInt("eventId"),
	//							memberId,
	//							resultSet.getString("title"),
	//							resultSet.getString("image"),
	//							null,
	//							resultSet.getString("content"),
	//							getAttendeeIds(resultSet.getInt("eventId")),
	//							null
	//							);
	//					appliedEvents.add(event);
	//				}
	//				return appliedEvents;
	//			}
	//		} catch (SQLException e) {
	//			e.printStackTrace(); // 오류 처리 로직을 추가하세요.
	//		} finally {
	//			jdbcUtil.close(); // 리소스 반환
	//		}
	//		return null;
	//	}

	public List<Event> getMyEvents(String memberId) throws SQLException {
		List<Event> appliedEvents = new ArrayList<>();
		String query = "SELECT * FROM AppliedEvent WHERE memberId=?";
		jdbcUtil.setSqlAndParameters(query, new Object[]{ memberId });

		try {
			ResultSet rs = jdbcUtil.executeQuery();
			// Move the cursor to the starting row
			while ((rs.next())) {
				Event event = new Event(
						rs.getInt("eventId"),
						0,//원래는 String형의 memberId
						rs.getString("title"),
						rs.getString("image"),
						null,
						rs.getString("content"),
						0,
						getAttendeeIds(rs.getInt("eventId"))
						);
				appliedEvents.add(event);
			}
			return appliedEvents;
		} catch (SQLException e) {
			e.printStackTrace(); // 오류 처리 로직을 추가하세요.
		} finally {
			jdbcUtil.close(); // 리소스 반환
		}
		return null;
	}



	public Member findMember(String memberId) throws SQLException {
		String query = "SELECT * FROM Member WHERE memberId=?";
		jdbcUtil.setSqlAndParameters(query, new Object[] { memberId });
		try {
			ResultSet rs = jdbcUtil.executeQuery();
			while (rs.next()) {
				Member member = new Member(
						rs.getString("memberId"),
						rs.getString("password"),
						rs.getString("email"),
						getPostList(memberId), // 해당 멤버의 게시글 목록 가져오기
						getMyEvents(memberId) // 해당 멤버의 이벤트 목록 가져오기
						);
				return member;
			}
		} catch (SQLException e) {
			e.printStackTrace(); // 오류 처리 로직을 추가하세요.
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return null;
	}

	
	public Member findProfile1(String memberId) throws SQLException {
		String query = "SELECT memberId, password FROM Member "
				+ "WHERE memberId=?";
		jdbcUtil.setSqlAndParameters(query, new Object[] { memberId });
		try {
			ResultSet rs = jdbcUtil.executeQuery();
			while (rs.next()) {
				Member member = new Member(
						rs.getString("memberId"),
						rs.getString("password"),
						null,
						null, null
						);
				return member;
			}
		} catch (SQLException e) {
			e.printStackTrace(); // 오류 처리 로직을 추가하세요.
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return null;
	}

	public MemberInfo findProfile2(String memberId) throws SQLException {
		String query = "SELECT memberId, nickname, profilePicture FROM MemberInfo "
				+ "WHERE memberId=?";
		jdbcUtil.setSqlAndParameters(query, new Object[] { memberId });
		try {
			ResultSet rs = jdbcUtil.executeQuery();
			while (rs.next()) {
				System.out.println("출력이 되니??????????");
				MemberInfo memberInfo = new MemberInfo(
						rs.getString("nickname"),
						rs.getString("profilePicture"),
						0,
						rs.getString("memberId")
						);
				return memberInfo;
			}
		} catch (SQLException e) {
			e.printStackTrace(); // 오류 처리 로직을 추가하세요.
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return null;
	}
	/**
	 * 전체 사용자 정보를 검색하여 List에 저장 및 반환
	 */
	public List<Member> findMemberList() throws SQLException {
		String sql = "SELECT * " +
				"FROM Member " +
				"ORDER BY memberId";
		jdbcUtil.setSqlAndParameters(sql, null);  // JDBCUtil에 query문 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery();            // query 실행            
			List<Member> memberList = new ArrayList<>();  // Member들의 리스트 생성
			while (rs.next()) {
				Member member = new Member(
						rs.getString("memberId"),
						rs.getString("password"),
						rs.getString("email"),
						getPostList(rs.getString("memberId")),
						getMyEvents(rs.getString("memberId"))
						);
				memberList.add(member);               // List에 Member 객체 저장
			}       
			return memberList;                     

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();        // resource 반환
		}
		return null;
	}


	/**
	 * 주어진 사용자 ID에 해당하는 사용자가 존재하는지 검사 
	 */
	public boolean existingMember(String memberId) throws SQLException {
		String sql = "SELECT count(*) FROM Member WHERE memberId=?";      
		jdbcUtil.setSqlAndParameters(sql, new Object[] { memberId });	// JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery();		// query 실행
			if (rs.next()) {
				int count = rs.getInt(1);
				return (count == 1 ? true : false);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return false;
	}
	
	public boolean existingMemberByEmail(String memberEmail) throws SQLException {
		String sql = "SELECT count(*) FROM Member WHERE memberEmail=?";      
		jdbcUtil.setSqlAndParameters(sql, new Object[] { memberEmail });	// JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery();		// query 실행
			if (rs.next()) {
				int count = rs.getInt(1);
				return (count == 1 ? true : false);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return false;
	}

}
