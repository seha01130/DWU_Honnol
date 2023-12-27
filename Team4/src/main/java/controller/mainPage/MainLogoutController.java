package controller.mainPage;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.Post;
import model.dao.PostDAO;

public class MainLogoutController implements Controller {
    @SuppressWarnings("unused")
	private static final Logger log = LoggerFactory.getLogger(MainLogoutController.class);

    @SuppressWarnings("unused")
	@Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // 메인 로그아웃 페이지로 포워딩합니다.
        return "/mainPage/mainLogout.jsp";
    }
    
    public String mainLogout() {
        return "mainPage/mainLogout";
    }
    
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/account/login.jsp");
//        dispatcher.forward(request, response);
//    }
}


