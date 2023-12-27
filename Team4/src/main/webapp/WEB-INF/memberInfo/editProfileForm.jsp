<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>프로필 수정</title>

<style>
input:focus {
    outline: none;
}
</style>
<script>
function previewImage(input) {
    var profileImage = document.getElementById('profileImage');
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            profileImage.src = e.target.result;
        };
        reader.readAsDataURL(input.files[0]);
    }
}
//파일 선택이 변경되었을 때 미리보기 함수 호출
document.getElementById('fileInput').addEventListener('change', function() {
    previewImage(this);
});

function editMemberInfo() {
	 var form = document.forms["fom"]; // form 참조 추가
	 
	 console.log("뭐지?!!!!?!?");
	 console.log(form);
	 
	if (form.nickname.value == "") {
		alert("닉네임을 입력하십시오.");
		form.nickname.focus();
		return false;
	} 
	if (form.password.value == "") {
		alert("비밀번호를 입력하십시오.");
		form.password.focus();
		return false;
	}
	if (form.password.value != form.password2.value) {
		alert("비밀번호가 일치하지 않습니다.");
		form.nickname.focus();
		return false;
	}
	form.submit();
}
</script>
</head>
<body>
<form name="fom" method="POST" action="<c:url value='/member/update' />" enctype="multipart/form-data">
 	<input type="hidden" name="memberId" value="${member.memberId}" />

        <c:if test="${registerFailed}">
	      <font color="red"><c:out value="${exception.getMessage()}" /></font>
	    </c:if>
	   
	 <div style="top: 293px; left:20px; position: absolute; color: #242424; font-size: 30px; font-family: Inter; font-weight: 700; word-wrap: break-word">
	 	프로필 수정
	 </div>
	
	<!-- 프로필 이미지 -->
	<img id="profileImage" src="${pageContext.request.contextPath}/upload/${memberInfo.profilePicture}" alt="이미지 대체 텍스트" style="width: 196px; height: 196px; top: 397px; position: absolute; background: #D9D9D9; border-radius: 9999px">
	
	<!-- 닉네임 입력 -->
	<div style="width: 495px; height: 79px; left: 130px; top: 370px; position: absolute">
		<div style="top: 20px; color: #505050; font-size: 28px; font-family: Inter; font-weight: 580px; word-wrap: break-word">
			닉네임
		</div>
		<div style="width: 380px; height: 63px; bottom: 30px; left: 400px; position: absolute; background: white; border-radius: 20px; border: 1.20px #505050 solid"></div>
		<input type="text" name="nickname" value = "${memberInfo.nickname}"
			style="width: 300px; left: 420px; top: 2px; position: absolute; color: #505050; font-size: 26px; font-family: Inter; font-weight: 400; word-wrap: break-word; border: 1px solid rgba(0, 0, 0, 0);" />
	</div>
	<!-- 비밀번호 입력 -->
	<div
		style="width: 495px; height: 79px; left: 130px; top: 520px; position: absolute">
		<div style="left: 50px; top: 0px; color: #505050; font-size: 28px; font-family: Inter; font-weight: 580px; word-wrap: break-word">
			비밀번호
		</div>
		<div style="width: 380px; height: 63px; left: 400px; bottom: 30px; position: absolute; background: white; border-radius: 20px; border: 1.20px #505050 solid"></div>
		<input type="password" name="password" value = "${member.password}"
			style="width: 300px; left: 420px; top: 2px; position: absolute; color: #505050; font-size: 26px; font-family: Inter; font-weight: 400; word-wrap: break-word; border: 1px solid rgba(0, 0, 0, 0);" />
	</div>
	
	<!-- 비밀번호 확인 -->
	<div
		style="width: 495px; height: 79px; left: 130px; top: 670px; position: absolute">
		<div style=" color: #505050; font-size: 28px; font-family: Inter; font-weight: 580px; word-wrap: break-word">비밀번호 확인</div>
		<div style="width: 380px; height: 63px; left: 400px; bottom: 30px; position: absolute; background: white; border-radius: 20px; border: 1.20px #505050 solid"></div>
		<input type="password" name="password2" value = "${member.password}"
			style="width: 300px; left: 420px; top: 2px; position: absolute; color: #505050; font-size: 26px; font-family: Inter; font-weight: 400; word-wrap: break-word; border: 1px solid rgba(0, 0, 0, 0);" />
	</div>
	<div
		style="padding-top: 13px; padding-bottom: 12px; padding-left: 39px; padding-right: 40px; top: 633px; position: absolute; background: white; border-radius: 28px; overflow: hidden; border: 2px #FF7C33 solid; justify-content: center; align-items: center; display: inline-flex">
		<input type="file" id="fileInput" name="picture" style="display:none;" />
		<label for="fileInput" style="color: #FF7C33; font-size: 20px; font-family: Inter; font-weight: 700; word-wrap: break-word; border: none; background: none; cursor: pointer;">이미지 선택</label>
	</div>
	
	
	<div style="left: 200px; top: 900px; position: absolute">
		<div style="padding-top: 13px; padding-bottom: 12px;  padding-left: 51px; padding-right: 51px; background: #FF7C33; border-radius: 28px; overflow: hidden; border: 1px #FF7C33 solid; justify-content: center; align-items: center; display: inline-flex">
	  		<input type="button" value="수정" onClick="editMemberInfo()" style="color: white; font-size: 20px; font-family: Inter; font-weight: 700; word-wrap: break-word; border: none; background: none; cursor: pointer;"/>
		</div>
	</div>
</form>
</body>
</html>