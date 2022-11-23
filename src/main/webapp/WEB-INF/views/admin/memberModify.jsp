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
<link rel="stylesheet" href="/resources/css/admin/memberModify.css">
<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
</head>
<body>
	<div class="detail_container">
		<div class="title_wrapper">
			<p>정보 수정</p>
		</div>
		<div class="content_container">
			<table class="membertbl">
				<tr>
				 	<th>회원번호</th>
				 	<td><input type="text" value="${m.memberNo}" id="memberNo" readonly></td>
				</tr>
				<tr>
				 	<th>아이디</th>
				 	<td><input type="text" value="${m.memberId }" id="memberId"></td>
				</tr>
				
				<tr>
				 	<th>이름</th>
				 	<td><input type="text"value="${m.memberName }" id="memberName"></td>
				</tr>
				
				<tr>
				 	<th>전화번호</th>
				 	<td><input type="text" value="${m.memberPhone}" id="memberPhone"></td>
				</tr>
				
				<tr>
				 	<th>이메일</th>
				 	<td><input type="text" value="${m.memberMail}" id="memberMail"></td>
				</tr>
				
				<tr>
					<th>주소</th>
					<td><input type="text" value="${m.memberAddr}" id="memberAddr"></td>
				</tr>
				<tr>
					<th>회원등급</th>
					<td>
						<c:if test="${m.memberGrade eq 0}">
							<select id="memberGrade">
								<option value=0>관리자</option>
								<option value=1>일반회원</option>
								<option value=2>판매자</option>
							</select>
						</c:if>
						<c:if test="${m.memberGrade eq 1 }" >
							<select id="memberGrade">
								<option value=1>일반회원</option>
								<option value=0>관리자</option>
								<option value=2>판매자</option>
							</select>
						</c:if>
						<c:if test="${m.memberGrade eq 2 }" >
							<select id="memberGrade">
								<option value=2>판매자</option>	
								<option value=1>일반회원</option>
								<option value=0>관리자</option>
							</select>
						</c:if>
					</td>
				</tr>
				
				<tr>
					<th>마일리지</th>
					<td><input type="text" value="${m.memberMileage}" id="memberMileage" readonly="readonly"></td>
					<!-- 오류수정 -->
				</tr>
			</table>
			<div class="btn_wrap">
				<button class="modify">수정</button>
				<button class="complete" onclick="window.close()">확인</button>
			</div>
		</div>
	</div>
</body>
<script>
	$(".modify").on("click",function(){
		const memberNo = $("#memberNo").val();
		const memberId = $("#memberId").val();
		const memberName = $("#memberName").val();
		const memberPhone = $("#memberPhone").val();
		const memberMail = $("#memberMail").val();
		const memberAddr = $("#memberAddr").val();
		const memberGrade = $("#memberGrade").val();
		const memberMileage = $("#memberMileage").val();
		
		$.ajax({
			url:"/memberUpdate.do",
			data:{
				memberNo:memberNo,
				memberId:memberId,
				memberName:memberName,
				memberPhone:memberPhone,
				memberMail:memberMail,
				memberAddr:memberAddr,
				memberGrade:memberGrade,
				memberMileage:memberMileage
			},
			success:function(){
				opener.location.reload();
				window.close();
			}
		})
	})
</script>

</html>