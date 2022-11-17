<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
     <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<head>
<meta charset="UTF-8">
<title>기부 등록</title>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/admin/memberDetail.css">
<link rel="stylesheet" href="/resources/css/admin/donateDetail.css">
</head>
<body>
	<div class="detail_container">
		<div class="title_wrapper">
			<p>기부 등록</p>
		</div>
		<div class="content_container">
			<form action="/donateInsert.do" method="post" enctype="multipart/form-data">
				<table class="membertbl">
					<tr>
					 	<th>기부 단체</th>
					 	<td><input type="text" value="" id="donateOrgan" name="donateOrgan"></td>
					</tr>
					<tr>
					 	<th>기부 이미지</th>
					 	<td>
					 		<input type="file" value="" id="donateFile" name="donateFile"  accept="image/*" style="padding: 1px 2px;" multiple>
					 	</td>
					</tr>
					<tr>
					 	<th>목표 금액</th>
					 	<td><input type="text" value="" id="donateEnd" name="donateEnd"></td>
					</tr>
					<tr>
					 	<th>기부 내용</th>
					 	<td><textarea id="donateContent" name="donateContent"></textarea></td>
					</tr>
				</table>
			<div class="btn_wrap">
				<button type="submit" class="complete">확인</button>
			</div>
			</form>
		</div>
	</div>
</body>
<script>
	
	
</script>
</html>