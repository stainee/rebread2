<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
     <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/font/font.css">
<link rel="stylesheet" href="/resources/css/common/admin.css">
<link rel="stylesheet" href="/resources/css/admin/csDetail.css">
<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
</head>
<body>
	<div class="detail_container">
		<div class="title_wrapper">
			<p>상담 정보</p>
		</div>
		<div class="content_container">
			<table class="membertbl">
				<tr>
				 	<th>상담번호</th>
				 	<td><input type="text" value="${cs.csNo}" id="csNo" readonly></td>
				</tr>
				<tr>
				 	<th>아이디</th>
				 	<td><input type="text" value="${cs.memberId }" id="memberId" readonly></td>
				</tr>
				
				<tr>
				 	<th>이름</th>
				 	<td><input type="text"value="${cs.memberName }" id="memberName" readonly></td>
				</tr>
				
				<tr>
				 	<th>전화번호</th>
				 	<td><input type="text" value="${cs.memberPhone}" id="memberPhone" readonly></td>
				</tr>
				
				<tr>
				 	<th>이메일</th>
				 	<td><input type="text" value="${cs.memberMail}" id="memberMail" readonly></td>
				</tr>
				
				<tr>
					<th>주소</th>
					<td><input type="text" value="${cs.memberAddr}" id="memberAddr" readonly></td>
				</tr>
				<tr>
					<th>회원등급</th>
					<td>
						<c:if test="${cs.memberGrade eq 0}">
						<input type="text" value="관리자" readonly>
						</c:if>
						<c:if test="${cs.memberGrade eq 1 }" >
						<input type="text" value="판매자" readonly>
						</c:if>
						<c:if test="${cs.memberGrade eq 2 }" >
						<input type="text" value="일반회원" readonly>
						</c:if>
					</td>
				</tr>
				
				<tr>
					<th>마일리지</th>
					<td><input type="text" value="${cs.memberMileage}" id="memberMileage" readonly></td>
				</tr>
				<tr>
					<th>상담종류</th>
					<td><input type="text" value="${cs.csCategory}" readonly></td>
				</tr>
				<tr>
					<th>상담내용</th>
					<td><input type="text" value="${cs.csContent}" readonly></td>
				</tr>
			</table>
			<div class="btn_wrap">
				<button class="complete" onclick="window.close()">확인</button>
			</div>
		</div>
	</div>
</body>
<script>
	
</script>
</html>