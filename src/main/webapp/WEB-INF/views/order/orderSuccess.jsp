<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/font/font.css">
<link rel="stylesheet" href="/resources/css/order/orderSuccess.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="content-wrap">
        <div class="content">
            <p>주문 완료 완료 완료 축하축하합니당</p>
            <p>빠르게 배송 노력합니당</p>
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
			console.log(memberNo);
			location.href="/memberMain.do?memberNo="+memberNo;
		}
	</script>
</body>
</html>