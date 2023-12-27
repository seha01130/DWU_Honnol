package controller.event;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import controller.Controller;
import model.service.EventManager;
import model.service.MemberManager;
import model.Event;

public class UpdateEventController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(UpdateEventController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {
 
		int eventId = Integer.parseInt(request.getParameter("eventId"));
		
		if (request.getMethod().equals("GET")) {	
    		// GET request: 모임글 수정 form 요청	
			
    		MemberManager memberMan = MemberManager.getInstance();
    		EventManager eventMan = EventManager.getInstance();
    		
			//Event event = memberMan.findEvent(eventId);	// 수정하려는 모임 정보 검색
			//request.setAttribute("evnet", event);			
			
			//List<Integer> members = memberMan.findCommunityMembers(eventId); // 모임 참여자 리스트 검색
			//request.setAttribute("members", members);		
			return "/event/updateForm.jsp";   // 검색한 정보를 update form으로 전송     
	    }	
    	
    	// POST request (모임 정보가 parameter로 전송됨)
		Event event = new Event(
	    		0, Integer.parseInt(request.getParameter("memberId")),
	    		Integer.parseInt(request.getParameter("locationId")),
				request.getParameter("title"),
				request.getParameter("image"),
				request.getParameter("content"));		
		
    	log.debug("Update Community : {}", event);
    	EventManager eventMan = EventManager.getInstance();
    	eventMan.updateEvent(event);				
        return "redirect:/event/eventDetail";	// 수정 후 모임 상세 페이지로 redirect		
    }
}
