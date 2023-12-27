package model;

import java.util.*;

public class Event {
   private int eventId;
   private int hostId; // 모임글 작성자 
   private String title;
   private String image;
   private Date createDate;
   private String content;
   private int locationId;
   private List<Member> attendees; // 모임 참여자

   public Event() {}

   public Event(int eventId, int hostId, String title, String image, String content) {
      this.eventId = eventId;
      this.hostId = hostId;
      this.title = title;
      this.image = image;
      this.content = content;
   }

   public Event(int eventId, int hostId, int locationId, String title, String image, String content) {
      this.eventId = eventId;
      this.hostId = hostId;
      this.locationId = locationId;
      this.title = title;
      this.image = image;
      this.content = content;
   }
   
   public Event(int eventId, int hostId, String title, String image, Date createDate, 
      String content, int locationId, List<Member> attendees) {
      this.eventId = eventId;
      this.hostId = hostId;
      this.title = title;
      this.image = image;
      this.createDate = createDate;
      this.content = content;
      this.locationId = locationId;
      this.attendees = attendees;
   }
   
   public Event(int eventId, int hostId, String title, String image, Date createDate, 
         String content, int locationId) {
         this.eventId = eventId;
         this.hostId = hostId;
         this.title = title;
         this.image = image;
         this.createDate = createDate;
         this.content = content;
         this.locationId = locationId;
      }
      
   
    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }


    public int getHostId() {
        return hostId;
    }

    public void setHostId(int hostId) {
        this.hostId = hostId;
    }


    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }


    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }


    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }


    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }


    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }


    public List<Member> getAttendees() {
        return attendees;
    }

    public void setAttendees(List<Member> attendees) {
        this.attendees = attendees;
    }

}