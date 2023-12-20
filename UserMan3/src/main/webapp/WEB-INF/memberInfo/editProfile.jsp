<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>프로필 수정</title>

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
    // 페이지 로딩 시 자동으로 Ajax 요청 보내기
    var memberId = "seha"; // 사용자 아이디 설정 (실제로는 동적으로 설정해야 함)
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
        var url = '<c:url value="/member/update"/>' + '?memberId=' + 'seha';
        
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
        var memberId = $(this).attr("id");
        var url = '<c:url value="/memberInfo/myPost"/>' + '?memberId=' + "seha";
        
        // editProfile 영역 초기화
        $('#editProfile').html('');

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
});
</script>

</head>
<body>
<hr>
<body align="center">
	<form name="form" method="POST"
		action="<c:url value='/member/update'/>">
		<div
			style="width: 1920px; height: 1080px; position: relative; background: white">
			<div id="showBothScreens"
				style="width: 435px; height: 930px; position: relative; background: white">
				<img
					src="${pageContext.request.contextPath}/upload/${memberInfo.profilePicture}"
					alt="이미지 안뜸"
					style="width: 196px; height: 196px; left: 125px; top: 100px; position: absolute; background: #D9D9D9; border-radius: 9999px" />

				<div
					style="left: 155px; top: 329px; position: absolute; color: #484848; font-size: 30px; font-family: Inter; font-weight: 700; word-wrap: break-word; text-align: center;">${memberInfo.nickname}</div>

				<div class="editProfile" id="${memberInfo.memberId}" href="#"
					style="padding-top: 13px; padding-bottom: 12px; padding-left: 39px; padding-right: 40px; left: 130px; top: 383px; position: absolute; background: white; border-radius: 28px; overflow: hidden; border: 2px #FF7C33 solid; justify-content: center; align-items: center; display: inline-flex">
					<input class="Frame24" type="button" value="프로필 수정"
						style="color: #FF7C33; font-size: 20px; font-family: Inter; font-weight: 700; word-wrap: break-word; border: none; background: none; cursor: pointer;">
				</div>
				<!-- 버튼크기수정 -->

				<div
					style="padding-top: 13px; padding-bottom: 12px; padding-left: 51px; padding-right: 51px; left: 130px; top: 829px; position: absolute; background: #FF7C33; border-radius: 28px; overflow: hidden; border: 1px #FF7C33 solid; justify-content: center; align-items: center; display: inline-flex">
					<input class="Frame28" type="button" value="로그아웃" onClick=""
						style="color: white; font-size: 20px; font-family: Inter; font-weight: 700; word-wrap: break-word; border: none; background: none;">
				</div>
				<!-- 버튼크기수정 -->

				<div
					style="height: 95px; padding-top: 33px; padding-bottom: 8px; padding-left: 27px; padding-right: 26px; left: 0px; top: 480px; position: absolute; flex-direction: column; justify-content: flex-end; align-items: center; gap: 30px; display: inline-flex">
					<div class="showPostList" id="${memberInfo.memberId}" href="#"
						style="color: #484848; font-size: 20px; font-family: Inter; font-weight: 700; word-wrap: break-word">
						<input class="Frame24" type="button" value="내가 쓴 게시글"
							style="color: #FF7C33; font-size: 20px; font-family: Inter; font-weight: 700; word-wrap: break-word; border: none; background: none; cursor: pointer;" />
					</div>
					<div
						style="width: 382px; height: 0px; border: 0.60px #B6B6B6 solid"></div>
				</div>

				<div
					style="height: 95px; padding-top: 33px; padding-bottom: 8px; padding-left: 27px; padding-right: 26px; left: 0px; top: 575px; position: absolute; flex-direction: column; justify-content: flex-end; align-items: center; gap: 30px; display: inline-flex">
					<div
						style="color: #484848; font-size: 20px; font-family: Inter; font-weight: 500; word-wrap: break-word">내
						모임</div>
					<div
						style="width: 382px; height: 0px; border: 0.60px #B6B6B6 solid"></div>
				</div>

				<div
					style="width: 435px; height: 95px; padding-top: 33px; padding-bottom: 38px; left: 0px; top: 670px; position: absolute; justify-content: center; align-items: center; display: inline-flex">
					<div
						style="color: #484848; font-size: 20px; font-family: Inter; font-weight: 500; word-wrap: break-word">북마크한
						글</div>
				</div>

				<div style="left: 148px; top: 58px; position: absolute">
					<div class="FluentTemperature16Filled"
						style="width: 24px; height: 24px; left: 0px; top: 0px; position: absolute; flex-direction: column; justify-content: flex-start; align-items: flex-start; display: inline-flex">
						<div style="width: 12px; height: 22.50px; background: #FF7C33"></div>
					</div>

					<div
						style="left: 26.40px; top: 2.40px; width: 100px; position: absolute; color: #FF7C33; font-size: 16px; font-family: Inter; font-weight: 700; word-wrap: break-word">매너온도
						${memberInfo.rating}도</div>
				</div>
			</div>
			<div style="left: 300px; top: 0px; position: absolute">

				<div class="Frame1"
					style="width: 1149px; height: 240.21px; left: 400px; top: 0px; position: absolute; flex-direction: column; justify-content: flex-start; align-items: flex-start; display: inline-flex">
					<div id="editProfile"></div>
					<!-- 커뮤니티 상세 정보가 출력될 영역 -->

					<div id="showPostList"></div>
					<!-- 커뮤니티 회원 리스트가 출력될 영역 -->
				</div>
			</div>
		</div>
	</form>
</body>


</html>