package controller.post;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import controller.Controller;
import model.Post;
import model.Reply;
import model.service.PostManager;

public class DetailPostController implements Controller {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {            
        Post post = null;
        List<Reply> replyList = null;
        PostManager manager = PostManager.getInstance();
        
        int postId = Integer.parseInt(request.getParameter("postId"));
        post = manager.findPost(postId);       // 게시글 정보 검색    
        replyList = manager.getReplies(postId);    // 댓글 정보 검색
        
        request.setAttribute("post", post);    // 게시글 정보 저장  
        request.setAttribute("replyList", replyList);    // 댓글 정보 저장
        
        System.out.println("파일 불러오기 file: " + post.getImage());

        return "/post/detailPage.jsp";               // 게시글 보기 화면으로 이동
    }
}