<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/review/reviewList.css">
<!--aos라이브러리-->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@200&display=swap"
	rel="stylesheet">
<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="page-content" >
		<div class="page-title" 
		data-aos="fade-right" data-aos-duration="1000" data-aos-delay="500">
		<h2>R E V I E W</h2></div>
		<div class="reviewList">
			<ul>
				<c:forEach items="${list }" var="r">
					<li class="review" onclick="location.href='/selectOneReviewFrm.do?reviewNo=${r.reviewNo}&storeNo=${r.storeNo }'">
						<c:choose>
							<c:when test="${r.reviewImg eq null}">
								<div class="pic-zone"><img src="/resources/upload/review/noimg.png"></div>
							</c:when>
							<c:otherwise>
								<div class="pic-zone"><img src="/resources/upload/review/${r.reviewImg }"></div>
							</c:otherwise>
						</c:choose>
						<div class="description">
							<p class="content">${r.reviewContent }<p>
							<p class="writer">${r.reviewWriter }</p>
							<p class="date">${r.reviewDate }</p>
							<c:choose>
								<c:when test="${r.rating eq 1}">
									<p class="point"><img src="/resources/img/main/ico_point1.gif"></p>
								</c:when>
								<c:when test="${r.rating eq 2}">
									<p class="point"><img src="/resources/img/main/ico_point2.gif"></p>
								</c:when>
								<c:when test="${r.rating eq 3}">
									<p class="point"><img src="/resources/img/main/ico_point3.gif"></p>
								</c:when>
								<c:when test="${r.rating eq 4}">
									<p class="point"><img src="/resources/img/main/ico_point4.gif"></p>
								</c:when>
								<c:when test="${r.rating eq 5}">
									<p class="point"><img src="/resources/img/main/ico_point5.gif"></p>
								</c:when>
							</c:choose>
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
		<div class="listBtn">
				${pageNavi }
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