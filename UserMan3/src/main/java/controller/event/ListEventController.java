package controller.event;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import controller.Controller;
import model.Event;
import model.service.EventManager;

public class ListEventController implements Controller {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {
		
    	EventManager manager = EventManager.getInstance();
		List<Event> eventList = manager.findEventList();
		
		// 모임 객체를 request에 저장하여 모임 전체 리스트 화면으로 이동(forwarding)
		request.setAttribute("eventList", eventList);				
		return "/event/eventList.jsp";        
    }
//    
//	UserManager manager = UserManager.getInstance();
//	List<Community> commList = manager.findCommunityList();
//	
//	// commList 객체를 request에 저장하여 커뮤니티 리스트 화면으로 이동(forwarding)
//	request.setAttribute("commList", commList);				
//	return "/community/list.jsp";      
}
