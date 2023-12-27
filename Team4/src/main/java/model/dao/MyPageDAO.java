package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import model.MemberInfo;
import model.Post;

public class MyPageDAO {
    private JDBCUtil jdbcUtil = null;
    
    public MyPageDAO() {         
        jdbcUtil = new JDBCUtil();  // JDBCUtil 객체 생성
    }
        
	public MemberInfo showMyPage(String memberId) throws SQLException {//replies는 getReplies메소드 사용해서 가져와. jsp에서 findPost호출하고 그 아래에서 getReplies호출하면 되나..?
        String sql = "SELECT nickname, profilePicture, rating, memberId "
                    + "FROM MemberInfo "
                    + "WHERE memberId=?";              
        jdbcUtil.setSqlAndParameters(sql, new Object[] {memberId});   // JDBCUtil에 query문과 매개 변수 설정
        MemberInfo memberInfo = null;
        try {
            ResultSet rs = jdbcUtil.executeQuery();     // query 실행
            if (rs.next()) {
            	memberInfo = new MemberInfo(  
                    rs.getString("nickname"),
                    rs.getString("profilePicture"),
                    rs.getInt("rating"),
                    rs.getString("memberId"));
                    }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            jdbcUtil.close();
        }
        return memberInfo;
    }
}
