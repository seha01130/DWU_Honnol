package model.service;

import java.sql.SQLException;
import java.util.List;

import model.MemberInfo;
import model.dao.MyPageDAO;

public class MyPageManager {
	private static MyPageManager myPageMan = new MyPageManager();
	private MyPageDAO myPageDAO;
	private MyPageManager() {
		try {
			myPageDAO = new MyPageDAO();
		} catch (Exception e) {
			e.printStackTrace();
		}			
	}
	public static MyPageManager getInstance() {
		return myPageMan;
	}
	
	public MemberInfo showMyPage(String memberId) throws SQLException {
        return myPageDAO.showMyPage(memberId);       
    }
	
//	public Post findPost(int postId)throws SQLException {
//	        Post post = postDAO.findPost(postId);
//	        return post;
//	    }
//	
//	public int deletePost(int postId) throws SQLException {
//        return postDAO.deletePost(postId);
//    }
//	
//	public int updatePost(Post post) throws SQLException {
//        return postDAO.updatePost(post);                
//    }
//	
//	public List<Post> findPostList() throws SQLException {
//        return postDAO.findPostList();
//    }
}
