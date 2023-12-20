<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%-- <%@ page import="your.package.name.Post" %> --%>
<!DOCTYPE html>
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

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
    // 페이지 로딩 시 자동으로 Ajax 요청 보내는 거임
    var memberId = "seha"; // 사용자 아이디 설정 (실제로는 동적으로 설정해야 함)
    //얘는 아마 controller에서 parameter로 받아오는 memberId로 해놔야 되는데 아직 로그인이 안되어서 일단 이렇게 했음


    var url = '<c:url value="/post/list"/>' + '?memberId=' + memberId;
     //얘는 requestMapping에 정의된 uri
    //    mappings.put("/member/update", new UpdateMemberController());
    // 이렇게 보내면 UpdateMemberController에서  	String updateId = request.getParameter("memberId"); 로 뽑아올 수 있음!!

    $.ajax({
        type: "GET", //걍 가져오는 거니까 GET요청
        url: url, //위에 설정한 url
        method: 'GET',
        success: function(response) {
            console.log('프로필 수정 섹션 로드 성공');
            $('#list').html(response);  //이게 위에 div 태그에 설정된 id값. 즉 response가 postList.jsp 겠지!!!
        },
        error: function() {
            console.error('프로필 수정 섹션을 불러오는 데 실패했습니다.');
        }
    });
});
</script>
</head>
<body>
	<jsp:include page="navBar.jsp"></jsp:include>
	<section>
	    <!-- 메인 이미지 -->
	    <img src="<c:url value='/images/people.jpg' />" style="max-width: 100%; height: auto;"/> 
	</section> 
	<section>
		<div style="margin:auto; width: 1435px; left: 80px; position: relative;"> <!-- width 설정 안하면 화면 크기에 따라 변화x -->
			<div style=" margin-top:100px;  font-size: 50px; font-weight: 400; text-align: left; color: #000;">
			게시글 전체 보기
			</div>
		</div>
	</section>
	<section>
		<div id="list"></div>
	</section>	   						
</body>

</html>