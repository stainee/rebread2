<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
     <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/admin/memberDetail.css">
<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
</head>
<body>
	<div class="detail_container">
		<div class="title_wrapper">
			<p>회원 정보</p>
		</div>
		<div class="content_container">
			<table class="membertbl">
				<tr>
				 	<th>회원번호</th>
				 	<td><input type="text" value="${m.memberNo}" id="memberNo" readonly></td>
				</tr>
				<tr>
				 	<th>아이디</th>
				 	<td><input type="text" value="${m.memberId }" id="memberId" readonly></td>
				</tr>
				
				<tr>
				 	<th>이름</th>
				 	<td><input type="text"value="${m.memberName }" id="memberName" readonly></td>
				</tr>
				
				<tr>
				 	<th>전화번호</th>
				 	<td><input type="text" value="${m.memberPhone}" id="memberPhone" readonly></td>
				</tr>
				
				<tr>
				 	<th>이메일</th>
				 	<td><input type="text" value="${m.memberMail}" id="memberMail" readonly></td>
				</tr>
				
				<tr>
					<th>주소</th>
					<td><input type="text" value="${m.memberAddr}" id="memberAddr" readonly></td>
				</tr>
				<tr>
					<th>회원등급</th>
					<td>
						<c:if test="${m.memberGrade eq 0}">
						<input type="text" value="관리자" readonly>
						</c:if>
						<c:if test="${m.memberGrade eq 1 }" >
						<input type="text" value="판매자" readonly>
						</c:if>
						<c:if test="${m.memberGrade eq 2 }" >
						<input type="text" value="일반회원" readonly>
						</c:if>
					</td>
				</tr>
				
				<tr>
					<th>마일리지</th>
					<td><input type="text" value="${m.memberMileage}" id="memberMileage" readonly></td>
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