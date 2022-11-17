<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지-내정보</title>
</head>
<link rel="stylesheet" href="/resources/css/font/font.css">
<link rel="stylesheet" href="/resources/css/member/ceoMain.css">
<link rel="stylesheet" href="/resources/css/common/managetemplate.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="total_wrapper">
        <div class="left_container"  style="max-height: 357px;">
            <div class="memberInfo">
                <p>[판매자]</p>
                <p>${sessionScope.m.memberName }님</p>
            </div>
            <div class="selectList">
                <ul>
                	<li><a href="/ceoMain.do">내정보</a></li> 
                    <li><a href="/ceoStoreInfo.do">가게 정보</a></li>
                    <li><a href="/ceoStoreSalesInfo.do">상품 판매 정보</a></li>
                </ul>
            </div>
        </div>
        <div class="right_container" >
	        	<!-- 내 정보 -->
	            <div class="content_container" 	style='height: 500px'>
	            	<div class="navi_box">회원 정보 수정</div>
                <form action="/updateCeo.do" method="post">
                <div class="my_info">
                    <div class="my_info_title">
                        <div class="title">기본 회원 정보</div>
                    </div>
                    <div class="user_info">
                    	<div class="user_info_title">아이디</div>
                        <div class="user_info_content">
                            <input type="text" name="memberId" value="${sessionScope.m.memberId }" disabled>
                        </div>
                    </div>
                    <div class="user_info">
                    	<input type="hidden" name="memberNo" value="${sessionScope.m.memberNo }" readonly>
                        <div class="user_info_title">이름</div>
                        <div class="user_info_content">
                            <input type="text" name="memberName" value="${sessionScope.m.memberName }" disabled>
                        </div>
                    </div>
                    <div class="user_info" style="border-bottom:1px solid lightgray; padding-bottom: 20px; margin-right: 30px;">
                    	<div class="user_info_title">패스워드</div>
                        <div class="user_info_content">
                            <input type="text" name="memberPw" value="패스워드는 로그인창에서 변경가능합니다." disabled>
                        </div>
                    </div>
                    <div class="changeAble">
                    	<div class="title_btn_box">
                            <div class="edit_btn" style="margin-top: 20px; margin-right: 20px;">수정</div>
                            <button type="submit" class="edit_complete_btn" style="margin-top: 20px; margin-right: 20px;">완료</button>
                        </div>
                    </div>
                    <div class="user_info">
                        <div class="user_info_title">이메일</div>
                        <div class="user_info_content updateAble">
                            <input type="text" name="memberMail" value="${sessionScope.m.memberMail }" readonly>
                        </div>
                    </div>
                    <div class="user_info">
                        <div class="user_info_title">주소지</div>
                        <div class="user_info_content updateAble">
                            <input type="text" name="memberAddr" value="${sessionScope.m.memberAddr }" readonly>
                        </div>
                    </div>
                    <div class="user_info">
                        <div class="user_info_title">휴대폰 번호</div>
                        <div class="user_info_content updateAble">
                            <input type="text" name="memberPhone" value="${sessionScope.m.memberPhone }" readonly>
                        </div>
                    </div>
                </div>
                </form>
                <div class="footer_box">
                    <button class="footer_box_btn" onclick="deleteMember(${sessionScope.m.memberNo})">회원 탈퇴</button>
                </div>
	            </div>
	        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
<script>
index=0;
$(function(){
	let total = $(".selectList a").length;
	for(let i=0; i<total; i++){
		$(".selectList a").eq(i).removeClass("index");
	}
	$(".selectList a").eq(index).addClass("index");
})
	
</script>
<script src="resources/js/member/ceoMain.js"></script>
</html>