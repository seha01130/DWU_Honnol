package model.dao;

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

}
