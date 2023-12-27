<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="controller.member.MemberSessionUtils" %>

<%
String memberId = null;
if (session != null && session.getAttribute(MemberSessionUtils.MEMBER_SESSION_KEY) != null) {
    // 세션에서 memberId를 가져옴
    memberId = (String)session.getAttribute(MemberSessionUtils.MEMBER_SESSION_KEY);
    System.out.println("Member ID: " + memberId);
} else {
    System.out.println("Session or attribute not found");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>프로필 수정</title>

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
    // 페이지 로딩 시 자동으로 Ajax 요청 보내기
    var memberId = '<%= memberId %>'; 
    var url = '<c:url value="/member/update"/>' + '?memberId=' + memberId;

    $.ajax({
        type: "GET",
        url: url,
        method: 'GET',
        success: function(response) {
            console.log('프로필 수정 섹션 로드 성공');
            $('#editProfile').html(response);
        },
        error: function() {
            console.error('프로필 수정 섹션을 불러오는 데 실패했습니다.');
        }
    });
    
    $(".editProfile").click(function() {
        console.log('컨텐츠 로딩 중: editProfile');
        var memberId = $(this).attr("id");
        var url = '<c:url value="/member/update"/>' + '?memberId=' + memberId;
        
    	 // showPostList 영역 초기화
        $('#showPostList').html('');

        $.ajax({
            type: "GET",
            url: url,
            method: 'GET',
            success: function(response) {
                console.log('프로필 수정 섹션 로드 성공');
                $('#editProfile').html(response);
            },
            error: function() {
                console.error('프로필 수정 섹션을 불러오는 데 실패했습니다.');
            }
        });
    });


    // 게시글 리스트 로딩
    $(".showPostList").click(function() {
        console.log('컨텐츠 로딩 중: showPostList');
        var url = '<c:url value="/memberInfo/myPost"/>' + '?memberId=' + memberId;
        
        // editProfile 영역 초기화
        $('#editProfile').html('');      
        $('#showBookmarkList').html('');

        $.ajax({
            type: "GET",
            url: url,
            method: 'GET',
            success: function(response) {
                console.log('게시글 리스트 섹션 로드 성공');
                $('#showPostList').html(response);
            },
            error: function() {
                console.error('게시글 리스트 섹션을 불러오는 데 실패했습니다.');
            }
        });
    });
    
 // 북마크 게시글 리스트 로딩
    $(".showBookmarkList").click(function() {
        console.log('컨텐츠 로딩 중: showBookmarkList');
        var memberId = $(this).attr("id");
        var url = '<c:url value="/memberInfo/myBookmark"/>' + '?memberId=' + memberId;
        
        // editProfile 영역 초기화
        $('#editProfile').html('');      
        $('#showPostList').html('');

        $.ajax({
            type: "GET",
            url: url,
            method: 'GET',
            success: function(response) {
                console.log('게시글 리스트 섹션 로드 성공');
                $('#showBookmarkList').html(response);
            },
            error: function() {
                console.error('게시글 리스트 섹션을 불러오는 데 실패했습니다.');
            }
        });
    });
});

function logout() {
    var logoutLink = document.createElement('a');
    logoutLink.href = '<c:url value="/member/logout"/>';
    logoutLink.click();
}
</script>

