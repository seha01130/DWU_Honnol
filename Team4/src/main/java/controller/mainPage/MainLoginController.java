package controller.mainPage;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.Post;
import model.dao.PostDAO;
import model.service.PostManager;

public class MainLoginController implements Controller {
    @SuppressWarnings("unused")
	private static final Logger log = LoggerFactory.getLogger(MainLoginController.class);

    @SuppressWarnings("unused")
	@Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 세션 또는 요청 매개 변수에서 memberId를 가져옵니다.
        String memberId = request.getParameter("memberId");
        // 로그인 중에 memberId를 세션에 저장한 경우 세션에서도 가져올 수 있습니다.

        // TODO: memberId를 기반으로 데이터베이스에서 사용자의 게시물을 가져옵니다.
        // 단순화를 위해 PostDAO에서 사용자 게시물을 가져오는 메서드를 가정합니다.

        PostDAO postDAO = new PostDAO();
        List<Post> postList = postDAO.findPostList();
//        PostManager manager = PostManager.getInstance();
//        List<Post> postList = manager.findPostList();

        // JSP에서 사용할 userPosts 속성을 설정합니다.
        request.setAttribute("userPosts", postList);

//        // mainLogin.jsp로 포워딩
//        RequestDispatcher dispatcher = request.getRequestDispatcher("/mainPage/mainLogin.jsp");
//        dispatcher.forward(request, response);
//
//        // 이미 포워드가 수행되었으므로 JSP 경로를 반환할 필요가 없습니다
//        return null;
        
        // 메인 로그인 페이지로 포워딩합니다.
        return "/mainPage/mainLogin.jsp";
    }
    
    public String list() {
        return "post/list";
    }
    
    public String myPage() {
        return "member/myPage";
    }
}


