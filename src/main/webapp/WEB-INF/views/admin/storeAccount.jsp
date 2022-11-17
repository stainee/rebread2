<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/admin/storeAccount.css">
<link rel="stylesheet" href="/resources/css/font/font.css">
<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
</head>
<body>
	<div class="account_container">
		<div class="title_wrapper">
			<p>정산 내역</p>
		</div>
		<div class="content_container">
			<p>*실입금액은 플랫폼 수수료 5%를 제한 나머지 입니다.</p>
			<table class="membertbl">
				<tr>
				 	<th>정산일</th>
				 	<th>총수익</th>
				 	<th>실입금액</th>
				 	
				</tr>
				<c:forEach items="${list}" var="a">
					<tr>
						<td><p>${a.accountDate}</p></td>
					 	<td><p>${a.profit}</p></td>
					 	<td><p>${a.accountPayment}</p></td>
					</tr>
				</c:forEach>

			</table>
			<div class="btn_wrap">
 				<button class="complete" onclick="window.close()">확인</button>
			</div>
		</div>
	</div>
</body>
</html>