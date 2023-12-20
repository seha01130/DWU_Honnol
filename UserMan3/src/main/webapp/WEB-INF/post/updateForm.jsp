<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Preview</title>
<script src="https://cdn.tailwindcss.com"></script>
<style type="text/css">
html, body {
	display: flex;
	flex-direction: column;
	
	/* 중앙정렬을 위한 추가 */
	justify-content: center;
    align-items: center;
    min-height: 100vh;
    margin: 0;
	
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	
}
input::placeholder {
	color: orange; /* 색상 지정 가능 */
	font-weight: 500; /* 굵기 지정 가능 */
	font-size: 18px; /* 크기 지정 가능 */
	padding-left: 10px;
	padding-top: 5px;
}
textarea {
      resize: vertical;
      width: 1270px;
      height: 180px;
      position: absolute;
      left: 327px;
      top: 756px;
      font-size: 24px;
      text-align: left;
      color: #6F6F6F;
    }
</style>
<script>
	function updatePost() {
		if (form.title.value == "") {
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}
		if (form.locationId.value == "") {
			alert("장소를 선택하세요.");
			form.locationId.focus();
			return false;
		}
		if (form.content.value == "") {
			alert("내용을 입력하세요.");
			form.content.focus();
			return false;
		}
		form.submit();
	}
	
	/* textarea 처음 클릭할때만 커서 맨 앞으로 이동 */
    document.addEventListener('DOMContentLoaded', function () {
      var textarea = document.getElementById('contentTextarea');
      textarea.addEventListener('click', function handleClick() {
        textarea.setSelectionRange(0, 0);
        textarea.removeEventListener('click', handleClick);
      });
    });
</script>
</head>
<body>
	<form name="form" method="POST" action="<c:url value='/post/update'/>">
		<input type="hidden" name="postId" value="${post.postId}" />  <!-- postId값 넘겨줘야함!!! -->
		<div
			style="width: 1920px; height: 1483px; position: relative; background: #fff;">
			<div
				style="width: 1920px; height: 150px; position: absolute; left: 0px; top: 0px; overflow: hidden; background: #fff;">
				<p
					style="position: absolute; left: 162px; top: 51px; font-size: 40px; text-align: left; color: #ff7c33;">
					HONNOL</p>
				<div
					style="width: 158px; height: 53px; position: absolute; left: 1700px; top: 48px; overflow: hidden; border-radius: 62px; background: #ff7c33;">
					<input type="button" value="수정완료" onClick="updatePost()"
						style="position: absolute; left: 38px; top: 13px; font-size: 20px; font-weight: 700; text-align: center; color: #fff;">
				</div>
			</div>
			<div
				style="width: 1920px; height: 1201px; position: absolute; left: 0px; top: 282px; overflow: hidden; filter: drop-shadow(0px 4px 4px rgba(0, 0, 0, 0.25));">
				<input type="text" name="title" value='${post.title}'
					style="width: 450px; border-radius: 10px; position: absolute; left: 750px; top: 56px; font-size: 35px; font-weight: 200; text-align: left; padding-left: 15px; color: #6B6B6B; border-left: 0; border-right: 0; border-top: 0; border-bottom-color: #6B6B6B;">
				<svg width="1594" height="1" viewBox="0 0 1594 1" fill="none"
					xmlns="http://www.w3.org/2000/svg"
					style="position: absolute; left: 161px; top: 147px;"
					preserveAspectRatio="xMidYMid meet">
          			<line y1="0.5" x2="1594" y2="0.5" stroke="#AAAAAA"></line>
        		</svg>
				<div style="width: 165px; height: 36px;">
					<input type="text" name="locationId" value='${post.locationId}' readonly
						style="position: absolute; left: 834px; top: 182px; font-size: 30px; font-weight: 300; text-align: left; padding-left: 8px; color: #6b6b6b;">
					<svg width="30" height="30" viewBox="0 0 30 30" fill="none"
						xmlns="http://www.w3.org/2000/svg"
						style="width: 30px; height: 30px; position: absolute; left: 780px; top: 185px;"
						preserveAspectRatio="none">
            <path
							d="M17.1675 27.27C20.4356 24.3938 26.25 18.5175 26.25 13.125C26.25 10.1413 25.0647 7.27983 22.955 5.17005C20.8452 3.06026 17.9837 1.875 15 1.875C12.0163 1.875 9.15483 3.06026 7.04505 5.17005C4.93526 7.27983 3.75 10.1413 3.75 13.125C3.75 18.5175 9.5625 24.3938 12.8325 27.27C13.429 27.8024 14.2005 28.0966 15 28.0966C15.7995 28.0966 16.571 27.8024 17.1675 27.27ZM11.25 13.125C11.25 12.1304 11.6451 11.1766 12.3483 10.4733C13.0516 9.77009 14.0054 9.375 15 9.375C15.9946 9.375 16.9484 9.77009 17.6516 10.4733C18.3549 11.1766 18.75 12.1304 18.75 13.125C18.75 14.1196 18.3549 15.0734 17.6516 15.7767C16.9484 16.4799 15.9946 16.875 15 16.875C14.0054 16.875 13.0516 16.4799 12.3483 15.7767C11.6451 15.0734 11.25 14.1196 11.25 13.125Z"
							fill="#FF7C33"></path>
          </svg>
				</div>
				<div
					style="width: 436px; height: 436px; position: absolute; left: 742px; top: 252px;">
					<div
						style="width: 436px; height: 436px; position: absolute; left: -1px; top: -1px; background: #d9d9d9;">
						<img src="<c:url value='/upload/${post.image}'/>" />
					</div>
				</div>
				
				<textarea name="content" id="contentTextarea" style="padding-left: 15px;">${post.content}</textarea>

				<p
					style="width: 150px; position: absolute; left: 323px; top: 1103px; font-size: 25px; font-weight: 700; text-align: left; color: #6f6f6f;">
					공개 설정</p>
				<input type="radio" name="isPublic" value="1" checked
					style="position: absolute;; left: 475px; top: 1115px;">
				<p
					style="width: 113px; position: absolute; left: 500px; top: 1105px; font-size: 22px; text-align: left; color: #6f6f6f;">
					공개</p>
				<input type="radio" name="isPublic" value="0"
					style="position: absolute;; left: 575px; top: 1115px;">
				<p
					style="width: 113px; position: absolute; left: 597px; top: 1105px; font-size: 22px; text-align: left; color: #6f6f6f;">
					비공개</p>
			</div>
			<p
				style="position: absolute; left: 162px; top: 198px; font-size: 40px; font-weight: 700; text-align: left; color: #4a4a4a;">
				게시글 작성</p>
		</div>
	</form>
</body>
</html>
