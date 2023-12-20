package controller.event;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.member.DeleteMemberController;
import controller.member.MemberSessionUtils;
import model.Event;
import model.service.EventManager;

public class DeleteEventController {
	private static final Logger log = LoggerFactory.getLogger(DeleteMemberController.class);

    public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {
		int eventId = Integer.parseInt(request.getParameter("eventId"));
    	log.debug("Delete EventId : {}", eventId);

    	EventManager manager = EventManager.getInstance();		
		HttpSession session = request.getSession();	
	
		Event event = manager.findEvent(eventId);
		if (event != null || manager.isHost(MemberSessionUtils.getLoginMemberId(session), event)) {
			// 사용자가 모임글 작성자인 경우 -> 그 모임을 삭제
			return "/event/eventList.jsp";
		}
		return "/event/eventDetail.jsp";
	}
}
