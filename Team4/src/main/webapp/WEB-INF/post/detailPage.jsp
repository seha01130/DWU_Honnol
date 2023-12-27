<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="model.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="controller.member.MemberSessionUtils" %>
<!DOCTYPE html>
<html>
<%
String memberId = null;
if (session != null && session.getAttribute(MemberSessionUtils.MEMBER_SESSION_KEY) != null) {
    // 세션에서 memberId를 가져옴
    memberId = (String)session.getAttribute(MemberSessionUtils.MEMBER_SESSION_KEY);
    System.out.println("Login Member ID: " + memberId);
} else {
    System.out.println("Session or attribute not found");
}
%>
<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>게시글</title>
<script src="https://cdn.tailwindcss.com"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

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
    // 페이지 로딩 시 자동으로 댓글 가져오기
	 var writerId = "${writerInfo.memberId}";
	 var memberId = '<%=memberId%>';
	 var urlParams = new URLSearchParams(window.location.search);
	 var postId = "${post.postId}";
	    
	 console.log("redirect: " + '<c:url value="/post/detailPage"/>' + '?postId=' + postId + '&memberId=' + writerId);
	 
	if(writerId===memberId) {
    	deleteBtn.type = 'button';
    	removeBtn.type = 'button';
    	deleteBtn_bg.style.display='';
    	removeBtn_bg.style.display='';
    }
	
	
	
});

document.addEventListener('DOMContentLoaded', function () {
	var bookmarkOn = document.getElementById("bookmarkOn");
	var bookmarkOff = document.getElementById("bookmarkOff");
	var isBookmarked = "${isBookmarked}";
	
	
	console.log("진입시 북마크 되어있나요? : " + isBookmarked);

	if (parseInt(isBookmarked) === 0) {
	    bookmarkOff.style.display = 'none';
	    bookmarkOn.style.display = '';
	} else {
	    bookmarkOn.style.display = 'none';
	    bookmarkOff.style.display = '';
	}
	

});

function updatePost() {
    var updateLink = document.createElement('a');
    updateLink.href = "<c:url value='/post/update'><c:param name='postId' value='${post.postId}'/></c:url>";
    updateLink.click();
  }
  
function deletePost() {
    var confirmation = confirm("정말 삭제하시겠습니까?");
    
    if (confirmation) {
        var deleteLink = document.createElement('a');
        deleteLink.href = "<c:url value='/post/delete'><c:param name='postId' value='${post.postId}'/><c:param name='memberId' value='<%=memberId%>'/></c:url>";
        deleteLink.click();
    }
}
function clickBookmarkOn() {
	
	bookmarkOn.style.display = 'none';
	bookmarkOff.style.display = '';
	// 북마크 개수 감소 
    var memberId = '<%= memberId %>';
    var postId = "${post.postId}";
    var bookmarkCount = "${post.myBookmarks}" + 1;

    var url = '/UserMan3/post/countBookmark?memberId=' + memberId + '&postId=' + postId + '&bookmarkCount=' + bookmarkCount;

	$.ajax({
        type: "GET",
        url: url,
        method: 'GET',
        success: function(response) {
            console.log('서버 응답:', response);
            
            var responseData = JSON.parse(response);
            document.getElementById("bookmarkCount").innerText = responseData.bookmarkCount;
        	
        },
        error: function() {
            console.error('서버 요청 실패');
        }
    }); 

}
function clickBookmarkOff() {
    var bookmarkOn = document.getElementById("bookmarkOn");
    var bookmarkOff = document.getElementById("bookmarkOff");
    bookmarkOff.style.display = 'none';
    bookmarkOn.style.display = '';

    // 북마크 개수 감소 
    var memberId = '<%= memberId %>';
    var postId = "${post.postId}";
    
    var bookmarkCount = "${post.myBookmarks}" - 1;
    if(bookmarkCount < 0)
    	bookmarkCount = 0;
    // URL 수정
    var url = '/UserMan3/post/countBookmark?memberId=' + memberId + '&postId=' + postId + '&bookmarkCount=' + bookmarkCount;

	$.ajax({
        type: "GET",
        url: url,
        method: 'GET',
        success: function(response) {
            console.log('서버 응답:', response);
            
            var responseData = JSON.parse(response);
            document.getElementById("bookmarkCount").innerText = responseData.bookmarkCount;
        	
        },
        error: function() {
            console.error('서버 요청 실패');
        }
    }); 

    // 여기에 클릭 이벤트 발생시 추가로 실행되는 로직을 작성할 수 있습니다.
    // 예: 다른 UI 업데이트, 추가 비동기 요청 등
}


