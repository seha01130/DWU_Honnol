package controller.memberInfo;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.Bookmark;
import model.Post;
import model.service.MemberManager;
import model.service.PostManager;

public class ListMyBookmarkController implements Controller {
	private static final Logger log = LoggerFactory.getLogger(ListMyBookmarkController.class);
	
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        List<Post> bookmarkList = null;
		MemberManager manager = MemberManager.getInstance();
		String memberId = request.getParameter("memberId");
		bookmarkList = manager.getBookmarkList(memberId);	
		
		request.setAttribute("bookmarkList", bookmarkList);
		
		log.debug("boookmarks Request : {}", bookmarkList);
		log.debug("memberIds Request : {}", memberId);
		return "/memberInfo/list_bookmark.jsp";	
    }   
}