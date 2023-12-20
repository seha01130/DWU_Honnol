package controller.member;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.Event;
import model.Member;
import model.MemberInfo;
import model.Post;
import model.service.ExistingMemberException;
import model.service.MemberManager;
import model.service.MemberInfoManager;


public class RegisterMemberController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(RegisterMemberController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
        String memberId = request.getParameter("memberId");

       	Member member = new Member(
       		memberId,
			request.getParameter("password"),
			request.getParameter("email"),
			new ArrayList<Post>(), 
			new ArrayList<Event>()); 
		
       	MemberInfo memberInfo = new MemberInfo(
       		request.getParameter("nickname"),
       		"",
       		0,
       		memberId
       		);
       	
        log.debug("Create Member : {}", member);

		try {
			MemberManager memberManager = MemberManager.getInstance();
			memberManager.create(member);
			
			MemberInfoManager memberInfoManager = MemberInfoManager.getInstance();
			memberInfoManager.create(memberInfo);
			
			log.info("회원가입 성공");
	        return "redirect:/member/login/form";	// 성공 시 로그인 화면 
	        
		} catch (ExistingMemberException e) {	// 예외 발생 시 회원가입 form으로 forwarding
            request.setAttribute("registerFailed", true);
			request.setAttribute("exception", e);
			request.setAttribute("member", member);
			log.info("회원가입 실패");
			return "/member/registerForm.jsp";
		}
    }
}

