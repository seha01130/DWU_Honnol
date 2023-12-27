<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:forEach var="reply" items="${replyList}" > 
		<div style="width: 1596px; height: 196px; position: absolute">
		<!-- 이게이미지 -->
		    <div style="width: 73px; height: 73px; left: 0px; top: 17px; position: absolute; background: #D9D9D9; border-radius: 9999px"></div>
		    <div style="left: 94px; top: 38px; position: absolute; color: #5A5A5A; font-size: 26px; font-family: Inter; font-weight: 700; word-wrap: break-word">${reply.nickname}</div>
		    <div style="width: 1595px; height: 82px; left: 1px; top: 114px; position: absolute; color: #5A5A5A; font-size: 20px; font-family: Inter; font-weight: 400; word-wrap: break-word">${reply.content}</div>
		        <!-- 이게 선 -->
		    <div style="width: 1596px; height: 0px; left: 0px; top: 196px; position: absolute; border: 1px #969696 solid"></div>
		    <div style="width: 5px; height: 21px; left: 1577px; top: 17px; position: absolute">
		      <div style="width: 5px; height: 5px; left: 0px; top: 0px; position: absolute; background: #959595; border-radius: 9999px"></div>
		      <div style="width: 5px; height: 5px; left: 0px; top: 8px; position: absolute; background: #959595; border-radius: 9999px"></div>
		      <div style="width: 5px; height: 5px; left: 0px; top: 16px; position: absolute; background: #959595; border-radius: 9999px"></div>
		    </div>
		    <div style="left: 187px; top: 45px; position: absolute; color: #6B6B6B; font-size: 14px; font-family: Inter; font-weight: 400; word-wrap: break-word">${reply.createDate}</div>
		  </div>
  	</c:forEach> 
</body>
</html>