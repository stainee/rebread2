<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
     <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<head>
<meta charset="UTF-8">
<title>기부정보 수정</title>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/admin/memberDetail.css">
<link rel="stylesheet" href="/resources/css/admin/donateDetail.css">
<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
</head>
<body>
	<div class="detail_container">
		<div class="title_wrapper">
			<p>기부 수정</p>
		</div>
		<div class="content_container">
			<table class="membertbl">
				<tr>
				 	<th>기부 번호</th>
				 	<td><input type="text" value="${d.donateNo}" id="donateNo" readonly></td>
				</tr>
				<tr>
				 	<th>기부 단체</th>
				 	<td><input type="text" value="${d.donateOrgan }" id="donateOrgan"></td>
				</tr>
				
				<tr>
				 	<th>기부 이미지</th>
				 	<td>
				 		<input type="file" value="${d.donateImg }" id="donateImg">
				 		<button id="donateImg_btn">첨부파일</button>
				 	</td>
				</tr>
				
				<tr>
				 	<th>목표 금액</th>
				 	<td><input type="text" value="${d.donateEnd}" id="donateEnd"></td>
				</tr>
				
				<tr>
				 	<th>기부 내용</th>
				 	<td><textarea value="${d.donateContent}" id="donateContent">${d.donateContent}</textarea></td>
				</tr>
			</table>
			<div class="btn_wrap">
				<button class="complete">수정</button>
			</div>
		</div>
	</div>
</body>
<script>
	$(".complete").on("click",function(){
		const donateNo = $("#donateNo").val();
		const donateOrgan = $("#donateOrgan").val();
		const donateImg = $("#donateImg").val();
		const donateEnd = $("#donateEnd").val();
		const donateContent = $("#donateContent").val();
		console.log(donateContent);
		
		$.ajax({
			url:"/donateUpdate.do",
			data:{
				donateNo:donateNo,
				donateOrgan:donateOrgan,
				donateImg:donateImg,
				donateEnd:donateEnd,
				donateContent:donateContent
			},
			success:function(){
				alert("수정되었습니다");
				opener.location.reload();
				window.close();
			}
		})
	})
</script>
</html>