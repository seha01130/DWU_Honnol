package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Event;

public class EventDAO {
   private JDBCUtil jdbcUtil = null;
   
   public EventDAO() {         
      jdbcUtil = new JDBCUtil();   // JDBCUtil 객체 생성
   }
   public Event createEvent(Event event) throws SQLException {
      String sql = "INSERT INTO Event VALUES (eventId_seq.nextval, ?, ?, ?, ?, SYSDATE, ?, ?)";      
      Object[] param = new Object[] {event.getEventId(), 
            event.getHostId(), event.getLocationId(), event.getTitle(),
            event.getImage(), event.getContent(),event.getAttendees()};            
      jdbcUtil.setSqlAndParameters(sql, param);   
                  
      String key[] = {"eventId"};    
      try {    
         jdbcUtil.executeUpdate(key); 
            ResultSet rs = jdbcUtil.getGeneratedKeys();
            if(rs.next()) {
               int generatedKey = rs.getInt(1);  
               event.setEventId(generatedKey); 
            }
            return event;
      } catch (Exception ex) {
         jdbcUtil.rollback();
         ex.printStackTrace();
      } finally {      
         jdbcUtil.commit();
         jdbcUtil.close();
      }      
      return null;         
      
   }
   // 모임 수정 
   public int updateEvent(Event event) throws SQLException {
        String sql = "UPDATE Event "
                    + "SET title=?, image=?, content=?, locationId=?,"
                    + "WHERE eventId=?";
        Object[] param = new Object[] {event.getTitle(), event.getImage(),
                event.getContent(), event.getEventId()};             
        jdbcUtil.setSqlAndParameters(sql, param);  
            
        try {               
            int result = jdbcUtil.executeUpdate(); 
            return result;
        } catch (Exception ex) {
            jdbcUtil.rollback();
            ex.printStackTrace();
        }
        finally {
            jdbcUtil.commit();
            jdbcUtil.close(); 
        }       
        return 0;
    }

   // 모임 삭제 
   public int removeEvent(Event event) throws SQLException {
        String sql = "DELETE FROM Event WHERE eventId=?";       
        jdbcUtil.setSqlAndParameters(sql, new Object[] {event.getEventId()});   
        try {               
            int result = jdbcUtil.executeUpdate();
            return result;
        } catch (Exception ex) {
            jdbcUtil.rollback();
            ex.printStackTrace();
        }
        finally {
            jdbcUtil.commit();
            jdbcUtil.close();  
        }       
        return 0;
    }


   public Event findEvent(int eventId) throws SQLException {
      String sql = "SELECT hostId, title, image, content, createDate, locationId,"
            + "FROM Event";

    jdbcUtil.setSqlAndParameters(sql, new Object[]{eventId});
    Event event = null;
    try {
        ResultSet rs = jdbcUtil.executeQuery();
        if (rs.next()) {
            event = new Event(
                    eventId,
                    rs.getInt("hostId"),
                    rs.getString("title"),
                    rs.getString("image"),
                    rs.getDate("createDate"),
                    rs.getString("content"),
                    rs.getInt("locationId"));
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    } finally {
        jdbcUtil.close(); // resource 반환
    }
    return event;
}

   // 모임 리스트 조회
   public List<Event> findEventList() throws SQLException {
        String sql = "SELECT eventId, title, image, content, memberId, COUNT(bookmark) AS countOfBookmarks"
                 + "FROM Event";        
      jdbcUtil.setSqlAndParameters(sql, null);      
      try {
         ResultSet rs = jdbcUtil.executeQuery();         
         List<Event> eventList = new ArrayList<Event>();
           while (rs.next()) {
               Event event = new Event(
                   rs.getInt("eventId"),
                   rs.getInt("memberId"),
                   rs.getString("title"),
                   rs.getString("image"),
                   rs.getString("content")
               );

               eventList.add(event);      
         }      
           return eventList;
       } catch (Exception ex) {
           ex.printStackTrace();
       } finally {
           jdbcUtil.close();
       }

       return null;
   }
   public String findHostLoginId(int hostId) throws SQLException {
      String sql = "SELECT memberId" + 
               "FROM Member" + 
               "WHERE memberId=hostId";
      jdbcUtil.setSqlAndParameters(sql, new Object[] {hostId});
      String memberLoginId = null;
       try {
           ResultSet rs = jdbcUtil.executeQuery();
           if (rs.next()) {
              memberLoginId = rs.getString("memberId");
           }
       } catch (Exception ex) {
           ex.printStackTrace();
       } finally {
           jdbcUtil.close(); // resource 반환
       }
       return memberLoginId;
   }
}