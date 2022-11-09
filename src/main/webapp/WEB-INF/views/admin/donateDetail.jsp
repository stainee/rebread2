<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
     <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<head>
<meta charset="UTF-8">
<title>기부 등록/수정</title>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/admin/memberDetail.css">
<link rel="stylesheet" href="/resources/css/admin/donateDetail.css">
</head>
<body>
	<div class="detail_container">
		<div class="title_wrapper">
			<p>기부 등록/수정</p>
		</div>
		<div class="content_container">
			<table class="membertbl">
				<tr>
				 	<th>기부 번호</th>
				 	<td><input type="text" value="${m.memberNo}" id="donateNo" readonly></td>
				</tr>
				<tr>
				 	<th>기부 단체</th>
				 	<td><input type="text" value="${m.memberId }" id="donateOrgan"></td>
				</tr>
				
				<tr>
				 	<th>기부 이미지</th>
				 	<td>
				 		<input type="text" value="${m.memberName }" id="donateImg">
				 		<button id="donateImg_btn">첨부파일</button>
				 	</td>
				</tr>
				
				<tr>
				 	<th>목표 금액</th>
				 	<td><input type="text" value="${m.memberPhone}" id="donateEnd"></td>
				</tr>
				
				<tr>
				 	<th>기부 내용</th>
				 	<td><textarea value="${m.memberMail}" id="donateContent"></textarea></td>
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