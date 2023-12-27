<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%-- <%@ page import="your.package.name.Post" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url('https://fonts.google.com/specimen/Dhurjati');

	body {
    	margin: 0;
        font-family: Krona One;
    }

    .navbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: white;
        padding: 2px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    
    .logo {
        color: #FF7C33; /* 주황색 */
        font-weight: 400;
        font-size: 40px;
        margin-left: 15px;
        margin-right: auto;
     /* style="color: #FF7C33; font-size: 40px; font-family: Krona One; font-weight: 400; word-wrap: break-word" */    
    }

    .menu {
        display: flex;
        align-items: center;
    }

    .menu a {
        color: black;
        font-size: 15px;
        text-decoration: none;
        padding: 30px;
        margin: 0 10px;
    }

    .dropdown {
        position: relative;
        display: inline-block;
    }

    .dropdown-content {
    	width: 120px;
        display: none;
        position: absolute;
        background-color: white;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        padding: 10px;
        z-index: 1;
    }
        
    .dropdown-content a {
	    display: block;
	    padding: 12px;
	    font-size: 14px; /* 원하는 크기로 조절하세요 */
	    color: black;
	    text-decoration: none;
	}

    .dropdown:hover .dropdown-content {
            display: block;
    }
        
    .main-image {
		width: 100%;
	    height: auto;
	    max-width: 100%;
	    margin-top: 20px; /* 바와 이미지 사이 간격 조절 */
	}

    @media screen and (max-width: 600px) {
        .navbar {
            flex-direction: column;
            align-items: stretch;
        }
        .menu {
            margin-top: 10px;
        }
        .logo {
            margin-right: 0;
            margin-bottom: 10px;
        }
        .menu a {
            margin: 5px 0;
        }    
    }
        
    /* 기본 스타일 */
    .goLogin {  /* 시작하기 버튼*/
    	display: inline-block;
	    padding: 5px 100px; /* 원하는 패딩 값으로 조절 */
	    text-align: center;
		text-decoration: none;
	    color: #000000; /* 텍스트 색상 설정 */
	    background-color: transparent; /* 배경 투명 설정 */
	    border: 2px solid #7a7a7a; /* 테두리 스타일 및 색상 설정 */
	    border-radius: 50px; /* 양 옆 둥근 반원 설정 (값을 늘리면 반원의 크기가 커집니다) */
	    /* box-sizing: border-box; */
	    transition: background-color 0.3s, color 0.3s, border-color 0.3s;
 	}
	
	/* 호버 효과 */
	.goLogin:hover {
    background-color: #7a7a7a; /* 호버 시 배경 색상 변경 */
    border-color: #000000; /* 호버 시 테두리 색상 변경 */
    color: #ffffff; /* 호버 시 텍스트 색상 변경 */
    }

</style>
</head>
<body>
<form>
	<div class="navbar">
	    <div>
	    	<a class="logo" href="<c:url value='/mainPage/mainLogout'/>">honnol</a>
	    </div>
	    <div class="menu">
	    	<a href="#">게시글</a>
	    	<a href="#">모임</a>
	    	<a href="#">검색</a>
	        <a class="goLogin" href="<c:url value='/account/login'/>">시작하기</a>
		</div>
	</div>
	<section>
	    <!-- 메인 이미지 -->
	    <img src="<c:url value='/images/people.jpg' />" style="max-width: 100%; height: auto;"/> 
	</section>

</form>
</body>
</html>