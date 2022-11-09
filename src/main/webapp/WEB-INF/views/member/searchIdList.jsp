<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/member/searchId.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Yanone+Kaffeesatz:wght@500&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap"
	rel="stylesheet">
<!--aos라이브러리-->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
</head>
<body>
	<div class="wrap">
		<div class="page-content">
			<div class="textArea" data-aos="fade-right" data-aos-delay="300" data-aos-duration="1500">
				<div>
					<a href="/"><h1>R E B R E A D</h1></a>
					<h2>아이디 찾기</h2>
					<p>회원님의 입력값에 일치하는 정보입니다.</p>	
				</div>
			</div>
			<div class="content">
				<table id="searchId">
					<tr>
						<th>회원 이름</th><th>회원 아이디</th><th>회원 이메일</th>
					</tr>
					<c:forEach items="${list }" var="m">
					<tr>
						<td>${m.memberName }</td>
						<td>${m.memberId }</td>
						<td>${m.memberMail }</td>
					</tr>
					</c:forEach>
				</table>
				<div id="btnarea"><button id="back" onclick="location.href='/loginFrm.do'">확 인</button></div>
			</div>
		</div>
	</div>
</body>
<script>
	AOS.init();
</script>
<!-- //AOS 스크립트 초기화 -->
<div aos="fade-up" data-aos-offset="200" data-aos-easing="ease-out-cubic" data-aos-duration="500">
</html>