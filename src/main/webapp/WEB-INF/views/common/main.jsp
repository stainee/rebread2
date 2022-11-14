<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리브레드</title>
<link rel="stylesheet" href="/resources/css/common/main.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!--aos라이브러리-->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

<!--메인 폰트-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Montserrat+Alternates:wght@100&family=Montserrat:wght@300&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@200&display=swap"
	rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="page-content">
		<!--상단의 빵 슬라이드-->
		<div class="topSlide">
			<ul id="slider1">
				<li><a href="#"><img src="/resources/img/main/mainslide1.jpg"></a></li>
				<li><a href="/brandIntro.do"><img src="/resources/img/main/mainslide2.jpg"></a></li>
				<li><a href="/brandIntro.do"><img src="/resources/img/main/mainslide3.jpg"></a></li>
			</ul>
		</div>
		<div class="main-section-ment">
			<ul>
				<li>
					<p style="margin-bottom: 15px;">
						<font size="5em" color="#785c37"> <span
							data-aos="fade-down" data-aos-duration="1000"
							data-aos-delay="500">R </span> <span data-aos="fade-down"
							data-aos-duration="1000" data-aos-delay="750">E </span> <span
							data-aos="fade-down" data-aos-duration="1000"
							data-aos-delay="1000">B </span> <span data-aos="fade-down"
							data-aos-duration="1000" data-aos-delay="1250">R </span> <span
							data-aos="fade-down" data-aos-duration="1000"
							data-aos-delay="1500">E </span> <span data-aos="fade-down"
							data-aos-duration="1000" data-aos-delay="1750">A </span> <span
							data-aos="fade-down" data-aos-duration="1000"
							data-aos-delay="2000">D </span>
						</font>
					</p>
					<h2 id="section-mid" data-aos="fade-right" data-aos-duration="2000"
						data-aos-delay="1500">
						판매자와 소비자 모두 입장을 생각해 <br> 환경보호를 먼저 앞장서 나아가는 <br> 리브레드입니다.
					</h2>
					<p id="section-bottom">
						건강하고 친환경적인 비건문화 <br> 리브레드를 통해 만나보세요
					</p>
				</li>
			</ul>
		</div>

		<div class="best-item">
			<div class="item-title">
				<p>BEST-ITEM</p>
			</div>
			<div class="item-pic">
		<c:forEach items="${list }" var="p">
				<a href="#">
					<div>
						<img src="/resources/upload/product/${p.productImg }">
						<div class="price-about">
							<div class="bread-name">${p.productName }</div>
							<div class="bread-price">${p.productPrice }<span>원</span>
							</div>
						</div>
					</div>
				</a> 
		</c:forEach>
			</div>
		</div>
		<div class="main-search">
			<div class="search-bar">
				<form action="/searchBread.do" method="post">
					<input id="searchText" type="text" name="breadName" placeholder="원하는 빵을 입력해보세요"> 
					<input id="searchIcon" type="submit" value="SEARCH">
					<input type="hidden" name="reqPage" value="1">
				</form>
			</div>
			<div id="frequent-word">
				<a href="/searchBread.do?reqPage=1&breadName='케이크'">#케이크</a> 
				<a href="/searchBread.do?reqPage=1&breadName='소금빵'">#소금빵</a> 
				<a href="/searchBread.do?reqPage=1&breadName='로스빵'">#로스빵</a> 
				<a href="/searchBread.do?reqPage=1&breadName='마늘바게트'">#마늘바게트</a>
			</div>
		</div>

		<div class="main-mid">
			<div class="mid-pic">
				<a href="#"><img src="/resources/img/main/mid1.jpg" data-aos="fade-up"
					data-aos-duration="1500" data-aos-offset="300"></a>
				<p class="mid-title" >비건 스타터</p>
				<p>환경을 생각하는 비건문화</p>
			</div>
			<div class="mid-pic">
				<a href="#"><img src="/resources/img/main/mdi2.jpg" data-aos="fade-down"
					data-aos-duration="1500" data-aos-offset="300"></a>
				<p class="mid-title">비건 헬스</p>
				<p>비건과 함께 하는 헬스문화</p>
			</div>
			<div class="mid-pic">
				<a href="#"><img src="/resources/img/main/mid3.jpg" data-aos="fade-up"
					data-aos-duration="1500" data-aos-offset="300"></a>
				<p class="mid-title">회원등급에 따른 혜택보장</p>
				<p>회원에 따른 혜택을 확인해보세요</p>
			</div>
		</div>

		<div class="pic-scroll">
			<ul>
				<div class="scroll-title">
					<h2>B R A N D</h2>
					<p class="bar">
						<img src="/resources/img/main/straight-w.png">
					</p>
				</div>
			</ul>
			<ul class="banner">
				<li class="scroll-fade" data-aos="fade-up" data-aos-duration="1500"
					data-aos-offset="500"><a href="#"> <img
						src="/resources/img/main/main-banner-img.jpg">
				</a></li>
				<li class="text-scroll-fade" data-aos="fade-down"
					data-aos-duration="1500" data-aos-offset="500">
					<h2>리브레드가 드리는 일상속의 편리함</h2>
					<p class="ment">
						빵을 다시 굽는다는 뜻으로, "빵 주문·통판 플랫폼"입니다. <br> 전국의 엄선된 빵집이 만든 빵을 주문할
						수 있으며, <br> 남는 빵을 플랫폼을 통해 순환하는 구조로 환경보호와 함께 <br> 빵 최저가를
						보장하고 있습니다. <br> 맛과 환경보호를 함께하는 '리브레드' 지금 당장 함께 하세요!
					</p> <a href="/brandIntro.do" id="brand-story"> BRAND STORY → </a>
				</li>
			</ul>
		</div>

		<div class="review">
			<div class="review-title">
				<h2 style="font-family: 'Montserrat', sans-serif;">BEST-REVIEW</h2>
			</div>
			<p class="bar" id="bar">
				<img src="/resources/img/main/straight-b.png">
			</p>
			<ul>
			<c:forEach items="${reviewList }" var="r">
				<li>
					<a href="/selectOneReviewFrm.do?reviewNo=${r.reviewNo }&storeNo=${r.storeNo}">
						<div class="review-wrap">
							<c:choose>
								<c:when test="${r.reviewImg eq null}">
									<img src="/resources/upload/review/noimg.png">
								</c:when>
								<c:otherwise>
									<img src="/resources/upload/review/${r.reviewImg }">
								</c:otherwise>
							</c:choose>
							<div class="description">
							<c:choose>
								<c:when test="${r.rating lt 3}">
									<p class="subject">불만족</p>
								</c:when>
								<c:otherwise>
									<p class="subject">만족</p>
								</c:otherwise>
							</c:choose>
								<p class="reContent">${r.reviewContent }</p>
								<p class="reDate">${r.reviewDate }</p>
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
						</div>
					</a>
				</li>
			</c:forEach>
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
<script src="/resources/js/common/main.js"></script>
<script>
const searchText = $("#searchText").val();
$(".searchIcon").on("click",function(){
	if(searchText==""){
		alert("검색어를 입력해주세요.");
		return false;
	}
});
</script>
</html>