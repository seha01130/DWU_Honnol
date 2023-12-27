package controller.reply;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import controller.member.MemberSessionUtils;
import model.Reply;
import model.service.ReplyManager;

public class CreateReplyController implements Controller{
	private static final Logger log = LoggerFactory.getLogger(ReplyController.class);
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {   
		 // 세션에서 사용자 ID를 가져오기
        HttpSession session = request.getSession();
        String memberId = (String) session.getAttribute(MemberSessionUtils.MEMBER_SESSION_KEY);
        Date createDate = new Date();

        Reply reply = new Reply(
            1,
            request.getParameter("replyContent"),
            createDate,
            Integer.parseInt(request.getParameter("postId")),
            memberId,
            null,
            null
        );
        
        log.debug("Create Post : {}", reply);

        	ReplyManager manager = ReplyManager.getInstance();
            manager.createReply(reply);
            
            return "redirect:/post/detailPage?postId=" + reply.getPostId();
	}
	
}