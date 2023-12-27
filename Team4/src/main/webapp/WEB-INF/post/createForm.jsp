<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="controller.member.MemberSessionUtils" %>

<%
// 세션이 존재하고, 속성이 존재하는지 확인
if (session != null && session.getAttribute(MemberSessionUtils.MEMBER_SESSION_KEY) != null) {
    // 세션에서 memberId를 가져옴
    String memberId = (String) session.getAttribute(MemberSessionUtils.MEMBER_SESSION_KEY);
    System.out.println("Member ID: " + memberId);
} else {
    System.out.println("Session or attribute not found");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Preview</title>
<script   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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
.responsive-container {
            width: 100%;
            max-width: 1200px; /* 최대 너비 설정 */
            margin: 0 auto;
            position: relative;
            background: #fff;
        }
</style>
<script>

//초기화 여부를 확인하는 플래그
var isInitialized = false;

function previewImage(input) {
    var postImage = document.getElementById('postImage');
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            postImage.src = e.target.result;
            // 이미지 미리보기를 로컬 스토리지에 저장
            localStorage.setItem('image1', e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    }
}

//파일 선택이 변경되었을 때 미리보기 함수 호출
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('fileInput').addEventListener('change', function() {
        previewImage(this);
    });
    restoreFormValues();
});

//이미지 클릭
function imageClick(event) {
    var button = document.getElementsByName('keyword')[0];
    if (button.value == "장소선택") {
        alert("장소를 선택하세요.");
        // 이벤트의 기본 동작을 막음
        event.preventDefault();
        return false;
    }
}

   function createPost() {
      if (form.title.value == "") {
         alert("제목을 입력하세요.");
         form.title.focus();
         return false;
      }
      if (form.keyword.value == "장소선택") {
         alert("장소를 선택하세요.");
         return false;
      }
      if (form.content.value == "") {
         alert("내용을 입력하세요.");
         form.content.focus();
         return false;
      }
      
      localStorage.clear()
      
      form.submit();
   }
   
   function locationSearch() {
	   
	// 현재 입력 값들을 로컬 스토리지에 저장
	    localStorage.setItem('title', document.forms['form'].title.value);
	    localStorage.setItem('content', document.forms['form'].content.value);
	    
	    var postImage = document.getElementById('postImage');
	    localStorage.setItem('image1', postImage.src);

	   
       var locationLink = document.createElement('a');
       locationLink.href = "<c:url value='/post/locationSearch'></c:url>";
       locationLink.click();
   }
   
   // ------------------location 관련 시작--------------------------
   
   // URL에서 특정 파라미터 값을 추출하는 함수
   function getParameterByName(name, url) {
       if (!url) url = window.location.href;
       name = name.replace(/[\[\]]/g, "\\$&");
       var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
           results = regex.exec(url);
       if (!results) return null;
       if (!results[2]) return '';
       return decodeURIComponent(results[2].replace(/\+/g, " "));
   }

   // 버튼에 URL 파라미터 값을 설정하는 함수
   function setButtonValue() {
       // URL에서 'name' 파라미터 값을 추출
       var nameParam = getParameterByName('name');
       if (nameParam == null){
          nameParam = "장소선택"
       }
       // 버튼 엘리먼트를 가져오고, 파라미터 값을 설정
       var button = document.getElementsByName('keyword')[0];
       button.value = nameParam;
    // hidden 엘리먼트를 가져오고, 값을 설정
       var hidden = document.getElementsByName('locationName')[0];
       hidden.value = nameParam;
       
       
    // URL에서 'address' 파라미터 값을 추출
       var addressParam = getParameterByName('address');
    // hidden 엘리먼트를 가져오고, 값을 설정
       var hidden = document.getElementsByName('locationAddress')[0];
       hidden.value = addressParam;
   }
   
   document.addEventListener('DOMContentLoaded', function () {
	    // 초기화 여부를 확인하는 플래그
	    var isInitialized = false;

	    setButtonValue();

	    // 로컬 스토리지에 저장된 값이 있으면 복원
	    if (localStorage.getItem('title')) {
	        document.forms['form'].title.value = localStorage.getItem('title');
	    }
	    if (localStorage.getItem('content')) {
	        document.forms['form'].content.value = localStorage.getItem('content');
	    }

	    // '장소선택' 버튼 값을 설정합니다.
	    setButtonValue();

	});

   
   // ------------------location 관련 시작--------------------------
   
   // URL에서 특정 파라미터 값을 추출하는 함수
   function getParameterByName(name, url) {
       if (!url) url = window.location.href;
       name = name.replace(/[\[\]]/g, "\\$&");
       var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
           results = regex.exec(url);
       if (!results) return null;
       if (!results[2]) return '';
       return decodeURIComponent(results[2].replace(/\+/g, " "));
   }

   // 버튼에 URL 파라미터 값을 설정하는 함수
   function setButtonValue() {
       // URL에서 'name' 파라미터 값을 추출
       var nameParam = getParameterByName('name');
       if (nameParam == null){
          nameParam = "장소선택"
       }
       // 버튼 엘리먼트를 가져오고, 파라미터 값을 설정
       var button = document.getElementsByName('keyword')[0];
       button.value = nameParam;
    // hidden 엘리먼트를 가져오고, 값을 설정
       var hidden = document.getElementsByName('locationName')[0];
       hidden.value = nameParam;
       
       
    // URL에서 'address' 파라미터 값을 추출
       var addressParam = getParameterByName('address');
    // hidden 엘리먼트를 가져오고, 값을 설정
       var hidden = document.getElementsByName('locationAddress')[0];
       hidden.value = addressParam;
   }
   
   document.addEventListener('DOMContentLoaded', function () {
	    // 초기화 여부를 확인하는 플래그
	    var isInitialized = false;

	    setButtonValue();

	    // 로컬 스토리지에 저장된 값이 있으면 복원
	    if (localStorage.getItem('title')) {
	        document.forms['form'].title.value = localStorage.getItem('title');
	    }
	    if (localStorage.getItem('content')) {
	        document.forms['form'].content.value = localStorage.getItem('content');
	    }

	    // '장소선택' 버튼 값을 설정합니다.
	    setButtonValue();

	});
  
   
   // ------------------location 관련 끝--------------------------   
   
   
   // Set the initial value of the textarea to an empty string
    document.addEventListener('DOMContentLoaded', function () {
       var textarea = document.getElementById('contentTextarea');
        textarea.addEventListener('click', function handleClick() {
           textarea.setSelectionRange(0, 0);
           textarea.removeEventListener('click', handleClick);
         });
        
        restoreFormValues();
    });
