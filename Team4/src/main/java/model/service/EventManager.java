package model.service;

import java.sql.SQLException;
import java.util.List;

import model.Event;
import model.Member;
import model.dao.*;
/**
 * 사용자 관리 API를 사용하는 개발자들이 직접 접근하게 되는 클래스.
 * UserDAO를 이용하여 데이터베이스에 데이터 조작 작업이 가능하도록 하며,
 * 데이터베이스의 데이터들을 이용하여 비지니스 로직을 수행하는 역할을 한다.
 * 비지니스 로직이 복잡한 경우에는 비지니스 로직만을 전담하는 클래스를 
 * 별도로 둘 수 있다.
 */
public class EventManager {
	private static EventManager eventManager = new EventManager();
	private EventDAO eventDAO;
	private MemberDAO memberDAO;
	private LocationDAO locDAO;
	private MemberAnalysis memberAanlysis;

	private EventManager() {
		try {
			eventDAO = new EventDAO();
		} catch (Exception e) {
			e.printStackTrace();
		}			
	}
	
	public static EventManager getInstance() {
		return eventManager;
	}
	
	public Event createEvent(Event event) throws SQLException {
//		if (locDAO.notExistingLocation(event.getLocationId()) == true) {
//			throw new NotExistingLocationException(event.getLocationId() + "는 등록할 수 없는 장소입니다.");
//		}
		return eventDAO.createEvent(event);
	}

	public int updateEvent(Event event) throws SQLException {
		return eventDAO.updateEvent(event);				
	}	

	public int removeEvent(int eventId, int userId) throws Exception {
		Event event = eventDAO.findEvent(eventId); 
		if (event == null || userId != event.getHostId()) {
			// 사용자가 모임글 작성자인 경우 -> 그 모임을 삭제
			throw new Exception();
			//throw new NotEventHostException(userId + "는 모임 " + event.getEventId() + "의 호스트가 아닙니다.");
		}
		return eventDAO.removeEvent(event);
	}

	public Event findEvent(int eventId)
		throws SQLException, MemberNotFoundException {
		Event event = eventDAO.findEvent(eventId);
		
		if (event == null) {
			throw new MemberNotFoundException(eventId + "는 존재하지 않는 모임입니다.");
		}		
		return event;
	}

	// 모임 전체 리스트 조회 
	public List<Event> findEventList() throws SQLException {
			return eventDAO.findEventList();
	}
	// 모임 참여 사용자 목록
	public List<Member> finAttendeeList(int eventId) throws SQLException {
		return memberDAO.getAttendeeIds(eventId);
	}
	
	public Boolean isHost(String loginId, Event event) throws SQLException {
		String hostLoginId = eventDAO.findHostLoginId(event.getHostId());
		if(loginId.equals(hostLoginId))
			return true;
		return false;
	}
//	
//	public List<User> findUserList(int currentPage, int countPerPage)
//		throws SQLException {
//		return userDAO.findUserList(currentPage, countPerPage);
//	}
//
//	public boolean login(String userId, String password)
//		throws SQLException, UserNotFoundException, PasswordMismatchException {
//		User user = findUser(userId);
//
//		if (!user.matchPassword(password)) {
//			throw new PasswordMismatchException("비밀번호가 일치하지 않습니다.");
//		}
//		return true;
//	}
//
//	public List<Event> makeFriends(String userId) throws Exception {
//		return userAanlysis.recommendFriends(userId);
//	}
//	
//	public Community createCommunity(Community comm) throws SQLException {
//		return commDAO.create(comm);		
//	}
//
//	public int updateCommunity(Community comm) throws SQLException {
//		return commDAO.update(comm);				
//	}
//	
//	public Community findCommunity(int commId) throws SQLException {
//		Community comm = commDAO.findCommunity(commId); 
//		
//		List<Event> memberList = userDAO.findUsersInCommunity(commId);
//		comm.setMemberList(memberList);
//		
//		int numOfMembers = userDAO.getNumberOfUsersInCommunity(commId);
//		comm.setNumOfMembers(numOfMembers);
//		return comm;
//	}
//	
//	public List<Event> findCommunityList() throws SQLException {
//		return commDAO.findCommunityList();
//	}
//	
//	public List<Member> findCommunityMembers(int commId) throws SQLException {
//		return memberDAO.getAttendeeIds(commId);
//	}
//
//	public EventDAO getUserDAO() {
//		return this.userDAO;
//	}
}