function createReply() {
    // Get the value from the textarea with id 'contentId'
    var replyContent = document.getElementById('contentId').value;

    var addLink = document.createElement('a');
    // Construct the URL with the replyContent value
    addLink.href = '<c:url value="/reply/create"/>' + '?postId=' + '${post.postId}' + '&replyContent=' + encodeURIComponent(replyContent);
    addLink.click();
}
function updateCharCount() {
    var textarea = document.getElementById('contentId');
    var charCount = document.getElementById('charCount');
    var currentCount = textarea.value.length;

    charCount.textContent = '글자 수: ' + currentCount + ' / 150';

    // 여기서 200은 최대 글자 수입니다. 필요에 따라 조절하세요.
    if (currentCount > 150) {
        textarea.value = textarea.value.substring(0, 150);
        charCount.textContent = '글자 수: 150 / 150';
    }
}
</script>
</head>
<body>
	
   <div style="width: 1920px; height: 2001px; position: absolute; background: #fff;">
   
   <input type="hidden" name="postId" value="${post.postId}" />   
   
      
      <div style="width: 1920px; height: 150px; position: absolute; left: 0px; top: 0px; overflow: hidden; background: #fff;">
         <!-- 페이지 로고 표시 -->
         <a class="logo" style="font-size: 50px; text-align: left; color: #ff7c33;" href="<c:url value='/mainPage/mainLogin'/>">
         <p style="position: absolute; left: 250px; top: 40px; font-size: 40px; text-align: center; font-weight:bold; color: #ff7c33;">
            HONNOL</p></a>
         <!-- 수정 버튼 -->  
         <div id="removeBtn_bg" style="width: 157px; height: 52px; position: absolute; display:none; left: 1350px; top: 56px; overflow: hidden; border-radius: 50px; border-width: 2px; border-color: #ff7c33;">
            <input id="removeBtn" type="hidden" value="수정" onClick="updatePost()"
            style="cursor: pointer; position: absolute; left: 60px; top: 15px; font-size: 20px; font-weight: bold; text-align: left; color: #5a5a5a;">
         </div>
         <!-- 삭제 버튼 -->
         <div id="deleteBtn_bg" style="width: 158px; height: 53px; position: absolute; display:none; left: 1532px; top: 54px; overflow: hidden; border-radius: 62px; background: #ff7c33;">
            <input id="deleteBtn" type="hidden" value="삭제" onClick="deletePost()"
               style="cursor: pointer; position: absolute; left: 61px; top: 15px; font-size: 20px; font-weight: bold; text-align: center; color: #fff;">
         </div>
      </div>
      
      <!-- 작성자 프로필사진 -->
      <a href="<c:url value='/memberInfo/myPage'/>?memberId=${writerInfo.memberId}">
        <img src="<c:url value='/upload/${writerInfo.profilePicture}'/>" alt="이미지 안뜸" 
           style="width: 80px; height: 80px; left: 280px; top: 170px; position: absolute; background: #D9D9D9; border-radius: 9999px" />
        <!-- 작성자 닉네임 -->
         <p style="position: absolute; left: 371px; top: 190px; font-size: 30px; font-weight: 700; text-align: left; color: #5a5a5a;">
            ${writerInfo.nickname}
         </p>
      </a>
      <!-- 게시글 제목 -->
      <span style="position: absolute; left: 50%; transform: translateX(-50%); top: 169px; font-size: 50px; font-weight: 700; text-align: center; color: #4a4a4a;">
    		${post.title}
	  </span>

      <!-- 게시글 주소 -->
      <span style="position: absolute; left: 50%; transform: translateX(-50%); top: 299px; font-size: 20px; text-align: center; color: #6f6f6f;">
    	${post.locationAddress}
	</span>

              
      <div style="width: 164px; height: 36px;">
         <p style="position: absolute; left: 50%; transform: translateX(-50%); top: 249px; font-size: 30px; text-align: center; color: #4a4a4a;">
    		${post.locationName}
		</p>

         <!-- 지도마커 표시 -->
            <svg width="34" height="34" viewBox="0 0 34 34" fill="none"
               xmlns="http://www.w3.org/2000/svg"
               style="width: 34px; height: 34px; position: absolute; left: 850px; top: 255px;"
               preserveAspectRatio="none">
                      <path d="M19.4565 30.906C23.1604 27.6462 29.75 20.9865 29.75 14.875C29.75 11.4935 28.4067 8.25048 26.0156 5.85939C23.6245 3.4683 20.3815 2.125 17 2.125C13.6185 2.125 10.3755 3.4683 7.98439 5.85939C5.5933 8.25048 4.25 11.4935 4.25 14.875C4.25 20.9865 10.8375 27.6462 14.5435 30.906C15.2195 31.5094 16.0939 31.8428 17 31.8428C17.9061 31.8428 18.7805 31.5094 19.4565 30.906ZM12.75 14.875C12.75 13.7478 13.1978 12.6668 13.9948 11.8698C14.7918 11.0728 15.8728 10.625 17 10.625C18.1272 10.625 19.2082 11.0728 20.0052 11.8698C20.8022 12.6668 21.25 13.7478 21.25 14.875C21.25 16.0022 20.8022 17.0832 20.0052 17.8802C19.2082 18.6772 18.1272 19.125 17 19.125C15.8728 19.125 14.7918 18.6772 13.9948 17.8802C13.1978 17.0832 12.75 16.0022 12.75 14.875Z"
                     fill="#FF7C33"></path>
              </svg>
      </div>
      
      <!--  게시글 내용 -->
      <p style="width: 1270px; position: absolute; left: 327px; top: 950px; font-size: 24px; text-align: left; color: #6f6f6f;">
         ${post.content}</p>
      
      <!-- 북마크 표시 -->
      <!-- 북마크 전 -->
		<button id="bookmarkOff" onclick="clickBookmarkOff()" style="display:''; position:absolute; width:40px; left: 1620px; top: 190px; border:none; background:#fff;">
			<img src="${pageContext.request.contextPath}/images/bookmark_off.png" />
		</button>
						
		<!--  북마크 후 -->
		<button id="bookmarkOn" onclick="clickBookmarkOn()" style="display:''; position:absolute; width:40px; left: 1620px; top: 190px; border:none; background:#fff;">			
			<img src="${pageContext.request.contextPath}/images/bookmark_on.png" />
		</button>
        <!-- 북마크 개수 표시 -->
      	<p id="bookmarkCount" style="position: absolute; left: 1680px; top: 186px; font-size: 24px; text-align: left; color: #6a6a6a;">
            
        </p>
      
      <!-- 이미지 -->
      <div style="width: 1458px; height: 430px;">
        <div style="width: 430px; height: 430px; position: absolute; left: 744.5px; top: 370.5px; background: rgba(217, 217, 217, 0.3); display: flex; justify-content: center; align-items: center;">
    		<img src="<c:url value='/upload/${post.image}'/>" style="max-width: 100%; max-height: 100%;" />
		</div>
      </div>
      
	 <!-- ----------------댓글부분------------------- -->
      <svg
        width="1675"
        height="1"
        viewBox="0 0 1673 1"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
        style="position: relative; left:110px; top:600px";
        preserveAspectRatio="xMidYMid meet">
        <line y1="0.5" x2="1673" y2="0.5" stroke="#969696"></line>
      </svg>
      <div style="left:120px; top: 630px; position: relative; ">
      <p style=" height:70px; font-size: 30px; font-weight: 700; text-align: left; color: #5a5a5a;">댓글</p>
      <textarea name="replyContent" id="contentId" style="width: 1600px; height: 220px; background: #fff; border-width: 1px; border-color: #6f6f6f; font-size: 30px;" oninput="updateCharCount();"></textarea>
       <div id="charCount">글자 수: 0 / 150</div>
      <div style="width: 97px; left:1500px; top:10px; height: 53px; position: relative; border-radius: 50px; border-width: 2px; border-color: #ff7c33;">
        <input type="button" value="등록" onClick="createReply()" style="position: absolute; left: 28px; top: 10px; font-size: 20px; font-weight: 400; text-align: left; color: #5a5a5a; cursor:pointer;"/>
      </div>
    
      <div id="showReply" style="position:absolute;">
         <c:forEach var="reply" items="${replyList}" > 
      <div style="height:230px;">
      <div style="width: 1596px; height: 196px; position: absolute">
      <!-- 이게이미지 -->
          <img src="<c:url value='/upload/${reply.profilePicture}'/>" style="width: 73px; height: 73px; left: 0px; top: 17px; position: absolute; background: #D9D9D9; border-radius: 9999px"/>
          <div style="left: 94px; top: 38px; position: absolute; color: #5A5A5A; font-size: 26px; font-family: Inter; font-weight: 700; word-wrap: break-word">${reply.nickname}</div>
          <div style="width: 1595px; height: 82px; left: 1px; top: 114px; position: absolute; color: #5A5A5A; font-size: 20px; font-family: Inter; font-weight: 400; word-wrap: break-word">${reply.content}</div>
              <!-- 이게 선 -->
         <hr style="width: 1596px; height: 0.3px; top: 196px; position: absolute; border: none; background-color: #969696;">
         <!-- 이게 날짜 -->
          <div style="left: 210px; top: 45px; position: absolute; color: #6B6B6B; font-size: 14px; font-family: Inter; font-weight: 400; word-wrap: break-word">${reply.createDate}</div>
        </div>
        </div>
     </c:forEach> 
      </div>
      </div>
         </div>
   </body>
</html>
