<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
</head>

<link rel="stylesheet" href="/resources/css/font/font.css">
<link rel="stylesheet" href="/resources/css/common/admin.css">
<link rel="stylesheet" href="/resources/css/admin/adminMain.css">
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
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
                </ul>
            </div>
        </div>

        <div class="right_container" >
	        
	        	<!-- 내 정보 -->
	            <div class="content_container" 	style='height: 520px'>
	            	<div class="content-title">회원 정보 수정</div>   
					<div class="content-info-wrap">
						<div class="content-update">
							<div>기본 회원 정보</div>
							<div>수정</div>
						</div>
						<div class="content-info">
							<div>이름</div>
							<div>${sessionScope.m.memberName }</div>
						</div>
						<div class="content-info">
							<div>이메일</div>
							<div>${sessionScope.m.memberMail }</div>
						</div>
						<div class="content-info">
							<div>비밀번호</div>
							<div>비밀번호 설정</div>
						</div>
						<div class="content-info">
							<div>휴대폰 번호</div>
							<div>${sessionScope.m.memberPhone }</div>
						</div>
					</div>
					<div class="member-withdraw">
						<a href="#">회원탈퇴</a>
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
</script>
</html>