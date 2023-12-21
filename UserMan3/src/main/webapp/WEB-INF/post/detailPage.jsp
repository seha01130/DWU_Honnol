<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="model.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>게시글 상세페이지</title>
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<style>
html, body {
	height: 100%;
	display: flex;
	flex-direction: column;
	flex: 1;
	width: 100%;
	height: 100%;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	margin: 0; /* 중앙정렬을 위한 추가 */
}
/* 중앙정렬을 위한 추가*/
body {
	display: flex;
	justify-content: center;
	align-items: center;
}
.comment-container {
    display: flex;
    flex-direction: column;
    margin-bottom: 15px; /* 예시로 간격 조절 */
  }
</style>
<script>
$(document).ready(function() {
    // 페이지 로딩 시 자동으로 Ajax 요청 보내기
    var memberId = 'seha';// 사용자 아이디 설정 (실제로는 동적으로 설정해야 함)
    var postId = "${post.postId}";
    $(".countBookmark").click(function() {
        var url = '<c:url value="/post/countBookmark"/>' + '?postId=' + postId + '?memberId=' + memberId + '?count=' + 1; 
        
        $.ajax({
            type: "POST",
            url: url,
            method: 'POST',
            success: function(response) {
                console.log('프로필 수정 섹션 로드 성공');
                //$('#editProfile').html(response);
            },
            error: function() {
                console.error('프로필 수정 섹션을 불러오는 데 실패했습니다.');
            }
        });
    });

});
function increaseBookmarkCount() {
    var xhr = new XMLHttpRequest();
    var url = "/post/countBookmark";
    var params = "postId=${post.postId}";  // 게시글의 ID 또는 식별자 (실제로는 해당 게시글의 ID를 전달해야 함)
	var params2 = "count=" + 1;
	
    xhr.open("POST", url, true);
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            // 서버 응답 성공 시, 북마크 개수 업데이트
            var response = JSON.parse(xhr.responseText);
            document.getElementById("bookmarkCount").innerText = response.bookmarkCount;
        }
    };

    xhr.send(params, params2);
}
function updatePost() {
    var updateLink = document.createElement('a');
    updateLink.href = "<c:url value='/post/update'><c:param name='postId' value='${post.postId}'/></c:url>";
    updateLink.click();
  }
  
function deletePost() {
    var confirmation = confirm("정말 삭제하시겠습니까?");
    
    if (confirmation) {
        var deleteLink = document.createElement('a');
        deleteLink.href = "<c:url value='/post/delete'><c:param name='postId' value='${post.postId}'/></c:url>";
        deleteLink.click();
    }
}
function clickBookmarkOn() {
	var bookmarkOn = document.getElementById("bookmarkOn");
	var bookmarkOff = document.getElementById("bookmarkOff");
	bookmarkOn.style.display = 'none';

	bookmarkOff.style.display = '';

}
function clickBookmarkOff() {
	var bookmarkOn = document.getElementById("bookmarkOn");
	var bookmarkOff = document.getElementById("bookmarkOff");
	bookmarkOff.style.display = 'none';
	bookmarkOn.style.display = '';
}

