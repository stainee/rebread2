<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/font/font.css">
<link rel="stylesheet" href="/resources/css/order/orderCardSuccess.css">
<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="content-wrap">
        <div class="content">
            <p>카드결제</p>
            <p>주문이 완료되었습니다</p>
            <p>빠르게 준비해드릴게요!</p>
            <button class="order-detail" onclick="goToHome()">홈으로 가기</button>
            <button class="order-mypage" onclick="goToMyPage(${sessionScope.m.memberNo})">마이페이지</button>
        </div>
    </div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script>
		function goToHome(){
			location.href="/";
		}
		function goToMyPage(memberNo){
			location.href="/memberMain.do?memberNo="+memberNo;
		}
	</script>
</body>
</html>