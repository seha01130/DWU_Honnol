package controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.Post;
import model.service.PostManager;

public class PostBookmarkController implements Controller{
    private static final Logger log = LoggerFactory.getLogger(PostBookmarkController.class);

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int postId = Integer.parseInt(request.getParameter("postId"));
		int count = Integer.parseInt(request.getParameter("count"));
		String memberId = request.getParameter("memberId");
		
        if (request.getMethod().equals("POST")) {    
            // Post request1 : 북마크 개수 증감
        	PostManager manager = PostManager.getInstance();
        	Post post = manager.findPost(postId);
        	
        	manager.countPostBookmark(post, count); // 수정하려는 게시글 정보 검색
        	
        	// Post request2 : 사용자가 북마크한 글에 해당 게시글 추가  
        	
            request.setAttribute("post", post);          
            
            
            
        }
		return null;   
	}
}