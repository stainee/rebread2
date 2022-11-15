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
			<table class="membertbl">
				<tr>
				 	<th>기부 단체</th>
				 	<td><input type="text" value="" id="donateOrgan"></td>
				</tr>
				
				<tr>
				 	<th>기부 이미지</th>
				 	<td>
				 		<input type="text" value="" id="donateImg">
				 		<button id="donateImg_btn">첨부파일</button>
				 	</td>
				</tr>
				
				<tr>
				 	<th>목표 금액</th>
				 	<td><input type="text" value="" id="donateEnd"></td>
				</tr>
				
				<tr>
				 	<th>기부 내용</th>
				 	<td><textarea id="donateContent"></textarea></td>
				</tr>
			</table>
			<div class="btn_wrap">
				<button class="complete">확인</button>
			</div>
		</div>
	</div>
</body>
<script>
	$(".complete").on("click",function(){
		$("#donateContent").attr("value", $("#donateContent").text());
		const donateOrgan = $("#donateOrgan").val();
		const donateImg = $("#donateImg").val();
		const donateEnd = $("#donateEnd").val();
		const donateContent = $("#donateContent").val();
		console.log(donateOrgan);
		console.log(donateImg);
		console.log(donateEnd);
		console.log(donateContent);
		
		$.ajax({
			url:"/donateInsert.do",
			data:{
				donateOrgan:donateOrgan,
				donateImg:donateImg,
				donateEnd:donateEnd,
				donateContent:donateContent
			},
			success:function(){
				alert("등록되었습니다");
				opener.location.reload();
				window.close();
			}
		})
	})
</script>
</html>