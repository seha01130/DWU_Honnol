package controller.location;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.Member;
import model.Post;
import model.service.PostManager;

public class ListLocationPostController implements Controller {
	private static final Logger log = LoggerFactory.getLogger(ListLocationPostController.class);

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Post> postList = null;
		PostManager manager = PostManager.getInstance();
		int locationId = Integer.parseInt(request.getParameter("locationId"));
		
		log.debug("locationId Request : {}", locationId);
		postList = manager.findPostListByLocation(locationId);	
		
		for(var post: postList) {
			System.out.println(post);
			System.out.println("몇 개?");
		}
		
		request.setAttribute("postList", postList);
		
		log.debug("posts Request : {}", postList);
		return "/location/list.jsp";
	}
}
