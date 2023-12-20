<%@page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HONNOL</title>
<style>
  body {
    margin: 0;
    padding: 0;
  }

  nav {
    width: 100%;
    height: 10%;
    position: absolute;
    top: 0;
    background: #fff;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 2%;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }

  nav p {

    
    font-size:2.5vh; 
    color:#000;
  }

  nav svg {
    width: 5vh;
    height: 5vh;
    stroke: #353535;
    stroke-width: 2;
    stroke-linecap: round;
    cursor: pointer;
  }

  nav svg:hover {
    fill: #ff7c33;
  }

  nav p:hover {
    color: #ff7c33;
  }
</style>
</head>
<body>
  <!-- Navigation bar -->
  <nav style="width: 100%; display: flex; justify-content: space-between; align-items: center; padding: 0 20px;">
    <p style="font-size: 3.5vh; font-weight: 700; color: #ff7c33; margin: 0;">HONNOL</p>
    <div style="display: flex; gap: 50px; margin-right: 50px;">
        <p>게시글</p>
        <p>모임</p>
        <p>검색</p>
        <!-- 마이페이지 버튼 -->
    	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 34 34">
      		<path d="M9.13444 11.29C9.57976 7.28212 12.9674 4.25 17 4.25V4.25C21.0326 4.25 24.4202 7.28212 24.8656 11.29L25.2223 14.5005C25.3068 15.2609 25.349 15.6412 25.4262 16.012C25.5571 16.6406 25.7632 17.2512 26.0401 17.8306C26.2034 18.1724 26.4003 18.5004 26.7939 19.1565L27.9326 21.0543C28.7384 22.3973 29.1412 23.0687 28.854 23.576C28.5668 24.0833 27.7837 24.0833 26.2176 24.0833H7.78238C6.21627 24.0833 5.43322 24.0833 5.14599 23.576C4.85876 23.0687 5.26164 22.3973 6.06739 21.0543L7.2061 19.1565C7.59975 18.5004 7.79658 18.1724 7.9599 17.8306C8.23677 17.2512 8.44287 16.6406 8.57377 16.012C8.65098 15.6412 8.69323 15.2609 8.77772 14.5005L9.13444 11.29Z" stroke="#353535" stroke-width="2"></path>
      		<path d="M12.8948 25.025C13.137 26.3805 13.6705 27.5783 14.4128 28.4326C15.155 29.2869 16.0644 29.75 17 29.75C17.9356 29.75 18.845 29.2869 19.5872 28.4326C20.3295 27.5783 20.863 26.3805 21.1052 25.025" stroke="#353535" stroke-width="2" stroke-linecap="round"></path>
    	</svg>
    	<!-- 알림 버튼 -->
    	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 34 34">
      		<circle cx="16.9999" cy="11.3334" r="5.66667" stroke="#353535" stroke-width="2" stroke-linecap="round"></circle>
    	</svg>
    </div>
  </nav>
  
  <div>
  	<!-- 메인 이미지 -->
	<img src="<c:url value='/images/main.jpg' />" style="width: 100%; height: 70%; position: absolute; top: 65px; object-fit: over;"/>
	
	<p style="position: absolute; left: 180px; top: 550px; font-size: 25px; font-weight: 400; text-align: left; color: #000;">
		게시글 전체 보기
	</p> 			
				   		
	<!-- START: 게시글 1개의 레이아웃 -->
	<div style="width: 1435px; height: 311px;">
		<div style="width: 1435px; height: 300px; position: absolute; left: 120px; top: 600px; overflow: hidden;">
			<div style="width: 209px; height: 209px; position: absolute; left: 44px; top: 45px; background: #c3c3c3;">
				<!-- 게시글 이미지 삽입 위치 -->
			</div>
			
			<p style="position: absolute; left: 285px; top: 45px; font-size: 30px; font-weight: 650; text-align: left; color: #2e2e2e;">
				게시글 제목
			</p>
			
			<p style="position: absolute; left: 285px; top: 120px; font-size: 18px; text-align: left; color: #4d4d4d;
				max-width: 10px; white-space: nowrap; text-overflow: ellipsis;">
				게시글 내용 
			</p>

	    </div>
		
	</div>
	<!-- END: 게시글 1개의 레이아웃 -->				
	  		
  </div>
</body>
</html>