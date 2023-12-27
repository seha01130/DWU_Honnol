package controller.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import controller.DispatcherServlet;
import model.service.MemberManager;

public class LoginController implements Controller {
	private static final Logger log = LoggerFactory.getLogger(DispatcherServlet.class);
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String Id = request.getParameter("memberId");
		String password = request.getParameter("password");
		
		try {
			// 모델에 로그인 처리를 위임
			MemberManager manager = MemberManager.getInstance();
			manager.login(Id, password);
	
			// 세션에 사용자 이이디 저장
			HttpSession session = request.getSession();
            session.setAttribute(MemberSessionUtils.MEMBER_SESSION_KEY, Id);
            
            log.info("로그인 성공!");
            return "/mainPage/mainLogin.jsp";			
		} catch (Exception e) {
			/* UserNotFoundException이나 PasswordMismatchException 발생 시
			 * 다시 login form을 사용자에게 전송하고 오류 메세지도 출력
			 */
            request.setAttribute("loginFailed", true);
			request.setAttribute("exception", e);
			
			log.info("로그인 실패!");
            return "/member/loginForm.jsp";			
		}	
    }
}
