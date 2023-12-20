<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SignUp</title>
</head>
<body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
function userCreate() {
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
	if (form.password.value != form.password_check.value) {
		pwCheck.style.display = '';
		form.password_check.focus();
		return false;
	}
	if (form.email.value == "") {
		alert("이메일을 입력하십시오.");
		form.email.focus();
		return false;
	}
	else {
		 console.log('이메일 중복 확인');
		    var url = '<c:url value="/member/register/emailCheck"/>' + '?email=' + email;

		    $.ajax({
		        type: "GET",
		        url: url,
		        success: function (response) {
		            console.log('서버 응답:', response);

		            if (response.isDuplicateEmail) {
		            	emailCheck.style.display = '';
		                alert("이미 가입된 이메일입니다.");
		            } else {
		                emailCheck.style.display = 'none';
		            }
		        },
		        error: function () {
		            console.error('서버 요청 실패');
		        }
		    });

		    // 폼 제출을 막음
		    return false;
	}

	form.submit();
}

function existMemberId() {
    // AJAX를 사용하여 서버에 중복 여부 확인 요청
    var memberId = form.memberId.value;
    
    if(memberId=="") {
    	alert("아이디를 입력해주세요.")
    }
    else{
    	console.log('사용자 아이디 중복확인');
	    var url = '<c:url value="/member/register/idCheck" />' + '?memberId=' + memberId;
    
	    $.ajax({
	        type: "GET",
	        url: url,
	        success: function(response) {
	            console.log('서버 응답:', response);
	            
	            // 서버로부터 받은 응답에 alert 표시
	            if (response.isDuplicate) {
	                alert("사용할 수 없는 아이디입니다.");
	            } else {
	                alert("사용 가능한 아이디입니다.");
	            }
	        },
	        error: function() {
	            console.error('서버 요청 실패');
	        }
	    });   
    }
	 // 폼 전송을 막음
    return false;
}

</script>

<form name="form" method="POST" action="<c:url value='/member/register' />" style="width: 1920px; height: 1080px; position: relative; overflow: hidden; background: #fff;" onsubmit="return existUser()">>
	<div style="width: 664px; height: 98px; position: absolute; left: 628px; top: 280px;">
    	<!-- ID 입력 -->
    	<input type="text" name="memberId" placeHolder="아이디" style="width: 664px; height: 98px; position: absolute; left: -1.1px; top: -1.1px; border-radius: 20px; background: #fff; font-size:20px; border-width: 1.2px; border-color: #505050;">
   				
   		<!-- 중복 확인 버튼 -->
   		<input type="button" value="중복확인" onClick="existMemberId()" style="width: 91px; height: 40px; position: absolute; left: 549px; top: 30px; border-radius: 8px; background: #ff7c33; border:none
   		font-size: 14px; text-align: center; color: #fff; font-weight: 700;" >
	</div>
  		
  	<!-- 닉네임 입력 -->
  	<div style="width: 664px; height: 98px; position: absolute; left: 628px; top: 420px;">
    	<input type="text" name="nickname" placeHolder="닉네임" style="width: 664px; height: 98px; position: absolute; left: -1.1px; top: -1.1px; border-radius: 20px; background: #fff; font-size:20px; border-width: 1.2px; border-color: #505050;">
  	</div>
  		
  	<!-- Email 입력 -->
  	<div style="width: 664px; height: 98px; position: absolute; left: 628px; top: 560px;">
    	<input type="text" name="email" placeHolder="이메일" style="width: 664px; height: 98px; position: absolute; left: -1.1px; top: -1.1px; border-radius: 20px; background: #fff; font-size:20px; border-width: 1.2px; border-color: #505050;">
  		  	<p id="emailCheck" style="position: absolute; width: 664px; left: -1.1px; top: 90.1px; font-size:16px; font-weight: 300; color: #ff0d0d; display:none; ">
  				이미 가입된 이메일입니다.
			</p>
  	</div>

  	<!-- PWD 입력 -->
  	<div style="width: 664px; height: 98px; position: absolute; left: 628px; top: 700px;">
    	<input type="password" name="password" placeHolder="비밀번호" style="width: 664px; height: 98px; position: absolute; left: -1.1px; top: -1.1px; border-radius: 20px; background: #fff; font-size:20px; border-width: 1.2px; border-color: #505050;">
  	</div>
  		
	<div style="width: 664px; height: 98px; position: absolute; left: 628px; top: 840px;">
	    <input type="password" name="password_check" id="passwordCheckInput" placeHolder="비밀번호 확인" 
	    	style="width: 664px; height: 98px; position: absolute; left: -1.1px; top: -1.1px; border-radius: 20px; background: #fff; font-size:20px; border-width: 1.2px; border-color: #505050;" oninput="checkPasswordMatch()">
		<p id="pwCheck" style="position: absolute; width: 664px; left: -1.1px; top: 90.1px; font-size:16px; font-weight: 300; color: #ff0d0d; display:none; ">
			비밀번호를 다시 입력하세요.
		</p>
	</div>
	

  	
  	<!-- 회원 가입 버튼 -->
  	<div style="width: 664px; height: 98px; position: absolute; left: 628px; top: 990px;">
    	<input type="button" onClick="userCreate()" value="혼놀시작하기" style="width: 664px; height: 98px; position: absolute; left: -1.1px; top: -1.1px; border-radius: 20px; background: #ff7c33; font-weight: 700; font-size: 26px; color: #fff;">
  	</div>
  	
  	<p style="position: absolute; left: 845px; top: 176px; font-size: 40px; text-align: left; color: #444;">
    	HONNOL
  	</p>
</form>
</body>
</html>