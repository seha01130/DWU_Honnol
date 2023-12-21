<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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
<script>
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
	<!-- 리스트 반복 -->
 	<c:forEach var="post" items="${postList}" > 
 		<!-- 포스트 요소들 분리시켜줌, margin:auto; 적용하면 반응형 됨 -->
		<div class="post-list" style="height:300px; width:1500px; margin:auto; left: 50px; position: relative;"> 
			<!-- 리스트 하나의 전체적인 위치인듯 -->
			<div style="width: 1435px; height: 300px; position: absolute; overflow: hidden; left: 50%; transform: translateX(-50%);">
				
				<!-- 포스트 이미지 --> 
				<div style="width: 209px; height: 209px; position: absolute; left: 44px; top: 45px; background: #c3c3c3;">
					<a href="<c:url value='/post/detailPage'/>?postId=${post.postId}">
						<img class="post-image" src="<c:url value='/upload/${post.image}'/>" alt="Post Image" style="width: 100%; height: 100%;">
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
					<!-- 장소 -->
					<div style="position:absolute; left:100px; top: 10px;">
						<img src="${pageContext.request.contextPath}/images/location.png" style="left:100px;"/>
					</div>
					<!-- 북마크 -->
					<!-- 북마크 이미지 24px로 수정하기 -->
						<!-- 북마크 전 -->
						<button id="bookmarkOff" onclick="clickBookmarkOff()" style="position:absolute; left:300px; top: 10px; border:none; background:#fff;">
							<img src="${pageContext.request.contextPath}/images/bookmark_off.png" />
						</button>
						
						<!--  북마크 후 -->
						<button id="bookmarkOn" onclick="clickBookmarkOn()" style="position:absolute; left:300px; top: 10px; border:none; background:#fff;">			
							<img src="${pageContext.request.contextPath}/images/bookmark_on.png" />
						</button>
				</div>
		    </div>
		</div>
		<!-- 리스트 구분선 -->
		<hr style="border:0; height:1px; background:#D5D5D5; margin:auto; width:1250px;"/>
	</c:forEach> 
	
</body>
</html>