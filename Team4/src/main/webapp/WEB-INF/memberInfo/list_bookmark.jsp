<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 북마크한 글</title>

<style>
/* a:hover는 a:link, a:visited 뒤에 와야 합니다.
   a:active는 a:hover 뒤에 와야 합니다.*/
	.title:link, /* 링크 방문 전 */
	.title:visited { /* 방문한 적 있는 링크 */
	  text-decoration: none;
	  color: #2e2e2e;
	}
	 
	.title:hover, /* 마우스 올려둘 때 */
	.title:active { /* 마우스로 클릭하고 있는 동안 */
	  text-decoration: underline;
	  color: #2e2e2e;
	}
	
	.content:link,
	.content:visited { 
	  text-decoration: none;
	  color: #4d4d4d;
	}
	 
	.content:hover,
	.content:active { 
	  text-decoration: underline;
	  color: #4d4d4d;
	}
</style>
</head>
<body> 
	<!-- 리스트 반복 -->
 	<c:forEach var="post" items="${bookmarkList}" > 
 		<!-- 포스트 요소들 분리시켜줌, margin:auto; 적용하면 반응형 됨 -->
		<div class="post-list" style="height:300px; width:100px; top:30px; margin:auto; position: relative;"> 
			<!-- 리스트 하나의 전체적인 위치인듯 -->
			<div style="width: 1435px; height: 300px; position: absolute; overflow: hidden; left: 50%; transform: translateX(-50%);">
				<!-- 포스트 이미지 --> 
				<div style="width: 209px; height: 209px; position: absolute; left: 44px; top: 45px; background: #c3c3c3;">
					<a href="<c:url value='/post/detailPage'/>?postId=${post.postId}">
					 	<img class="post-image h-[209px] absolute left-11 top-[45px]" src="<c:out value="${post.image}"/>" alt="Post Image" style="width: 100%; height: 100%;">
					</a>
				</div>
				<!-- 포스트 제목 --> 
				<span style="position: absolute; left: 285px; top: 45px; font-size: 30px; font-weight: 650; text-align: left; color: #2e2e2e;">
					<a class="title" href="<c:url value='/post/detailPage'/>?postId=${post.postId}"><c:out value="${post.title}"/></a>
				</span>
				<!-- 포스트 내용 --> 
				<span style="position: absolute; left: 285px; top: 120px; font-size: 18px; text-align: left; color: #4d4d4d;
					max-width: 10px; white-space: nowrap; text-overflow: ellipsis;">
					<a class="content" href="<c:url value='/post/detailPage'/>?postId=${post.postId}"><c:out value="${post.content}"/></a>
				</span>
				
				<div style="position: absolute; left: 900px; top: 45px;">
					<!-- 지도마커 표시 -->
					<div style="position:absolute; width:100px; left:60px; top: 10px;">
						<svg width="34" height="34" viewBox="0 0 34 34" fill="none"
							xmlns="http://www.w3.org/2000/svg"
							style="width: 34px; height: 34px; position: absolute;"
							preserveAspectRatio="none">
			          			<path d="M19.4565 30.906C23.1604 27.6462 29.75 20.9865 29.75 14.875C29.75 11.4935 28.4067 8.25048 26.0156 5.85939C23.6245 3.4683 20.3815 2.125 17 2.125C13.6185 2.125 10.3755 3.4683 7.98439 5.85939C5.5933 8.25048 4.25 11.4935 4.25 14.875C4.25 20.9865 10.8375 27.6462 14.5435 30.906C15.2195 31.5094 16.0939 31.8428 17 31.8428C17.9061 31.8428 18.7805 31.5094 19.4565 30.906ZM12.75 14.875C12.75 13.7478 13.1978 12.6668 13.9948 11.8698C14.7918 11.0728 15.8728 10.625 17 10.625C18.1272 10.625 19.2082 11.0728 20.0052 11.8698C20.8022 12.6668 21.25 13.7478 21.25 14.875C21.25 16.0022 20.8022 17.0832 20.0052 17.8802C19.2082 18.6772 18.1272 19.125 17 19.125C15.8728 19.125 14.7918 18.6772 13.9948 17.8802C13.1978 17.0832 12.75 16.0022 12.75 14.875Z"
									fill="#FF7C33"></path>
			        	</svg>
					</div>
					<!-- 북마크 -->
					<!-- 북마크 이미지 24px로 수정하기 -->
						<!-- 북마크 전 -->
						<button id="bookmarkOff${post.postId}" onclick="clickBookmarkOff(${post.postId})" style="position:absolute; width:100px; left:300px; top: 10px; border:none; background:#fff;">
							<img src="${pageContext.request.contextPath}/images/bookmark_off_small.png" />
						</button>
						
						<!--  북마크 후 -->
						<button id="bookmarkOn${post.postId}" onclick="clickBookmarkOn(${post.postId})" style="position:absolute; width:100px; left:300px; top: 10px; border:none; background:#fff;">			
							<img src="${pageContext.request.contextPath}/images/bookmark_on_small.png" />
						</button>
				</div>
		    </div>
		</div>
		<!-- 리스트 구분선 -->
		<hr style="border:0; height:1px; background:#D5D5D5; margin:auto; width:1250px;"/>
	</c:forEach> 
	
</body>
</html>