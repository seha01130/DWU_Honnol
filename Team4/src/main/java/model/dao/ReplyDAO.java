package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import model.Post;
import model.Reply;

public class ReplyDAO {
	private JDBCUtil jdbcUtil = null;
	    
	public ReplyDAO() {         
		jdbcUtil = new JDBCUtil();  // JDBCUtil 객체 생성
	}
	
	 public Reply createReply(Reply reply) throws SQLException {
	        String sql = "INSERT INTO Reply VALUES (SEQUENCE_REPLYID.nextval, ?, SYSDATE, ?, ?)";      
	        Object[] param = new Object[] { reply.getContent(), reply.getPostId(),
	              reply.getMemberId()};   
	        jdbcUtil.setSqlAndParameters(sql, param);   
	         
	        String key[] = {"replyId"};    
	        try {    
	            //jdbcUtil.executeUpdate();만 사용하면 데이터베이스에 레코드가 삽입되지만,
	            //생성된 키를 확인하고자 할 때는 getGeneratedKeys()를 사용하는 것이 일반적인 패턴
	              jdbcUtil.executeUpdate(key); //레코드 삽업
	              ResultSet rs = jdbcUtil.getGeneratedKeys(); //삽입된 레코드의 생성된 키를 검색
	              if(rs.next()) {
	                 int generatedKey = rs.getInt(1);  //다음 시퀀스 값으로 생성된 postId를 가져와(첫 번째 행의 값을 가져와)
	                 reply.setReplyId(generatedKey);     //post 객체에 설정
	              }
	              
	              return reply;   //왜 주키를 post객체에 담아서 리턴해주지..? 상세페이지로 redirection되니까 그때 postId 꺼내서 그걸로 findPost()호출하려고?
	        } catch (Exception ex) {
	           jdbcUtil.rollback();
	           ex.printStackTrace();
	        } finally {      
	           jdbcUtil.commit();
	           jdbcUtil.close();
	        }      
	        return null;         
	     }
}
