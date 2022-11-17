<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
</head>

<link rel="stylesheet" href="/resources/css/font/font.css">
<link rel="stylesheet" href="/resources/css/common/admin.css">
<link rel="stylesheet" href="/resources/css/admin/adminMain.css">
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div class="page-content" style="height: 800px;">
	<div class="total_wrapper">
        <div class="left_container">
            <div class="memberInfo">
                <p>[관리자]</p>
                <p>${sessionScope.m.memberName}님</p>
            </div>
            <div class="selectList">
                <ul>
                	<li><a href="/adminMain.do">내정보</a></li> 
                    <li><a href="/storeList.do">가게관리</a></li>
                    <li><a href="/memberList.do">회원관리</a></li>
                    <li><a href="/csList.do">문의관리</a></li>
                    <li><a href="/donateList.do">기부관리</a></li>
                </ul>
            </div>
        </div>

        <div class="right_container" >
	        	<!-- 내 정보 -->
	            <div class="content_container" 	style='height: 600px'>
	            	<div class="navi_box">회원 정보 수정</div>
                <form action="/updateAdim.do" method="post">
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
                    <div class="user_info" style="border-bottom:1px solid lightgray; padding-bottom: 20px;">
                    	<div class="user_info_title">패스워드</div>
                        <div class="user_info_content">
                            <input type="text" name="memberPw" value="패스워드는 로그인창에서 변경가능합니다." disabled>
                        </div>
                    </div>
                    <div class="changeAble">
                    	<div class="title_btn_box">
                            <div class="edit_btn" style="margin-top: 20px;">수정</div>
                            <button type="submit" class="edit_complete_btn">완료</button>
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
                    <button class="footer_box_btn">회원 탈퇴</button>
                </div>
	            </div>
	        </div>
	    </div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />	
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
	
	const userInfoContent = $(".updateAble input");

	$(".edit_btn").on("click",function(){
	    userInfoContent.css("border-bottom","1px solid black");
	    userInfoContent.attr("readonly",false);
	    $(".edit_btn").css("display","none");
	    $(".edit_complete_btn").css("display","inline-block");
	});
	
	$(".edit_complete_btn").on("click",function(){
		userInfoContent.attr("readonly",true);
		userInfoContent.css("border-bottom","1px solid white");
	});
	
	const deleteBtn = $(".footer_box_btn");
	deleteBtn.on("click",function(){
		const memberNo = $("#memberNo").val();
		if(!confirm("정말 탈퇴하시겠습니까?")){
			// 아니오 클릭 시 이벤트
		}else{
			// 예 클릭시 이벤트
			location.href = "/memberDelete.do?memberNo="+memberNo;
			alert("회원 탈퇴가 완료되었습니다.");
		}
	});
</script>
</html>