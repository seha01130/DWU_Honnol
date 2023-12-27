package controller.memberInfo;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.Member;
import model.Post;
import model.service.MemberManager;

public class ListMyPostController implements Controller {
	private static final Logger log = LoggerFactory.getLogger(ListMyPostController.class);

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Post> postList = null;
		MemberManager manager = MemberManager.getInstance();
		String memberId = request.getParameter("memberId");
		postList = manager.getPostList(memberId);	
		
		request.setAttribute("postList", postList);
		
		log.debug("posts Request : {}", postList);
		return "/post/list.jsp";
	}
}
