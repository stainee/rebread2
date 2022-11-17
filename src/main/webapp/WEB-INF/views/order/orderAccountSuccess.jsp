<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/font/font.css">
<link rel="stylesheet" href="/resources/css/order/orderAccountSuccess.css">
<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="content-wrap">
        <div class="content">
            <p>무통장 입금</p>
            <p>주문 신청이 완료되었습니다</p>
            <p>아래 입금 정보를 확인하여 입금해주세요</p>
            <div class="content-account-wrap">
	            <div class="content-account">
		            <div class="account-wrap">
		            	<div>무통장 입금 정보</div>
		            </div>
		            <div class="account-content">
		            	<div class="account-info">
		            		<div>예금주</div>
		            		<div>(주)리브레드</div>
		            	</div>
		            	<div class="account-info">
		            		<div>계좌번호</div>
		            		<div>${bank} ${accountNumber}</div>
		            	</div>
		            	<div class="account-info">
		            		<div>입금금액</div>
		            		<div class="totalAmount">${totalAmount }</div>
		            	</div>
		            </div>
	            </div>
	        </div>
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
		
		
		
		
		
		let totalAmount = $(".totalAmount");
		totalAmount.text(addComma(totalAmount.text())+"원");
		
		function addComma(value){
		    value = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		    return value; 
		 };
	</script>
</body>
</html>