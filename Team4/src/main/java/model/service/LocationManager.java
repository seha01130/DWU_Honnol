package model.service;

import java.sql.SQLException;
import model.dao.LocationDAO;

public class LocationManager {
	private static LocationManager locMan = new LocationManager();
	private LocationDAO locationDAO;
	private LocationManager() {
		try {
			locationDAO = new LocationDAO();
		} catch (Exception e) {
			e.printStackTrace();
		}			
	}
	
	public static LocationManager getInstance() {
		return locMan;
	}
	
	public int getLocation(String address) throws SQLException {
        return locationDAO.getLocationId(address);       
    }
//	
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
//	
//	public List<Post> findPostListByLocation(int locationId) throws SQLException {
//        return postDAO.findPostListByLocation(locationId);
//    }
	
	
}
