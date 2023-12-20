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
        
        // postList 객체를 request에 저장하여 커뮤니티 리스트 화면으로 이동(forwarding)
        request.setAttribute("postList", postList);             
        return "/post/list.jsp";        
    }
}
