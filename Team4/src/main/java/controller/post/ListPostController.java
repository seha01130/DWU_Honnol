package controller.post;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.Post;
import model.service.PostManager;

public class ListPostController implements Controller {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
    	PostManager manager = PostManager.getInstance();
        List<Post> postList = manager.findPostList();
        
        
     // 한 페이지에 표시될 게시글 수
        int pageSize = 7;
        // 현재 페이지 번호
        int currentPage = (request.getParameter("page") == null) ? 1 : Integer.parseInt(request.getParameter("page"));
        // 현재 페이지에 해당하는 게시글 목록 가져오기
        int startIndex = (currentPage - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, postList.size());
        List<Post> currentPagePosts = postList.subList(startIndex, endIndex);
        
        
        // postList 객체를 request에 저장하여 커뮤니티 리스트 화면으로 이동(forwarding)
        request.setAttribute("postList", currentPagePosts);             
        return "/post/list.jsp";        
    }
}
