package controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.service.PostManager;

public class DeletePostController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(DeletePostController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int deleteId = Integer.parseInt(request.getParameter("postId"));
        log.debug("Delete Post : {}", deleteId);

        PostManager manager = PostManager.getInstance();   
                
        int isDelete = manager.deletePost(deleteId); // 게시글 정보 삭제
        if(isDelete == 1) {
            System.out.println("delete well");
        }
        else {
            System.out.println("delete fail");
        }
        return "/main.jsp";     // 메인페이지로 이동
         
    }
}
