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
		<form action="/donateUpdate.do" method="post" enctype="multipart/form-data">
			<table class="membertbl">
				<tr>
				 	<th>기부 번호</th>
				 	<td><input type="text" value="${d.donateNo }" id="donateNo" name="donateNo" required></td>
				</tr>
				<tr>
				 	<th>기부 단체</th>
				 	<td><input type="text" value="${d.donateOrgan }" id="donateOrgan" name="donateOrgan" required></td>
				</tr>
				
				<tr>
				 	<th>기부 이미지</th>
				 	<td>
				 	<input type="hidden" name="status" value="stay">
						<c:choose>
							<c:when test="${not empty d.donateImg }"> <!-- 이미지가 있는 상태면.. -->
								<span class="delFile">${d.donateImg }</span><button type="button" class="delFile" onchange="loadImg(this);">파일 선택</button>
								<input type="file" name="upFile" accept="image/*" style="display:none;">
								<input type="hidden" name="oldImg" value="${d.donateImg }">	   		
                			</c:when>
                			<c:otherwise> <!-- 이미지가 없는 상태면.. -->
                				<input type="file" name="upFile" accept="image/*" value="${d.donateImg }" onchange="loadImg(this);" required>
                			</c:otherwise>
                		</c:choose>
				 	</td>
				</tr>
				
				<tr>
				 	<th>목표 금액</th>
				 	<td><input type="text" value="${d.donateEnd}" id="donateEnd" name="donateEnd" required></td>
				</tr>
				
				<tr>
				 	<th>기부 내용</th>
				 	<td><textarea id="donateContent" name="donateContent" required>${d.donateContent}</textarea></td>
				</tr>
			</table>
			<div class="btn_wrap">
				<button class="complete">수정</button>
			</div>
			</form>
		</div>
	</div>
</body>
<script>
	$("button.delFile").on("click",function(){
		$(".delFile").hide();
		$(this).next().show();
		$("[name=status]").val("delete");
	});
</script>
</html>