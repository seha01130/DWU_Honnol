package controller.memberInfo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.Member;
import model.MemberInfo;
import model.service.MemberManager;

public class EditProfileController implements Controller {
	private static final Logger log = LoggerFactory.getLogger(EditProfileController.class);

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {   	
		// GET request: 회원정보 수정 form 요청	
		// 원래는 UpdateUserFormController가 처리하던 작업을 여기서 수행
		String updateId = "seha";

		log.debug("UpdateForm Request : {}", updateId);

		MemberManager manager = MemberManager.getInstance();
		Member member = manager.findProfile1(updateId);	// 수정하려는 사용자 정보 검색
		request.setAttribute("member", member);			

		log.debug("member Request : {}", member);

		MemberInfo memberInfo = manager.findProfile2(updateId);	// 수정하려는 사용자 정보 검색
		request.setAttribute("memberInfo", memberInfo);	

		log.debug("memberInfo Request : {}", memberInfo);

		return "/memberInfo/editProfile.jsp";

		// else (수정 불가능한 경우) 사용자 보기 화면으로 오류 메세지를 전달
		//request.setAttribute("updateFailed", true);
		//request.setAttribute("exception", 
		//		new IllegalStateException("타인의 정보는 수정할 수 없습니다."));            
		//return "/user/view.jsp";	// 사용자 보기 화면으로 이동 (forwarding)	
	}
}