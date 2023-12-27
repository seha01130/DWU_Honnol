package controller;

import java.util.HashMap;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import controller.post.*;
import controller.reply.CreateReplyController;
import controller.reply.ReplyController;
import controller.member.*;
import controller.memberInfo.*;
import controller.location.ListLocationPostController;
import controller.location.LocationController;
import controller.mainPage.*;

public class RequestMapping {
    private static final Logger logger = LoggerFactory.getLogger(DispatcherServlet.class);
    
    // 각 요청 uri에 대한 controller 객체를 저장할 HashMap 생성
    private Map<String, Controller> mappings = new HashMap<String, Controller>();

    public void initMapping() {
    	// 각 uri에 대응되는 controller 객체를 생성 및 저장
        //mappings.put("/", new LoginController());
    	mappings.put("/", new ForwardController("index.jsp"));
        mappings.put("/member/login/form", new ForwardController("/member/loginForm.jsp"));
        mappings.put("/member/login", new LoginController());
        mappings.put("/member/logout", new LogoutController());
        
        // 회원 가입 폼 요청과 가입 요청 처리 병합 (폼에 커뮤니티 선택 메뉴 추가를 위함)
        mappings.put("/member/register/form", new ForwardController("/member/registerForm.jsp"));
        mappings.put("/member/register", new RegisterMemberController());
        mappings.put("/member/register/idCheck", new MemberIdCheckController());
        mappings.put("/member/register/emailCheck", new MemberEmailCheckController());
        mappings.put("/member/findNickname", new FindMemberNicknameById()); 
        // 로그인 회원가입 관련 URI 추가 
//        mappings.put("/member/")
        
        //게시글 관련 request URI 추가
        mappings.put("/post/create", new CreatePostController());
        mappings.put("/post/delete", new DeletePostController());
        mappings.put("/post/detailPage", new DetailPostController());
        mappings.put("/post/locationSearch", new LocationSearchController());
        mappings.put("/post/list", new ListPostController());
        mappings.put("/post/update", new UpdatePostController());
        mappings.put("/post/countBookmark", new PostBookmarkController());
        
        mappings.put("/memberInfo/myPage", new MyPageController());
        mappings.put("/member/update", new UpdateMemberController());
        mappings.put("/memberInfo/edit", new EditProfileController());
        mappings.put("/memberInfo/myPost", new ListMyPostController());
        mappings.put("/memberInfo/myBookmark", new ListMyBookmarkController());
       //mappings.put("/memberInfo/edit", new EditMemberInfoController());
        //mappings.put("/memberInfo/postList", );
        //mappings.put("/member/update", new UpdateMemberController());
        
        
        mappings.put("/mainPage/mainLogin", new MainLoginController());
//      mappings.put("/mainPage/mainLogin", new ListPostController());
        mappings.put("/mainPage/mainLogout", new MainLogoutController());
      	mappings.put("/account/login", new LoginController());
      
        mappings.put("/location/search" , new ForwardController("/location/locationSearch.jsp"));
        mappings.put("/location/result" , new LocationController());
        mappings.put("/location/postSearch" , new ListLocationPostController());
        
        mappings.put("/post/reply", new ReplyController());
        mappings.put("/reply/create", new CreateReplyController());
        
        
        logger.info("Initialized Request Mapping");
        
    }

    public Controller findController(String uri) {	
    	// 주어진 uri에 대응되는 controller 객체를 찾아 반환
        return mappings.get(uri);
    }
}