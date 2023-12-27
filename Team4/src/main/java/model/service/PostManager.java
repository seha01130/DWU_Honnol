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
	
	public int searchLocationId(String locationAddress) throws SQLException{
        return postDAO.searchLocationId(locationAddress);  
    }
    
    public int saveLocationId(String locationName, String locationAddress) throws SQLException{
        return postDAO.saveLocationId(locationName, locationAddress);  
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
	
	public int findBookmark(String memberId, int postId) {
        return postDAO.findBookmark(memberId, postId);
    }
    public void addBookmark(String memberId, int postId) {
        postDAO.addBookmark(memberId, postId);
    }
    public void removeBookmark(String memberId, int postId) {
        postDAO.removeBookmark(memberId, postId);
    }
    
	public int countPostBookmark(Post post, int count) throws SQLException {
		return postDAO.countPostBookmark(post, count);  
	}
	public List<Post> findPostListByLocation(int locationId) throws SQLException {
        return postDAO.findPostListByLocation(locationId);
    }
	public int isBookmark(String memberId, int postId) {
	    
	       int isBookmarked = postDAO.findBookmark(memberId, postId);
	       System.out.println("북마크 됐니? : " + isBookmarked);
	       return isBookmarked;
	   }
}
