<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/admin/storeDetail.css">
<link rel="stylesheet" href="/resources/css/font/font.css">
</head>
<body>
	<div class="detail_container">
		<div class="title_wrapper">
			<p>가게 정보</p>
		</div>
		<div class="content_container">
			<table class="membertbl">
				<tr>
				 	<th>사업자이름</th>
				 	<td><input type="text" id="memberName" value="${sd.memberName}" readonly></td>
				</tr>
				<tr>
				 	<th>사업자번호</th>
				 	<td><input type="text" id="storeRegistNum" value="${sd.storeRegistNum}"></td>
				</tr>
				
				<tr>
				 	<th>매장번호</th>
				 	<td><input type="text" id="storeNo" value="${sd.storeNo}" readonly></td>
				</tr>
				<tr>
					<th>매장이름</th>
					<td><input type="text" id="storeName" value="${sd.storeName}"></td>
				</tr>
				<tr>
				 	<th>계좌번호</th>
				 	<td><input type="text" id="storeAccount" value="${sd.storeAccount}"></td>
				</tr>
				
				<tr>
				 	<th>영업시간</th>
				 	<td id="hour"><input type="text" id="openTime" value="${sd.openTime}"> ~ <input type="text" id="closeTime" value="${sd.closeTime}"></td>
				</tr>
				
				<tr>
				 	<th>매장주소</th>
					<td><input type="text" id="storeAddr" value="${sd.storeAddr}"></td>
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
		const storeRegistNum = $("#storeRegistNum").val();
		const storeNo = $("#storeNo").val();
		const storeName = $("#storeName").val();
		const storeAccount = $("#storeAccount").val();
		const openTime = $("#openTime").val();
		const closeTime = $("#closeTime").val();
		const storeAddr = $("#storeAddr").val();
		
		$.ajax({
			url:"/storeUpdate.do",
			data:{
				storeRegistNum : storeRegistNum,
				storeNo : storeNo,
				storeName : storeName,
				storeAccount : storeAccount,
				openTime : openTime,
				closeTime : closeTime,
				storeAddr : storeAddr 
			},
			success:function(){
				opener.location.reload();
				window.close();
			}
		})
		
	})
</script>
</html>