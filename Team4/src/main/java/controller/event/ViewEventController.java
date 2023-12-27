package controller.event;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.service.EventManager;
import model.Event;

public class ViewEventController implements Controller {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {			
    	
    	Event event = null;
		EventManager manager = EventManager.getInstance();
		int eventId = Integer.parseInt(request.getParameter("eventId"));
		event = manager.findEvent(eventId);		// 모임 정보 검색			
		
		request.setAttribute("event", event);	// 모임 정보 저장				
		return "/event/eventDetail.jsp";				// 커뮤니티 보기 화면으로 이동
    }
}
