package controller.reply;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import controller.reply.ReplyController;
import model.Reply;
import model.service.PostManager;

public class ReplyController implements Controller{
	private static final Logger log = LoggerFactory.getLogger(ReplyController.class);
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {   
	    List<Reply> replyList = null;
    	PostManager manager = PostManager.getInstance();
    	
        int postId = Integer.parseInt(request.getParameter("postId"));
        
        replyList = manager.getReplies(postId);    // 댓글 정보 검색
        
        // postList 객체를 request에 저장하여 커뮤니티 리스트 화면으로 이동(forwarding)
        request.setAttribute("replyList", replyList);             
        return "/reply/reply.jsp";     
	}
	
}