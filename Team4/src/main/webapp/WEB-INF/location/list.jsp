<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

    <style>
        .post-container {

            max-height: 650px; /* 최대 높이 지정 */
            overflow-y: auto; /* 세로 스크롤 적용 */
        }

        .post-list {
           margin-bottom: 10px;
            position: relative;
        }

        /* 나머지 스타일은 동일하게 유지 */
        
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
    <div class="post-container">
        <c:forEach var="post" items="${postList}">
            <!-- 포스트 요소들 분리시켜줌, margin:auto; 적용하면 반응형 됨 -->
            <div class="post-list">
                <!-- 리스트 하나의 전체적인 위치인듯 -->
                <div style="width:380px; height: 130px; position: relative; overflow: hidden; margin: auto;">
                    <!-- 포스트 이미지 -->
                    <div style="width: 90px; height: 90px; position: absolute; left: 44px; top: 40px; background: #c3c3c3;">
                        <a href="<c:url value='/post/detailPage'/>?postId=${post.postId}">
                        	<img class="post-image h-[209px] absolute left-11 top-[45px]" src="<c:out value="${post.image}"/>" alt="Post Image" style="width: 100%; height: 100%;">
                    	</a>
                    </div>
                    <!-- 포스트 제목 -->
                    <span style="position: absolute; left: 150px; top: 45px; font-size: 15px; font-weight: 650; text-align: left; color: #2e2e2e;">
                        <a class="title" href="<c:url value='/post/detailPage'/>?postId=${post.postId}"><c:out value="${post.title}"/></a>
                    </span>
                    <!-- 포스트 내용 -->
                    <span style="position: absolute; left: 150px; top: 80px; font-size: 10px; text-align: left; color: #4d4d4d;
                        max-width: 10px; white-space: nowrap; text-overflow: ellipsis;">
                        <a class="content" href="<c:url value='/post/detailPage'/>?postId=${post.postId}"><c:out value="${post.content}"/></a>
                    </span>
                    <!-- 리스트 구분선 -->
                    <div style="margin-top: 10px; margin-left:45px;">
                        <hr style="border: 0; border-top: 0.5px solid #D5D5D5; background: #D5D5D5; width: 380px;"/>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</body>
</html>