</head>
<body>
<body align="center">
	<jsp:include page="../mainPage/navBar.jsp"></jsp:include>
	<form name="form" method="POST"
		action="<c:url value='/member/update'/>">
		
		<div style="width: 1920px; height: 1080px; position: relative; background: white">
			<div id="showBothScreens" style="width: 435px; height: 930px; position: relative; background: white">
			
				<!-- 프로필 사진 -->
				<img
					src="${pageContext.request.contextPath}/upload/${memberInfo.profilePicture}"
					alt="이미지 안뜸"
					style="width: 196px; height: 196px; left: 125px; top: 100px; position: absolute; background: #D9D9D9; border-radius: 9999px" />
				
				<!-- 닉네임 -->
				<div style="left: 175px; top: 329px; position: absolute; color: #484848; font-size: 30px; font-family: Inter; font-weight: 700; word-wrap: break-word; text-align: center;">
					${memberInfo.nickname}
				</div>

				<!-- 프로필 수정 버튼 -->
				<div class="editProfile" id="${memberInfo.memberId}" href="#"
					style="padding-top: 13px; padding-bottom: 12px; padding-left: 39px; padding-right: 40px; left: 120px; top: 420px; position: absolute; background: white; border-radius: 28px; overflow: hidden; border: 2px #FF7C33 solid; justify-content: center; align-items: center; display: inline-flex">
					<input class="Frame24" type="button" value="프로필 수정"
						style="color: #FF7C33; font-size: 20px; font-family: Inter; font-weight: 700; word-wrap: break-word; border: none; background: none; cursor: pointer;">
				</div>
				
				<!-- 로그아웃 버튼 -->
				<div
					style="padding-top: 13px; padding-bottom: 12px; padding-left: 51px; padding-right: 51px; left: 130px; top: 829px; position: absolute; background: #FF7C33; border-radius: 28px; overflow: hidden; border: 1px #FF7C33 solid; justify-content: center; align-items: center; display: inline-flex">
					<input type="button" value="로그아웃" onClick="logout()"
						style="color: white; font-size: 20px; font-family: Inter; font-weight: 700; word-wrap: break-word; border: none; background: none; cursor: pointer;">
				</div>
				
				<!-- 마이페이지 좌측 메뉴 -->
				<div style="height: 95px; padding-top: 33px; padding-bottom: 8px; padding-left: 27px; padding-right: 26px; left: 0px; top: 470px; position: absolute; flex-direction: column; justify-content: flex-end; align-items: center; gap: 30px; display: inline-flex">
					<div class="showPostList" id="${memberInfo.memberId}" href="#"
						style="color: #484848; font-size: 20px; font-family: Inter; font-weight: 700; word-wrap: break-word">
						<input class="Frame24" type="button" value="내가 쓴 게시글"
							style="color: #FF7C33; font-size: 20px; font-family: Inter; font-weight: 700; word-wrap: break-word; border: none; background: none; cursor: pointer;" />
					</div>
					<div style="width: 382px; height: 0px; border: 0.60px #B6B6B6 solid"></div>
				</div>

				<div class="showBookmarkList" id="${memberInfo.memberId}" href="#"
					style="height: 95px; padding-top: 33px; padding-bottom: 8px; padding-left: 27px; padding-right: 26px; left: 0px; top: 570px; position: absolute; flex-direction: column; justify-content: flex-end; align-items: center; gap: 30px; display: inline-flex">
					<div style="color: #484848; font-size: 20px; font-family: Inter; font-weight: 500; word-wrap: break-word">
						<input class="Frame24" type="button" value="북마크한 글" style="color: #FF7C33; font-size: 20px; font-family: Inter; font-weight: 700; word-wrap: break-word; border: none; background: none; cursor: pointer;" />
					</div>
					<div style="width: 382px; height: 0px; border: 0.60px #B6B6B6 solid"></div>
				</div>

		

				<!-- 매너온도 -->
				<div style="left: 148px; top: 58px; position: absolute">
					<div class="FluentTemperature16Filled"
						style="width: 24px; height: 27px; left: 2px; top: 2px; position: absolute; flex-direction: column; justify-content: flex-start; align-items: flex-start; display: inline-flex">
						<div style="width: 12px; height: 22.50px; background: #fff"></div>
					</div>
					<div style="left: 18px; top: -1px; width: 150px; position: absolute; color: #FF7C33; font-size: 23px; font-family: Inter; font-weight: 700; word-wrap: break-word">
						
					</div>
				</div>
			</div>
			<div style="left: 300px; top: 0px; position: absolute">

				<div class="Frame1"
					style="width: 1149px; height: 240.21px; left: 400px; top: 0px; position: absolute; flex-direction: column; justify-content: flex-start; align-items: flex-start; display: inline-flex">
					<div id="editProfile"></div>
					<!-- 커뮤니티 상세 정보가 출력될 영역 -->

					<div id="showPostList"></div>
					<!-- 커뮤니티 회원 리스트가 출력될 영역 -->
					
					<div id="showBookmarkList"></div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>