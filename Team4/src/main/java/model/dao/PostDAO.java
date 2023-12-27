package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Post;
import model.Reply;

public class PostDAO {
    private JDBCUtil jdbcUtil = null;
    
    public PostDAO() {         
        jdbcUtil = new JDBCUtil();  // JDBCUtil 객체 생성
    }
    
    /**
     * locationId 이미 있는지 비교하고 locationId 반환
     */
    public int searchLocationId(String locationAddress) throws SQLException {
                
        String sql = "SELECT locationId FROM location WHERE address=?";
        jdbcUtil.setSqlAndParameters(sql, new Object[] {locationAddress});   // JDBCUtil에 query문과 매개 변수 설정
        
        try {
            ResultSet rs = jdbcUtil.executeQuery();     // query 실행
            if (rs.next()) {                        // 게시글 정보 발견
                return rs.getInt("locationId");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            jdbcUtil.close();       // resource 반환
        }
        return 0;
    }
    
    /**
     * locationId 새로 생성해서 DB에 새로운 행 추가
     */
    public int saveLocationId(String locationName, String locationAddress) throws SQLException {
                
        String sql = "INSERT INTO location VALUES(SEQUENCE_LOCATIONID.nextval, ?, ?)";
        Object[] param = new Object[] {locationName, locationAddress};   
          jdbcUtil.setSqlAndParameters(sql, param);  
        
        String key[] = {"locationId"};
        try {
            jdbcUtil.executeUpdate(key);     // query 실행
            ResultSet rs = jdbcUtil.getGeneratedKeys(); //삽입된 레코드의 생성된 키를 검색
            if(rs.next()) {
               int generatedKey = rs.getInt(1);  //다음 시퀀스 값으로 생성된 locationId를 가져와(첫 번째 행의 값을 가져와)
               return generatedKey;     //locationId값 리턴
            }
        } catch (Exception ex) {
            jdbcUtil.rollback();
            ex.printStackTrace();
        } finally {
            jdbcUtil.commit();
            jdbcUtil.close();       // resource 반환
        }
        return 0;
    }
        
    /**
     * 게시글 테이블에 새로운 행 생성 (PK 값은 Sequence를 이용하여 자동 생성)
     */
    public Post createPost(Post post) throws SQLException {
        String sql = "INSERT INTO Post VALUES (Sequence_PostId.nextval, ?, SYSDATE, ?, ?, ?, ?, ?, ?)";      
        Object[] param = new Object[] { post.getIsPublic(), post.getTitle(), post.getImage(),
              post.getContent(), post.getMemberId(), post.getLocationId(), 0};   
        jdbcUtil.setSqlAndParameters(sql, param);   
        
        String key[] = {"postId"};    
        try {    
            //jdbcUtil.executeUpdate();만 사용하면 데이터베이스에 레코드가 삽입되지만,
            //생성된 키를 확인하고자 할 때는 getGeneratedKeys()를 사용하는 것이 일반적인 패턴
              jdbcUtil.executeUpdate(key); //레코드 삽업
              ResultSet rs = jdbcUtil.getGeneratedKeys(); //삽입된 레코드의 생성된 키를 검색
              if(rs.next()) {
                 int generatedKey = rs.getInt(1);  //다음 시퀀스 값으로 생성된 postId를 가져와(첫 번째 행의 값을 가져와)
                 post.setPostId(generatedKey);     //post 객체에 설정
              }
              
              return post;   //왜 주키를 post객체에 담아서 리턴해주지..? 상세페이지로 redirection되니까 그때 postId 꺼내서 그걸로 findPost()호출하려고?
        } catch (Exception ex) {
           jdbcUtil.rollback();
           ex.printStackTrace();
        } finally {      
           jdbcUtil.commit();
           jdbcUtil.close();
        }      
        return null;         
     }
    
    /**
     * 주어진  postId에 해당하는 Post 정보를 데이터베이스에서 찾아 Post 도메인 클래스에 저장하여 반환.
     * 게시글 상세페이지 보기에서 사용
     */
    public Post findPost(int postId) throws SQLException {//replies는 getReplies메소드 사용해서 가져와. jsp에서 findPost호출하고 그 아래에서 getReplies호출하면 되나..?
        String sql = "SELECT P.postId, P.isPublic, P.createDate, P.title, P.image, P.content, P.memberId, P.locationId, L.name, L.address, P.myBookmarks, M.nickname, M.profilePicture "
                + "FROM Post P "
                + "INNER JOIN MemberInfo M ON P.memberId = M.memberId "
                + "INNER JOIN Location L ON P.locationId = L.locationId "
                + "WHERE P.postId=?";
        
        jdbcUtil.setSqlAndParameters(sql, new Object[] {postId});   // JDBCUtil에 query문과 매개 변수 설정
        Post post = null;
        try {
            ResultSet rs = jdbcUtil.executeQuery();     // query 실행
            if (rs.next()) {                        // 게시글 정보 발견
                post = new Post(       // Post 객체를 생성하여 게시글 정보를 저장
                        postId,
                    rs.getInt("isPublic"),
                    rs.getDate("createDate"),
                    rs.getString("title"),
                    rs.getString("image"),
                    rs.getString("content"),
                    rs.getString("memberId"),
                    rs.getInt("locationId"),
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getInt("myBookmarks"),
                    rs.getString("nickname"),
                    rs.getString("profilePicture"));
           }
            if(post == null) 
            	System.out.println("post못 받아오고 있음 ");
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            jdbcUtil.close();       // resource 반환
        }
        return post;
    }
    
    /**Post가 갖고있는 replies 가져오기
     * 게시글 상세페이지 보기에서 사용. 게시글 하나 당 여러개의 댓글이 있을 수 있음
     */    
    public List<Reply> getReplies(int postId) {  
        String sql = "SELECT R.replyId, R.content, R.createDate, R.memberId, M.nickname, M.profilePicture "
                + "FROM Reply R "
        		+ "INNER JOIN MemberInfo M ON R.memberId = M.memberId "
                + "WHERE R.postId = ?";              
    jdbcUtil.setSqlAndParameters(sql, new Object[] {postId});   // JDBCUtil에 query문과 매개 변수 설정   
        
    System.out.println("postId값 잘 오냐?" + postId);
    
        try {
            ResultSet rs = jdbcUtil.executeQuery();
            
            List<Reply> replyList = new ArrayList<Reply>();    
            
            System.out.println("try문 안으로는 들어와?");
            while (rs.next()) {     // 커서를 통해 한 행씩 fetch
                Reply reply = new Reply(
                        rs.getInt("replyId"),
                        rs.getString("content"),
                        rs.getDate("createDate"),
                        postId,
                        rs.getString("memberId"),
                        rs.getString("nickname"),
                        rs.getString("profilePicture"));
                System.out.println("댓글 잘 가져오냐?" + rs.getString("nickname"));
                replyList.add(reply);
            } 
            System.out.println("select를 못하나봐");
            return replyList;     // 질의 결과 반환 (질의 결과가 없을 경우 빈 리스트 반환)
            
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("오류떠요?");
        } finally {
            jdbcUtil.close();       // ResultSet, PreparedStatement, Connection 등 해제
        }
        return null;
    }
    
    /**
     * 전체 게시글 정보를 검색하여 List에 저장 및 반환
        
    public List<Post> findPostList() throws SQLException {
        String sql = "SELECT postId, isPublic, createDate, title, image, content, m.memberId "
                + "FROM Post p INNER JOIN Member m ON p.memberId = m.memberId ";

        jdbcUtil.setSqlAndParameters(sql, null);

        try {
            ResultSet rs = jdbcUtil.executeQuery();
            List<Post> postList = new ArrayList<>();

            while (rs.next()) {
                Post post = new Post(
                        rs.getInt("postId"),
                        rs.getInt("isPublic"),
                        rs.getDate("createDate"),
                        rs.getString("title"),
                        rs.getString("image"),
                        rs.getString("content"),
                        rs.getString("memberId"),
                        0, // locationId와 myBookmarks에 대한 데이터는 현재 ResultSet에 없는 것으로 가정
                        0
                );
                postList.add(post);
            }
            return postList;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new SQLException("게시물 목록을 가져오는 중 오류 발생", ex);
        } finally {
            jdbcUtil.close();
        }
    }*/
    
    public List<Post> findPostList() throws SQLException {
        String sql = "SELECT postId, isPublic, createDate, title, image, content, m.memberId, l.name "
                + "FROM Post p "
                + "INNER JOIN Member m ON p.memberId = m.memberId "
                + "INNER JOIN LOCATION l ON p.locationId = l.locationId "
                + "WHERE p.isPublic = 1";

//        memberId가 null이 아닌 경우에는 해당 사용자의 게시물만 가져오도록 WHERE 조건 추가
//       if (memberId != null) {
//           sql += " AND p.memberId = ?";
//       }
//   
//       jdbcUtil.setSqlAndParameters(sql, (memberId != null) ? new Object[] { memberId } : null);
        jdbcUtil.setSqlAndParameters(sql, null);

        try {
            ResultSet rs = jdbcUtil.executeQuery();
            List<Post> postList = new ArrayList<>();

            while (rs.next()) {
                Post post = new Post(
                        rs.getInt("postId"),
                        rs.getInt("isPublic"),
                        rs.getDate("createDate"),
                        rs.getString("title"),
                        rs.getString("image"),
                        rs.getString("content"),
                        rs.getString("memberId"),
                        rs.getString("name") // locationId와 myBookmarks에 대한 데이터는 현재 ResultSet에 없는 것으로 가정
                );
                postList.add(post);
            }
            return postList;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new SQLException("게시물 목록을 가져오는 중 오류 발생", ex);
        } finally {
            jdbcUtil.close();
        }
    }
    
    public List<Post> findPostListByLocation(int locationId) throws SQLException {//replies는 getReplies메소드 사용해서 가져와. jsp에서 findPost호출하고 그 아래에서 getReplies호출하면 되나..?
        String sql = "SELECT postId, title, image, content "
                    + "FROM Post "
                    + "WHERE locationId=?";              
        jdbcUtil.setSqlAndParameters(sql, new Object[] { locationId });   // JDBCUtil에 query문과 매개 변수 설정
        List<Post> posts = new ArrayList<Post>();
        try {
            ResultSet rs = jdbcUtil.executeQuery();     // query 실행
            while (rs.next()) {                        // 게시글 정보 발견
                Post post = new Post(       // Post 객체를 생성하여 게시글 정보를 저장
                    rs.getInt("postId"),
                    rs.getString("title"),
                    rs.getString("image"),
                    rs.getString("content"));
                posts.add(post);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            jdbcUtil.close();       // resource 반환
        }
        return posts;
    }
//    public List<Post> findPostList() throws SQLException {
//        String sql = "SELECT postId, isPublic, createDate, title, image, content, m.memberName "
//                 + "FROM Post p INNER JOIN Member m ON p.memberId = m.memberId " //memberName 알아내려고 Join함
//                 + "WHERE isPublic = 1";
//        jdbcUtil.setSqlAndParameters(sql, null);      
//      try {
//         ResultSet rs = jdbcUtil.executeQuery();         
//         List<Post> postList = new ArrayList<Post>();
//          // 결과 반복문 처리
//           while (rs.next()) {
//               // Post 객체 생성
//               Post post = new Post(
//                   rs.getInt("postId"),
//                   rs.getInt("isPublic"),
//                   rs.getDate("createDate"),
//                   rs.getString("title"),
//                   rs.getString("image"),
//                   rs.getString("content"),
//                   null, 0, 0, null, null
//               );
//
//               // 리스트에 추가
//               postList.add(post);      
//         }      
//           return postList;
//       } catch (Exception ex) {
//           ex.printStackTrace();
//       } finally {
//           jdbcUtil.close();
//       }
//
//       return null;
//   }
    
    /**
     * 기존 작성된 Post 정보를 수정
     */
    public int updatePost(Post post) throws SQLException {
        String sql = "UPDATE Post "
                    + "SET isPublic=?, title=?, content=? "
                    + "WHERE postId=?";
        Object[] param = new Object[] {post.getIsPublic(), post.getTitle(),
                post.getContent(), post.getPostId()};             
        jdbcUtil.setSqlAndParameters(sql, param);   // JDBCUtil에 update문과 매개 변수 설정
            
        try {               
            int result = jdbcUtil.executeUpdate();  // update 문 실행
            return result;
        } catch (Exception ex) {
            jdbcUtil.rollback();
            ex.printStackTrace();
        }
        finally {
            jdbcUtil.commit();
            jdbcUtil.close();   // resource 반환
        }       
        return 0;
    }
    
    /* 북마크 카운트 */
    public int countPostBookmark(Post post, int count) throws SQLException {
        String sql = "UPDATE Post "
                    + "SET myBookmarks=?"
                    + "WHERE postId=?";
        Object[] param = new Object[] {
                count, post.getPostId()};             
        jdbcUtil.setSqlAndParameters(sql, param);   // JDBCUtil에 update문과 매개 변수 설정
            
        try {               
            int result = jdbcUtil.executeUpdate();  // update 문 실행
            return result;
        } catch (Exception ex) {
            jdbcUtil.rollback();
            ex.printStackTrace();
        }
        finally {
            jdbcUtil.commit();
            jdbcUtil.close();   // resource 반환
        }       
        return 0;
    }
    
    
    /**
     * 주어진 postId에 해당하는 게시글을 삭제.
     */
    public int deletePost(int postId) throws SQLException {
        String sql = "DELETE FROM Post WHERE postId=?";       
        jdbcUtil.setSqlAndParameters(sql, new Object[] {postId});   // JDBCUtil에 delete문과 매개 변수 설정

        try {               
            int result = jdbcUtil.executeUpdate();  // delete 문 실행
            return result;
        } catch (Exception ex) {
            jdbcUtil.rollback();
            ex.printStackTrace();
        }
        finally {
            jdbcUtil.commit();
            jdbcUtil.close();   // resource 반환
        }       
        return 0;
    }
    
    
    /* 북마크되어있는지 찾기 */
    public int findBookmark(String memberId, int postId) {
        System.out.println("멤버아이디와 포스트아이디" + memberId + postId);
        String sql = "SELECT * "
                + "FROM Bookmark "
                + "WHERE memberId=? AND postId=?";
        
        jdbcUtil.setSqlAndParameters(sql, new Object[] {memberId, postId});   // JDBCUtil에 query문과 매개 변수 설정
        try {
            ResultSet rs = jdbcUtil.executeQuery();     // query 실행
            if (rs.next()) {                        // 게시글 정보 발견
                System.out.println("북마크 셀렉 됐니? : 네");
                return 1;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            jdbcUtil.close();       // resource 반환
        }
        System.out.println("북마크 셀렉 됐니? : 아뇨");
        return 0;
    }
    
    /* 북마크 insert */
    public void addBookmark(String memberId, int postId) {
        String sql = "INSERT INTO Bookmark VALUES (?, ?)";      
        Object[] param = new Object[] {memberId, postId};   
        jdbcUtil.setSqlAndParameters(sql, param);   
        
        try {    
             jdbcUtil.executeQuery();
        } catch (Exception ex) {
           jdbcUtil.rollback();
           ex.printStackTrace();
        } finally {      
           jdbcUtil.commit();
           jdbcUtil.close();
        }      
    }
    
    /* 북마크 삭제 */
    public void removeBookmark(String memberId, int postId) {
        String sql = "DELETE FROM Bookmark WHERE memberId=? AND postId=?";       
        jdbcUtil.setSqlAndParameters(sql, new Object[] {memberId, postId});   // JDBCUtil에 delete문과 매개 변수 설정

        try {               
            jdbcUtil.executeUpdate();
        } catch (Exception ex) {
            jdbcUtil.rollback();
            ex.printStackTrace();
        }
        finally {
            jdbcUtil.commit();
            jdbcUtil.close();   // resource 반환
        }       
    }
}
