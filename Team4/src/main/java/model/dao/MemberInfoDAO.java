package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import model.MemberInfo;

public class MemberInfoDAO {
	private JDBCUtil jdbcUtil = null;

	public MemberInfoDAO() {			
		jdbcUtil = new JDBCUtil();	// JDBCUtil 객체 생성
	}

	/* 사용자 정보 관리 테이블(MemberInfo)에 새로운 사용자 생성. */
	public int create(MemberInfo memberInfo) throws SQLException {
		String sql = "INSERT INTO MemberInfo VALUES (?, ?, ?, ?)";		
		Object[] param = new Object[] { 
				memberInfo.getNickname(), 
				memberInfo.getProfilePicture(), 
				memberInfo.getRating(),  
				memberInfo.getMemberId() };				
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
	public MemberInfo findProfileByNickname(String nickname) throws SQLException {
		String query = "SELECT memberId, nickname, profilePicture FROM MemberInfo "
				+ "WHERE nickname=?";
		jdbcUtil.setSqlAndParameters(query, new Object[] { nickname });
		try {
			ResultSet rs = jdbcUtil.executeQuery();
			while (rs.next()) {
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
	public MemberInfo findProfileById(String memberId) throws SQLException {
		String query = "SELECT memberId, nickname, profilePicture FROM MemberInfo "
				+ "WHERE memberId=?";
		jdbcUtil.setSqlAndParameters(query, new Object[] { memberId });
		try {
			ResultSet rs = jdbcUtil.executeQuery();
			while (rs.next()) {
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

}
