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
	padding-top: 3px;
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
	function createPost() {
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
	
	// Set the initial value of the textarea to an empty string
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
	<form name="form" method="POST" action="<c:url value='/post/create'/>" enctype="multipart/form-data">
		<div
			style="width: 1920px; height: 1483px; position: relative; background: #fff;">
			<div
				style="width: 1920px; height: 150px; position: absolute; left: 0px; top: 0px; overflow: hidden; background: #fff;">
				<p
					style="position: absolute; left: 162px; top: 51px; font-size: 40px; text-align: left; color: #ff7c33;">
					HONNOL</p>
				<div
					style="width: 158px; height: 53px; position: absolute; left: 1700px; top: 48px; overflow: hidden; border-radius: 62px; background: #ff7c33;">
					<input type="button" value="글쓰기" onClick="createPost()"
						style="position: absolute; left: 51px; top: 15px; font-size: 20px; font-weight: 700; text-align: left; color: #fff;">
				</div>
			</div>
			<div
				style="width: 1920px; height: 1201px; position: absolute; left: 0px; top: 282px; overflow: hidden; filter: drop-shadow(0px 4px 4px rgba(0, 0, 0, 0.25));">
				<input type="text" name="title" placeholder="제목을 입력하세요"
					style="width: 450px; border-radius: 10px; position: absolute; left: 750px; top: 56px; font-size: 35px; font-weight: 200; text-align: center; color: #6B6B6B; border-left: 0; border-right: 0; border-top: 0; border-bottom-color: #6B6B6B;">
				<svg width="1594" height="1" viewBox="0 0 1594 1" fill="none"
					xmlns="http://www.w3.org/2000/svg"
					style="position: absolute; left: 161px; top: 147px;"
					preserveAspectRatio="xMidYMid meet">
          			<line y1="0.5" x2="1594" y2="0.5" stroke="#AAAAAA"></line>
        		</svg>
				<div style="width: 165px; height: 36px;">
					<!-- 장소 입력 -->
					<input type="text" name="locationId" placeholder="장소 선택"
						style="position: absolute; left: 834px; top: 182px; font-size: 30px; font-weight: 300; text-align: center; padding-left: 8px; color: #6b6b6b;">
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
						style="width: 436px; height: 436px; position: absolute; left: -1px; top: -1px; background: #d9d9d9;"></div>
					<input type="file" value="이미지 선택하기" name="image" multiple="multiple"
						style="position: absolute; left: 104px; top: 224px; font-size: 22px; font-weight: 300; text-align: left; color: #676767;">
					<svg width="40" height="40" viewBox="0 0 40 40" fill="none"
						xmlns="http://www.w3.org/2000/svg"
						style="width: 40px; height: 40px; position: absolute; left: 198px; top: 167px;"
						preserveAspectRatio="none">
            			<path d="M32.5 8.75H28.1688L26.0391 5.55625C25.925 5.38524 25.7704 5.245 25.5892 5.14798C25.408 5.05095 25.2056 5.00012 25 5H15C14.7944 5.00012 14.592 5.05095 14.4108 5.14798C14.2296 5.245 14.075 5.38524 13.9609 5.55625L11.8297 8.75H7.5C6.50544 8.75 5.55161 9.14509 4.84835 9.84835C4.14509 10.5516 3.75 11.5054 3.75 12.5V30C3.75 30.9946 4.14509 31.9484 4.84835 32.6517C5.55161 33.3549 6.50544 33.75 7.5 33.75H32.5C33.4946 33.75 34.4484 33.3549 35.1517 32.6517C35.8549 31.9484 36.25 30.9946 36.25 30V12.5C36.25 11.5054 35.8549 10.5516 35.1517 9.84835C34.4484 9.14509 33.4946 8.75 32.5 8.75ZM33.75 30C33.75 30.3315 33.6183 30.6495 33.3839 30.8839C33.1495 31.1183 32.8315 31.25 32.5 31.25H7.5C7.16848 31.25 6.85054 31.1183 6.61612 30.8839C6.3817 30.6495 6.25 30.3315 6.25 30V12.5C6.25 12.1685 6.3817 11.8505 6.61612 11.6161C6.85054 11.3817 7.16848 11.25 7.5 11.25H12.5C12.7058 11.2501 12.9085 11.1994 13.0901 11.1024C13.2716 11.0054 13.4264 10.865 13.5406 10.6938L15.6687 7.5H24.3297L26.4594 10.6938C26.5736 10.865 26.7284 11.0054 26.9099 11.1024C27.0915 11.1994 27.2942 11.2501 27.5 11.25H32.5C32.8315 11.25 33.1495 11.3817 33.3839 11.6161C33.6183 11.8505 33.75 12.1685 33.75 12.5V30ZM20 13.75C18.6403 13.75 17.311 14.1532 16.1805 14.9086C15.0499 15.6641 14.1687 16.7378 13.6483 17.9941C13.128 19.2503 12.9918 20.6326 13.2571 21.9662C13.5224 23.2999 14.1772 24.5249 15.1386 25.4864C16.1001 26.4478 17.3251 27.1026 18.6588 27.3679C19.9924 27.6332 21.3747 27.497 22.6309 26.9767C23.8872 26.4563 24.9609 25.5751 25.7164 24.4445C26.4718 23.314 26.875 21.9847 26.875 20.625C26.8729 18.8023 26.1479 17.0548 24.8591 15.7659C23.5702 14.4771 21.8227 13.7521 20 13.75ZM20 25C19.1347 25 18.2888 24.7434 17.5694 24.2627C16.8499 23.7819 16.2892 23.0987 15.958 22.2992C15.6269 21.4998 15.5403 20.6201 15.7091 19.7715C15.8779 18.9228 16.2946 18.1433 16.9064 17.5314C17.5183 16.9196 18.2978 16.5029 19.1465 16.3341C19.9951 16.1653 20.8748 16.2519 21.6742 16.583C22.4737 16.9142 23.1569 17.4749 23.6377 18.1944C24.1184 18.9138 24.375 19.7597 24.375 20.625C24.375 21.7853 23.9141 22.8981 23.0936 23.7186C22.2731 24.5391 21.1603 25 20 25Z"
							fill="#676767"></path>
          			</svg>
				</div>
				
				<textarea name="content" id="contentTextarea" style="padding-left: 15px;"></textarea>

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
