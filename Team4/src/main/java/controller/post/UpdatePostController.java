package controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.Post;
import model.service.PostManager;

public class UpdatePostController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(UpdatePostController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        int updateId = Integer.parseInt(request.getParameter("postId"));
        
        if (request.getMethod().equals("GET")) {    
            // GET request: 커뮤니티 수정 form 요청 
        	PostManager manager = PostManager.getInstance();
            Post post = manager.findPost(updateId); // 수정하려는 게시글 정보 검색
            request.setAttribute("post", post);            
                  
            return "/post/updateForm.jsp";   // 검색한 정보를 update form으로 전송     
        }   
        
        // POST request (게시글 정보가 parameter로 전송됨)
        Post post = new Post(
            updateId,
            Integer.parseInt(request.getParameter("isPublic")),
            request.getParameter("title"),
            request.getParameter("content"));

        log.debug("Update Post : {}", post);

        PostManager manager = PostManager.getInstance();
        int isUpdate = manager.updatePost(post);
        if(isUpdate == 1) {
            System.out.println("update well");
        }
        else {
            System.out.println("update fail");
        }
        return "redirect:/post/detailPage?postId=" + updateId;
    }
}
