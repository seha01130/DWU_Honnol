package controller.event;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.Event;
import model.service.EventManager;

public class CreateEventController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(CreateEventController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	Event event = new Event(
    		0, Integer.parseInt(request.getParameter("memberId")),
    		Integer.parseInt(request.getParameter("locationId")),
			request.getParameter("title"),
			request.getParameter("image"),
			request.getParameter("content"));		
		try {
			EventManager manager = EventManager.getInstance();
			manager.createEvent(event);
			
	    	log.debug("Create Event : {}", event);
	    	request.setAttribute("event", event);
	        return "/event/event_create_form.jsp"; // 성공 시 모임글 상세페이지로 redirect
	        
		} catch (Exception e) {		// 예외 발생 시 입력 form으로 forwarding
            request.setAttribute("creationFailed", true);
			request.setAttribute("exception", e);
			request.setAttribute("event", event);
			return "/event/creationForm.jsp";
		}
    }
}
