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
        /* style="font-size: 3.5vh; font-weight: 700; color: #ff7c33; margin: 0; */
            color: #FF7C33; /* 주황색 */
            text-decoration-line: none;
            font-weight: 700;
            font-size: 7vh;
            margin-left: 15px;
            margin-right: auto;
/*             style="color: #FF7C33; font-size: 40px; font-family: Krona One; font-weight: 400; word-wrap: break-word"
 */        }

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
        	width: 140px;
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

</style>
</head>
<body>

	<div class="navbar">
		<!-- 로고 -->
	    <div>
	    	<a class="logo"  href="<c:url value='/mainPage/mainLogin'/>">honnol</a>
	    </div>
	    <!-- 메뉴 -->
	    <div class="menu">
	        <div class="dropdown">
	            <a href="#">게시글</a>
	            <div class="dropdown-content">
	                <a href="<c:url value='/post/create'/>">게시글 작성</a>
	                <a href="<c:url value='/memberInfo/myPost'/>">내 게시글</a>
	            </div>
	        </div>
	        <div class="dropdown">
	            <a href="#">모임</a>
	            <div class="dropdown-content">
	                <a href="<c:url value='/myEvent/create_event_form'/>">모임 개설</a>
	                <a href="<c:url value='/myEvent/myEvent_getIn'/>">모임 참여</a>
	                <a href="#">내 모임</a>
	            </div>
	        </div>
	        <div class="dropdown">
	            <a href="#">검색</a>
	            <div class="dropdown-content">
	                <a href="<c:url value='/map/ShowMap'/>">게시글 검색</a>
	                <a href="<c:url value='/map/ShowMap'/>">모임 검색</a>
	            </div>
	        </div>
	        <!-- 마이페이지 버튼 -->
	        <a href="<c:url value='/memberInfo/myPage'/>">
	            <svg
				    width="34"
				    height="34"
				    viewBox="0 0 34 34"
				    fill="none"
				    xmlns="http://www.w3.org/2000/svg"
				    class="w-[34px] h-[34px] relative"
				    preserveAspectRatio="xMidYMid meet">  
					<path
					    d="M27.9472 28.9668C27.3015 27.1594 25.8787 25.5623 23.8994 24.4232C21.9201 23.2842 19.4949 22.6667 17.0001 22.6667C14.5052 22.6667 12.0801 23.2842 10.1008 24.4232C8.12149 25.5623 6.69864 27.1594 6.05292 28.9668"
					    stroke="#353535"
					    stroke-width="2"
					    stroke-linecap="round">
					</path>
					<circle
					    cx="16.9999"
					    cy="11.3334"
					    r="5.66667"
					    stroke="#353535"
					    stroke-width="2"
					    stroke-linecap="round">
					</circle>
			    </svg>
	        </a>
	        <!-- 알림 버튼 -->
	        <a href="#">
	        	<svg
				    width="34"
				    height="34"
				    viewBox="0 0 34 34"
				    fill="none"
				    xmlns="http://www.w3.org/2000/svg"
				    class="w-[34px] h-[34px] relative"
				    preserveAspectRatio="none">  
					<path
					    d="M9.13444 11.29C9.57976 7.28212 12.9674 4.25 17 4.25V4.25C21.0326 4.25 24.4202 7.28212 24.8656 11.29L25.2223 14.5005C25.3068 15.2609 25.349 15.6412 25.4262 16.012C25.5571 16.6406 25.7632 17.2512 26.0401 17.8306C26.2034 18.1724 26.4003 18.5004 26.7939 19.1565L27.9326 21.0543C28.7384 22.3973 29.1412 23.0687 28.854 23.576C28.5668 24.0833 27.7837 24.0833 26.2176 24.0833H7.78238C6.21627 24.0833 5.43322 24.0833 5.14599 23.576C4.85876 23.0687 5.26164 22.3973 6.06739 21.0543L7.2061 19.1565C7.59975 18.5004 7.79658 18.1724 7.9599 17.8306C8.23677 17.2512 8.44287 16.6406 8.57377 16.012C8.65098 15.6412 8.69323 15.2609 8.77772 14.5005L9.13444 11.29Z"
    					stroke="#353535"
    					stroke-width="2">
					</path>
					<path
					    d="M12.8948 25.025C13.137 26.3805 13.6705 27.5783 14.4128 28.4326C15.155 29.2869 16.0644 29.75 17 29.75C17.9356 29.75 18.845 29.2869 19.5872 28.4326C20.3295 27.5783 20.863 26.3805 21.1052 25.025"
    					stroke="#353535"
    					stroke-width="2"
    					stroke-linecap="round">
					</path>
				</svg>
	        </a>
	    </div>
	</div>


</body>
</html>