</script>
</head>
<body>
	<div style="width: 1920px; height: 2001px; position: relative; background: #fff;">
	
		<!-- HONNOL 수정 삭제 -->
		<div style="width: 1920px; height: 150px; position: absolute; left: 0px; top: 0px; overflow: hidden; background: #fff;">
			<p style="position: absolute; left: 162px; top: 51px; font-size: 40px; text-align: left; color: #ff7c33;">
				HONNOL</p>
			<div style="width: 157px; height: 52px; position: absolute; left: 1518px; top: 49px; overflow: hidden; border-radius: 50px; border-width: 2px; border-color: #ff7c33;">
				<input type="button" value="수정" onClick="updatePost()"
				style="position: absolute; left: 60px; top: 14px; font-size: 20px; font-weight: 700; text-align: left; color: #5a5a5a;">
			</div>
			<div style="width: 158px; height: 53px; position: absolute; left: 1700px; top: 48px; overflow: hidden; border-radius: 62px; background: #ff7c33;">
				<input type="button" value="삭제" onClick="deletePost()"
					style="position: absolute; left: 61px; top: 15px; font-size: 20px; font-weight: 700; text-align: left; color: #fff;">
			</div>
		</div>
		
		<!-- 글작성자 프로필사진 / 닉네임 부분 -->
		<svg width="73" height="73" viewBox="0 0 73 73" fill="none"
			xmlns="http://www.w3.org/2000/svg"
			style="position: absolute; left: 276px; top: 162px;"
			preserveAspectRatio="xMidYMid meet">
        	<circle cx="36.5" cy="36.5" r="36.5" fill="#D9D9D9"></circle>
      	</svg>
		<p style="position: absolute; left: 371px; top: 182px; font-size: 30px; font-weight: 700; text-align: left; color: #5a5a5a;">
			${post.nickname}</p>
		
		<!-- 제목 주소 이미지 내용 -->
		<p style="position: absolute; left: 914px; top: 169px; font-size: 50px; font-weight: 700; text-align: left; color: #4a4a4a;">
			${post.title}</p>
		<p style="position: absolute; left: 920px; top: 299px; font-size: 20px; text-align: left; color: #6f6f6f;">
			상세 주소</p>
		<p style="width: 1270px; position: absolute; left: 327px; top: 950px; font-size: 24px; text-align: left; color: #6f6f6f;">
			${post.content}</p>			
		<div style="width: 164px; height: 36px;">
			<p style="position: absolute; left: 914px; top: 249px; font-size: 30px; text-align: left; color: #4a4a4a;">
				${post.locationId}</p>
			<!-- 지도마커 표시 -->
				<svg width="34" height="34" viewBox="0 0 34 34" fill="none"
					xmlns="http://www.w3.org/2000/svg"
					style="width: 34px; height: 34px; position: absolute; left: 869px; top: 250px;"
					preserveAspectRatio="none">
	          			<path d="M19.4565 30.906C23.1604 27.6462 29.75 20.9865 29.75 14.875C29.75 11.4935 28.4067 8.25048 26.0156 5.85939C23.6245 3.4683 20.3815 2.125 17 2.125C13.6185 2.125 10.3755 3.4683 7.98439 5.85939C5.5933 8.25048 4.25 11.4935 4.25 14.875C4.25 20.9865 10.8375 27.6462 14.5435 30.906C15.2195 31.5094 16.0939 31.8428 17 31.8428C17.9061 31.8428 18.7805 31.5094 19.4565 30.906ZM12.75 14.875C12.75 13.7478 13.1978 12.6668 13.9948 11.8698C14.7918 11.0728 15.8728 10.625 17 10.625C18.1272 10.625 19.2082 11.0728 20.0052 11.8698C20.8022 12.6668 21.25 13.7478 21.25 14.875C21.25 16.0022 20.8022 17.0832 20.0052 17.8802C19.2082 18.6772 18.1272 19.125 17 19.125C15.8728 19.125 14.7918 18.6772 13.9948 17.8802C13.1978 17.0832 12.75 16.0022 12.75 14.875Z"
							fill="#FF7C33"></path>
	        	</svg>
		</div>
		
		<!-- 북마크 표시 -->
		<!-- 북마크 -->
		<!-- 북마크 이미지 24px로 수정하기 -->
		<!-- 북마크 전 -->
		<button id="bookmarkOff" onclick="clickBookmarkOff()" style="position:absolute; width:40px; left: 1620px; top: 190px; border:none; background:#fff;">
			<img src="${pageContext.request.contextPath}/images/bookmark_off.png" />
		</button>
						
		<!--  북마크 후 -->
		<button id="bookmarkOn" onclick="clickBookmarkOn()" style="position:absolute; width:40px; left: 1620px; top: 190px; border:none; background:#fff;">			
			<img src="${pageContext.request.contextPath}/images/bookmark_on.png" />
		</button>
		<!-- 
		<button class="countBookmark" onclick="clickBookmarkOn()" style="width: 71px; height: 30px;">
			<svg width="30" height="30" viewBox="0 0 30 30" fill="none"
				xmlns="http://www.w3.org/2000/svg"
				style="width: 30px; height: 30px; position: absolute; left: 1685px; top: 185px;"
				preserveAspectRatio="none">
          <g clip-path="url(#clip0_10_131)">
            <path fill-rule="evenodd" clip-rule="evenodd"
					d="M5 6.25C5 5.25544 5.39509 4.30161 6.09835 3.59835C6.80161 2.89509 7.75544 2.5 8.75 2.5H21.25C22.2446 2.5 23.1984 2.89509 23.9017 3.59835C24.6049 4.30161 25 5.25544 25 6.25V26.285C25 27.81 23.275 28.6975 22.035 27.8113L15 22.7863L7.965 27.8113C6.72375 28.6988 5 27.8112 5 26.2862V6.25ZM8.75 5C8.41848 5 8.10054 5.1317 7.86612 5.36612C7.6317 5.60054 7.5 5.91848 7.5 6.25V25.0712L13.91 20.4925C14.228 20.2653 14.6091 20.1431 15 20.1431C15.3909 20.1431 15.772 20.2653 16.09 20.4925L22.5 25.0712V6.25C22.5 5.91848 22.3683 5.60054 22.1339 5.36612C21.8995 5.1317 21.5815 5 21.25 5H8.75Z"
					fill="#6A6A6A"></path>
          </g>
          <defs>
            <clipPath id="clip0_10_131">
				<rect width="30" height="30" fill="white"></rect></clipPath>
          </defs>
        </svg>-->
        	<!-- 북마크 개수 표시 -->
		<p id="bookmarkCount" style="position: absolute; left: 1680px; top: 186px; font-size: 24px; text-align: left; color: #6a6a6a;">
			${post.myBookmarks}
		</p>
		  
		
		<!-- 이미지 -->
		<div style="width: 1458px; height: 430px;">
			<div style="width: 430px; height: 430px; position: absolute; left: 230.5px; top: 370.5px; background: rgba(217, 217, 217, 0.3);">
				<img src="<c:url value='/upload/${post.image}'/>" />
			</div>
			<div style="width: 430px; height: 430px; position: absolute; left: 744.5px; top: 370.5px; background: #d9d9d9;"></div>
			<div style="width: 430px; height: 430px; position: absolute; left: 1258.5px; top: 370.5px; background: rgba(217, 217, 217, 0.3);"></div>
		</div>
		<!-- 이미지 넘김표시 원형 모양
		<svg width="218" height="15" viewBox="0 0 218 15" fill="none"
			xmlns="http://www.w3.org/2000/svg"
			style="width: 218px; height: 15px;" preserveAspectRatio="none">
	        <circle cx="121.5" cy="7.5" r="7.5" fill="#D9D9D9"></circle>
	        <circle cx="7.5" cy="7.5" r="7.5" fill="#D9D9D9"></circle>
		    <circle cx="166.5" cy="7.5" r="7.5" fill="#D9D9D9"></circle>
		    <circle cx="210.5" cy="7.5" r="7.5" fill="#D9D9D9"></circle>
		    <rect x="41" width="44" height="15" rx="7.5" fill="#FF7C33"></rect>
	   </svg> -->
	   <!-- 이미지 좌우넘김 화살표 -->
		<svg width="40" height="40" viewBox="0 0 40 40" fill="none"
			xmlns="http://www.w3.org/2000/svg"
			style="width: 40px; height: 40px; position: absolute; left: 682px; top: 566px;"
			preserveAspectRatio="xMidYMid meet">
        <path d="M25 10L15 20L25 30" stroke="#858585" stroke-width="2"></path></svg>
		<svg width="40" height="40" viewBox="0 0 40 40" fill="none"
			xmlns="http://www.w3.org/2000/svg"
			style="width: 40px; height: 40px; position: absolute; left: 1239px; top: 566px;"
			preserveAspectRatio="xMidYMid meet">
        <path d="M15 10L25 20L15 30" stroke="#858585" stroke-width="2"></path>
      </svg>
	   
	   <!-- ----------------댓글부분------------------- -->
		<svg width="1673" height="1" viewBox="0 0 1673 1" fill="none"
			xmlns="http://www.w3.org/2000/svg"
			style="position: absolute; left: 122px; top: 1360px;"
			preserveAspectRatio="xMidYMid meet">
        	<line y1="0.5" x2="1673" y2="0.5" stroke="#969696"></line>
      	</svg>
		<p
			style="position: absolute; left: 162px; top: 1401px; font-size: 30px; font-weight: 700; text-align: left; color: #5a5a5a;">
			댓글</p>
			
			
		<c:forEach var="reply" items="${replyList}">	
			<div class="comment-container"
				style="width: 1596px; height: 196px; position: relative; left: 162px; top: 1000px; overflow: hidden;">
				<svg width="73" height="73" viewBox="0 0 73 73" fill="none"
					xmlns="http://www.w3.org/2000/svg"
					style="position: absolute; left: -1px; top: 16px;"
					preserveAspectRatio="xMidYMid meet">
	          		<circle cx="36.5" cy="36.5" r="36.5" fill="#D9D9D9"></circle>
	        	</svg>
				<p
					style="position: absolute; left: 94px; top: 38px; font-size: 26px; font-weight: 700; text-align: left; color: #5a5a5a;">
					닉네임</p>
				<p
					style="width: 1595px; height: 82px; position: absolute; left: 1px; top: 114px; font-size: 20px; text-align: left; color: #5a5a5a;">
					${reply.content}</p>
				<svg width="1596" height="1" viewBox="0 0 1596 1" fill="none"
					xmlns="http://www.w3.org/2000/svg"
					style="position: absolute; left: -1px; top: 195px;"
					preserveAspectRatio="xMidYMid meet">
	          		<line y1="0.5" x2="1596" y2="0.5" stroke="#969696"></line>
	          	</svg>
				<svg width="5" height="21" viewBox="0 0 5 21" fill="none"
					xmlns="http://www.w3.org/2000/svg" style="width: 5px; height: 21px;"
					preserveAspectRatio="none">
	          		<circle cx="2.5" cy="2.5" r="2.5" fill="#959595"></circle>
	          		<circle cx="2.5" cy="10.5" r="2.5" fill="#959595"></circle>
	          		<circle cx="2.5" cy="18.5" r="2.5" fill="#959595"></circle>
	        	</svg>
				<p
					style="position: absolute; left: 187px; top: 45px; font-size: 14px; text-align: left; color: #6b6b6b;">
					2023.08/22</p>
			</div>
		</c:forEach>
		
	</div>
</body>
</html>
