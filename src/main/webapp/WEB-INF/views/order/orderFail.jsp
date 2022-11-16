<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/font/font.css">
<link rel="stylesheet" href="/resources/css/order/orderFail.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="content-wrap">
        <div class="content">
            <p>무통장 입금</p>
            <p>주문이 정상적으로 완료되지 않았습니다</p>
            <p>다시 한번 결제 부탁드립니다</p>
            <button class="order-detail" onclick="goToHome()">홈으로 가기</button>
            <button class="order-mypage" onclick="goToMyPage(${sessionScope.m.memberNo})">마이페이지</button>
        </div>
    </div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script>
		function goToHome(){
			location.href="/"
		}
		function goToMyPage(memberNo){
			console.log(memberNo);
			location.href="/memberMain.do?memberNo="+memberNo;
		}
	</script>
</body>
</html>