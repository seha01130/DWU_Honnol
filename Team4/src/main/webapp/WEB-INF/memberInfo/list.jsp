<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 게시글</title>

<style>

</style>
</head>
<body>
	<!-- 리스트 반복 -->
 	<c:forEach var="post" items="${postList}" > 
 		<!-- 포스트 요소들 분리시켜줌, margin:auto; 적용하면 반응형 됨 -->
		<div class="post-list" style="height:300px; width:100px; top:30px; margin:auto; position: relative;"> 
			<!-- 리스트 하나의 전체적인 위치인듯 -->
			<div style="width: 1435px; height: 300px; position: absolute; left: 50%; transform: translateX(-50%);">
				<!-- 포스트 이미지 --> 
				<div style="width: 209px; height: 209px; position: absolute; left: 44px; top: 45px; background: #c3c3c3;">
					<img class="post-image h-[209px] absolute left-11 top-[45px]" src="<c:out value="${post.image}"/>" alt="Post Image" style="vertical-align:top;">
				</div>
				<!-- 포스트 제목 --> 
				<span style="position: absolute; left: 285px; top: 45px; font-size: 30px; font-weight: 650; text-align: left; color: #2e2e2e;">
					<c:out value="${post.title}"/>
				</span>
				<!-- 포스트 내용 --> 
				<span style="position: absolute; left: 285px; top: 120px; font-size: 18px; text-align: left; color: #4d4d4d;
					max-width: 10px; white-space: nowrap; text-overflow: ellipsis;">
					<c:out value="${post.content}"/>
				</span>
		    </div>
		</div>
		<!-- 리스트 구분선 -->
		<hr style="border:0; height:1px; background:#D5D5D5; margin:auto; width:1250px;"/>
	</c:forEach> 
	
</body>
</html>