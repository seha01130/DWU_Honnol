package controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import controller.member.MemberSessionUtils;
import model.MemberInfo;
import model.service.PostManager;
import model.service.MemberInfoManager;

public class DeletePostController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(DeletePostController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	// 세션에서 사용자 ID를 가져오기
        HttpSession session = request.getSession();
        String memberId = request.getParameter("memberId");
        
        int deleteId = Integer.parseInt(request.getParameter("postId"));
        log.debug("Delete Post : {}", deleteId);

        PostManager manager = PostManager.getInstance();   
        MemberInfoManager memberInfoManager =  MemberInfoManager.getInstance();
        
        MemberInfo memberInfo = memberInfoManager.findMemberInfoByNickname(memberId);
        
        System.out.println(memberId + "의 마이페이지 로딩");
        
        request.setAttribute("memberInfo", memberInfo); 
        int isDelete = manager.deletePost(deleteId); // 게시글 정보 삭제
        if(isDelete == 1) {
            System.out.println("delete well");
        }
        else {
            System.out.println("delete fail");
        }
        return "redirect:/memberInfo/myPage?memberId="+memberId; // 성공 시 마이페이지로 이동
         
    }
}
