package controller.post;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.member.MemberSessionUtils;
import model.Post;
import model.Reply;
import model.MemberInfo;
import model.service.PostManager;
import model.service.MemberInfoManager;

public class DetailPostController implements Controller {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {            
        PostManager manager = PostManager.getInstance();
        MemberInfoManager memberInfoManager = MemberInfoManager.getInstance();
        
        HttpSession session = request.getSession();
        String memberId = (String) session.getAttribute(MemberSessionUtils.MEMBER_SESSION_KEY);
        
        int postId = Integer.parseInt(request.getParameter("postId"));
        Post post = manager.findPost(postId);       // 게시글 정보 검색    
	    
        String writer = post.getNickname();
        MemberInfo memberInfo = memberInfoManager.findMemberInfoByNickname(writer);
        
        List<Reply> replyList = null;
        replyList = manager.getReplies(postId);    // 댓글 정보 검색
       
        int isBookmarked = manager.isBookmark(memberId, postId); //북마크 전에 했었는지 검색
        
        
        request.setAttribute("post", post);    // 게시글 정보 저장 
        request.setAttribute("isBookmarked", isBookmarked); 
        request.setAttribute("writerInfo", memberInfo); 
        request.setAttribute("replyList", replyList);     
        
      
        return "/post/detailPage.jsp";        // 게시글 보기 화면으로 이동
    }
}