</script>
</head>
<body>
   <form name="form" method="POST" action="<c:url value='/post/create'/>" enctype="multipart/form-data">
   
      <input type="hidden" name="locationName" value="" />   
      <input type="hidden" name="locationAddress" value="" />
   
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
              
              
          <!-- 장소 선택 -->
            <div style="width: 165px; height: 36px;">
               <input name="keyword" type="button" value="장소선택" onClick="locationSearch()"
                  style="position: absolute; left: 874px; top: 176px; font-size: 30px; font-weight: 300; text-align: center; padding-left: 8px; color: #6b6b6b;">
               <svg width="30" height="30" viewBox="0 0 30 30" fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                  style="width: 30px; height: 30px; position: absolute; left: 780px; top: 185px;"
                  preserveAspectRatio="none">
                     <path d="M17.1675 27.27C20.4356 24.3938 26.25 18.5175 26.25 13.125C26.25 10.1413 25.0647 7.27983 22.955 5.17005C20.8452 3.06026 17.9837 1.875 15 1.875C12.0163 1.875 9.15483 3.06026 7.04505 5.17005C4.93526 7.27983 3.75 10.1413 3.75 13.125C3.75 18.5175 9.5625 24.3938 12.8325 27.27C13.429 27.8024 14.2005 28.0966 15 28.0966C15.7995 28.0966 16.571 27.8024 17.1675 27.27ZM11.25 13.125C11.25 12.1304 11.6451 11.1766 12.3483 10.4733C13.0516 9.77009 14.0054 9.375 15 9.375C15.9946 9.375 16.9484 9.77009 17.6516 10.4733C18.3549 11.1766 18.75 12.1304 18.75 13.125C18.75 14.1196 18.3549 15.0734 17.6516 15.7767C16.9484 16.4799 15.9946 16.875 15 16.875C14.0054 16.875 13.0516 16.4799 12.3483 15.7767C11.6451 15.0734 11.25 14.1196 11.25 13.125Z"
                     fill="#FF7C33"></path>
                   </svg>
            </div>
            
            
          <!-- 이미지 선택 -->
            <div
               style="width: 436px; height: 436px; position: absolute; left: 742px; top: 252px;">
               
               <img id="postImage"
                  style="width: 436px; height: 436px; left: -1px; top: -1px; position: absolute; background: #D9D9D9;">
               <input type="file" id="fileInput" name="image" style="display: none" onclick="imageClick(event)">
               <label for="fileInput" style="position: absolute; left: 304px; top: 454px; font-size: 22px; text-align: left; color: #ff7c33; font-family: Inter; font-weight: 700; word-wrap: break-word; border: none; background: none; cursor: pointer;">
                  이미지 선택
               </label>
            </div>
            
            <textarea name="content" id="contentTextarea" style="padding-left: 15px; margin-top: 15px;"></textarea>

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