package model.service;

import java.sql.SQLException;
import java.util.List;

import model.Post;
import model.Reply;
import model.dao.PostDAO;

public class PostManager {
	private static PostManager postMan = new PostManager();
	private PostDAO postDAO;
	private PostManager() {
		try {
			postDAO = new PostDAO();
		} catch (Exception e) {
			e.printStackTrace();
		}			
	}
	
	public static PostManager getInstance() {
		return postMan;
	}
	
	public Post createPost(Post post) throws SQLException {
        return postDAO.createPost(post);       
    }
	
	public Post findPost(int postId)throws SQLException {
	    Post post = postDAO.findPost(postId);
	    return post;
	}
	
	public List<Reply> getReplies(int postId) {
	    return postDAO.getReplies(postId);
	}
	
	public int deletePost(int postId) throws SQLException {
        return postDAO.deletePost(postId);
    }
	
	public int updatePost(Post post) throws SQLException {
        return postDAO.updatePost(post);                
    }
	
	public List<Post> findPostList() throws SQLException {
        return postDAO.findPostList();
    }
	public int countPostBookmark(Post post, int count) throws SQLException {
		return postDAO.countPostBookmark(post, count);  
	}
}
