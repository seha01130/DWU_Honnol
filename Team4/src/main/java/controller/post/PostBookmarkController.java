package controller.post;

import java.util.Collections;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.fasterxml.jackson.databind.ObjectMapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import controller.member.MemberSessionUtils;
import model.Post;
import model.service.PostManager;

public class PostBookmarkController implements Controller {
	private static final Logger log = LoggerFactory.getLogger(PostBookmarkController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {  
        if(request.getMethod().equals("GET")) {
        String memberId = request.getParameter("memberId");
        int postId = Integer.parseInt(request.getParameter("postId"));
        int bookmarkCount = Integer.parseInt(request.getParameter("bookmarkCount"));
        
        log.debug("사용자 : " + memberId+ "게시글" + postId + "북마크 개수" + bookmarkCount);
        
        PostManager manager = PostManager.getInstance();
        
       // 사용자가 이전에 해당 게시글을 북마크한 적 있는지 검사
        int isBookmark = manager.findBookmark(memberId, postId);       
        if (isBookmark == 0) {      // 북마크 안했으면 bookmark DB에 저장
            manager.addBookmark(memberId, postId);
        }else {                     //북마크 했으면 bookmark DB에서 삭제
            manager.removeBookmark(memberId, postId);
        }
        Post post = manager.findPost(postId);
        
        // 북마크 개수 갱신
        manager.countPostBookmark(post, bookmarkCount); 
        
        // Post request2 : 사용자가 북마크한 글에 해당 게시글 추가  
        
        request.setAttribute("post", post); 
        ObjectMapper objectMapper = new ObjectMapper();
 	    String jsonResponse = objectMapper.writeValueAsString(Collections.singletonMap("bookmarkCount", bookmarkCount));
		
 	    // 응답 데이터를 클라이언트로 전송
 	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
 	    response.getWriter().write(jsonResponse);
        }

        return "/post/detailPage.jsp";   
    }
}
