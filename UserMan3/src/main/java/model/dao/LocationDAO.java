package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import model.Event;
import model.Location;
import model.Post;
//import model.Location;
//import model.Post;

public class LocationDAO {
    private JDBCUtil jdbcUtil;

    public LocationDAO() {
        jdbcUtil = new JDBCUtil();
    }

    /**
     * 새로운 장소 정보를 데이터베이스에 추가
     */
    public int addLocation(String address) throws SQLException {
    	String query = "SELECT locationId FROM Location WHERE address=?";
    	Object[] param = new Object[]{address};
        jdbcUtil.setSqlAndParameters(query, param);
        
        try {
        	ResultSet rs = jdbcUtil.executeQuery();
        	if(rs.next()) {
        		int locationId = rs.getInt("locationId");
        		return locationId;
        	}
        }catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            jdbcUtil.close();
        }
        return 0;
    }
    
    /**
     * 특정 주소에 해당하는 장소 정보(주소, 이름 등)를 검색
     */
    public Location getLocationInfo(int locationId) throws SQLException {
        String query = "SELECT locationId, address, locationName FROM Location WHERE locationId=?";
        Object[] param = new Object[]{locationId};
        jdbcUtil.setSqlAndParameters(query, param);

        try {
            ResultSet rs = jdbcUtil.executeQuery();
            if (rs.next()) {
                String address = rs.getString("address");
                String name = rs.getString("name"); 
                // 필요한 다른 장소 정보를 가져와서 Location 객체를 생성하여 반환
                return new Location(locationId, name, address);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            jdbcUtil.close();
        }
        return null;
    }
    
    /**
     * 특정 장소에 연결된 포스트 목록을 검색
     */
    public List<Post> getPostlist(int locationId) throws SQLException {
        String query = "SELECT postId, createDate, title, content, locationId FROM Post WHERE locationId=?";
        Object[] param = new Object[]{locationId};
        jdbcUtil.setSqlAndParameters(query, param);

        List<Post> posts = new ArrayList<>();
        //memberId도 가져와야될텐데?
        try {
            ResultSet rs = jdbcUtil.executeQuery();
            while (rs.next()) {
                int postId = rs.getInt("postId");
                Date createDate = rs.getDate("createDate");
                String title = rs.getString("title");
                String content = rs.getString("content");
                int locId = rs.getInt("locationId");
                // 필요한 다른 포스트 정보를 가져와서 Post 객체를 생성하여 리스트에 추가
                Post post = new Post(postId, 0, createDate, title, "", content, null, locId, 0);
                posts.add(post);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            jdbcUtil.close();
        }
        return posts;
    }

    /**
     * 특정 장소에 연결된 모임 목록을 검색
     */
    public List<Event> getEventlist(int locationId) throws SQLException {
        String query = "SELECT eventId, locationId, title, createDate, content FROM Post WHERE locationId=?";
        Object[] param = new Object[]{locationId};
        jdbcUtil.setSqlAndParameters(query, param);

        List<Event> events = new ArrayList<>();

        try {
            ResultSet rs = jdbcUtil.executeQuery();
            while (rs.next()) {
                int eventId = rs.getInt("eventId");
                int locId = rs.getInt("locationId");
                String title = rs.getString("title");
                Date createDate = rs.getDate("createDate");
                String content = rs.getString("content");
                // 필요한 다른 포스트 정보를 가져와서 Event 객체를 생성하여 리스트에 추가
                Event event = new Event(eventId, 0, title, "", createDate, content, locId);
                events.add(event);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            jdbcUtil.close();
        }
        return events;
    }
}
