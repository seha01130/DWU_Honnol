package controller.member;

import java.util.Collections;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.fasterxml.jackson.databind.ObjectMapper;

import controller.Controller;
import model.service.MemberManager;

public class MemberIdCheckController implements Controller{
    private static final Logger log = LoggerFactory.getLogger(UpdateMemberController.class);

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (request.getMethod().equals("GET")) {	
    		// GET request: 회원정보 수정 form 요청	
    		// 원래는 UpdateUserFormController가 처리하던 작업을 여기서 수행
    		String memberId = request.getParameter("memberId");

    		log.debug("Id duplicate check Request : {}", memberId);
    		MemberManager manager = MemberManager.getInstance();
    		boolean isDuplicate = manager.IsDuplicatedMemberId(memberId);
    		
    	    // 응답 데이터를 JSON 형식으로 생성
    	    ObjectMapper objectMapper = new ObjectMapper();
    	    String jsonResponse = objectMapper.writeValueAsString(Collections.singletonMap("isDuplicate", isDuplicate));

    	    // 응답 데이터를 클라이언트로 전송
    	    response.setContentType("application/json");
    	    response.getWriter().write(jsonResponse);

		}
		
		return null;	
	}

}
