<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>REBREAD EVENT</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/common/event.css">
<!--aos라이브러리-->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<link
href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
	<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
	<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
	<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="page-content">
		<div class="page-title" data-aos="fade-right" data-aos-duration="1000" data-aos-delay="500">
		<h2>E V E N T</h2>
		<p>리브레드 이벤트는 상시업데이트 됩니다</p>
		</div>
		<div class="item-basket-box">
			<ul>
				<li class="event">
					<div class="eventPic"><a href="/rollet.do"><img src="/resources/img/common/rollet.jpg"></a></div>
					<div class="eventTitle">룰렛을 돌려 마일리지를 획득하세요 !</div>
				</li>
			</ul>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
<!-- AOS 스크립트 초기화 -->
<script>
	AOS.init();
</script>
<!-- //AOS 스크립트 초기화 -->
<div aos="fade-up" data-aos-offset="200" data-aos-easing="ease-out-cubic" data-aos-duration="500"></div>
<script>
	
</script>
</html>