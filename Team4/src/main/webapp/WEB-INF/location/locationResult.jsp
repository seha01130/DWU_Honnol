<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Insert title here</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
		// 프로필 수정 섹션 로딩
	console.log('컨텐츠 로딩 중: showPostList');
        var memberId = $(this).attr("id");
        var url = '<c:url value="/location/postSearch"/>' + '?locationId=' + ${locationId};

	$.ajax({
        type: "GET",
        url: url,
        method: 'GET',
        success: function(response) {
            console.log('게시글 리스트 섹션 로드 성공');
            $('#showPostList').html(response);
        },
        error: function() {
            console.error('게시글 리스트 섹션을 불러오는 데 실패했습니다.');
        }
    });
});


</script>
</head>
<body>
	<div style="width: 430px; left: 430px; height: 850px; position: relative; background: white; border-radius: 25px; overflow: hidden">
  	<div style="left: 34px; top: 110px; position: absolute; color: #212121; font-size: 20px; font-family: Inter; font-weight: 700; word-wrap: break-word">게시글 검색 결과</div>
  	<div style="padding-top: 15px; padding-bottom: 15px; padding-left: 13px; padding-right: 25px; left: 28px; top: 22px; position: absolute; border-radius: 20px; overflow: hidden; border: 2px #FF7C33 solid; justify-content: flex-start; align-items: center; gap: 7px; display: inline-flex">
	<div style="width: 23px; height: 23px; background: #FF7C33; border-radius: 9999px"></div> <!-- 동그라미 -->
    	<input type="button" id="postSearchResult" value="게시글 검색 결과" style="color: #2B2B2B; font-size: 15px; font-family: Inter; font-weight: 400; word-wrap: break-word; border: none; background: none;"/>
	</div>
</div>
    <div id="showPostList" style=" left: 420px; top: 150px; position: absolute;"></div>

</body>
</html>