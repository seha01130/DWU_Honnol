<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
	@SuppressWarnings("unchecked") 
	List<Member> memberList = (List<Member>)request.getAttribute("memberList");
--%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Login</title>
</head>
<body>
<script>
	function login() {
		if (form.memberId.value == "") {
			alert("사용자 ID를 입력하십시오.");
			form.memberId.focus();
			return false;
		} 
		if (form.password.value == "") {
			alert("비밀번호를 입력하십시오.");
			form.password.focus();
			return false;
		}

		form.submit();
	}
			
	function userCreate(targetUri) {
		if(memberList != null) {
			
		}
		form.action = targetUri;
		form.method="GET";		// register form 요청
		form.submit();
	}
</script>

	<form name="form" method="POST" action="<c:url value='/member/login' />" style="width: 1920px; height: 1080px; position: relative; overflow: hidden; background: #fff;">
		<div style="width: 664px; height: 98px; position: absolute; left: 628px; top: 280px;">
    		<input type="text" placeHolder="아이디" name="memberId" id="myInput" style="width: 664px; height: 98px; position: absolute; left: -1.1px; top: -1.1px; border-radius: 20px; background: #fff; border-width: 1.2px; border-color: #505050; font-size:20px;">
		</div>
  		
  		<div style="width: 664px; height: 98px; position: absolute; left: 628px; top: 420px;">
    		<input type="password" placeHolder="비밀번호" name="password" style="width: 664px; height: 98px; position: absolute; 
    			left: -1.1px; top: -1.1px; border-radius: 20px; background: #fff; border-width: 1.2px; border-color: #505050; font-size:20px;">
  		</div>
  	
  		<!-- 로그인 버튼 -->
  		<div style="width: 664px; height: 98px; position: absolute; left: 628px; top: 560px;">
    		<input type="button" onClick="login()" value="로그인" style="width: 664px; height: 98px; position: absolute; left: -1.1px; top: -1.1px; border-radius: 20px; background: #ff7c33; border-width: 1.2px; border-color: #505050; font-weight: 700; font-size: 26px; color: #fff;">
  		</div>
	</form>

	<div style="width: 664px; height: 98px; position: absolute; left: 628px; top: 670px;">
		<p style="position: absolute; left: 230px; top: 0px; font-size: 22px;  text-align: center; color: #585858;">
    		계정이 없으신가요?
   		</p>
		<a href="<c:url value='/member/register/form'/>" style="position: absolute; left: 280px; top: 80px; font-size: 22px; text-align: center; background:#fff; color: #ff7c33;">
			회원가입
		</a>
	</div>  		
  		
	<p style="position: absolute; left: 845px; top: 176px; font-size: 40px; text-align: left; color: #444;">
		HONNOL
	</p>
</body>
</html>