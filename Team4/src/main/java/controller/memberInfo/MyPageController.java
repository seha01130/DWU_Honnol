package controller.memberInfo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.MemberInfo;
import model.service.MyPageManager;


public class MyPageController implements Controller{
	private static final Logger log = LoggerFactory.getLogger(MyPageController.class);

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {  
		String memberId = request.getParameter("memberId");
		// GET request: 게시글 등록 form 요청 
		log.debug("RegisterForm Request"); 

		MyPageManager manager = MyPageManager.getInstance();
		MemberInfo memberInfo = manager.showMyPage(memberId);
		//return "redirect:/memberInfo/myPage?memberId=" + memberId; // 성공 시 마이페이지로 이동
		
		request.setAttribute("memberInfo", memberInfo);
		
		return "/memberInfo/myPage.jsp"; // 성공 시 마이페이지로 이동
	}
}
