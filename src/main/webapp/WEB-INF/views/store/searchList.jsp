<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리브레드 구매하기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/store/purchaseList.css">
<!--aos라이브러리-->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<link
href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="page-content">
		<div class="page-title" data-aos="fade-right" data-aos-duration="1000" data-aos-delay="500">
		<h2>B A K E R Y</h2>
		</div>
		<div class="list">
			<ul>
				<li>디저트</li>
				<li>비건 라이프</li>
				<li>비건 스타터</li>
			</ul>
		</div>
		<div class="topList">
			<ul>
				<li class="pic1"><img src="/resources/img/store/01.jpg"></li>
				<li class="pic2"><img src="/resources/img/store/02.jpg"></li>
				<li class="pic3"><img src="/resources/img/store/03.jpg"></li>			
			</ul>
		</div>
		<div class="div-pick-box" style="margin-bottom: 100px;">
			<c:choose>
				<c:when test="${not empty storeName }">
					<span class="listPickNum">스토어 ${countName } 개</span>&nbsp;&nbsp; 
				</c:when>
				<c:otherwise>
					<span class="listPickNum">스토어 ${count } 개</span>&nbsp;&nbsp; 
				</c:otherwise>
			</c:choose>
			<span class="search" style="cursor: pointer;">(매장검색)</span>
			<span style="float: right;">'${breadName}'으로 검색된 결과입니다.</span>
			<div class="searchBar">
				<form action="/purchaseList.do">
					<input type="hidden" name="reqPage" value="1">
					<c:choose>
						<c:when test="${not empty storeName }">
		               		<input type="text" name="storeName" class="storeNamebar" value="${storeName }">
		               		<button type="submit" class="searchBtn">검색</button>
		              	</c:when>
		            	<c:otherwise>
			                <input type="text" name="storeName" class="storeNamebar" placeholder="매장검색">
			                <button type="submit" class="searchBtn">검색</button>
		                </c:otherwise>
					</c:choose>
				</form>
			</div>
		</div>
		
		
		<!-- 여기서부터는 가게리스트 -->
		<div class="item-basket-box">
			<c:choose>
				<c:when test="${empty list}">
					<img style="width: 1200px; height: 500px;" src="/resources/img/store/404error.jpg">
					<p style="font-size: 20px;">검색결과가 없습니다.</p>
					<p>다른검색어로 다시 시도해주세요.</p>
					<p style="margin-bottom: 15px;">빵을 요청하면 더 다양한 빵을 만나보실수 있습니다.</p>
					<div class="go-main" onclick= "location.href='/DoMain.do'">메인페이지 이동</div>
				</c:when>
			</c:choose>
			<ul>
				<c:forEach items="${ list}" var="s">
					<li>
						<c:choose>
							<c:when test="${empty sessionScope.m}">
								<a href="/detailStore.do?storeNo=${s.storeNo}&memberNo=0">
									<div class="storePic"><img src="/resources/img/store/${s.storeImg }"></div>
									<div class="cart"><img src="/resources/img/store/cart.png"></div>
								</a>
							</c:when>
							<c:otherwise>
								<a href="/detailStore.do?storeNo=${s.storeNo}&memberNo=${sessionScope.m.memberNo}">
									<div class="storePic"><img src="/resources/img/store/${s.storeImg }"></div>
									<div class="cart"><img src="/resources/img/store/cart.png"></div>
								</a>
							</c:otherwise>
						</c:choose>
						
						<div style="height: 42px; line-height: 42px; margin-top: 13px;">
							<span class="storeName">${s.storeName}</span>
							<span class="sale">-${s.maxDiscount }%</span>
						</div>
						<div class="review">
							<img src="/resources/img/store/review.png" >${s.reviewCount}
							<span class="open-close"> ${s.openTime}<span>~</span>${s.closeTime }</span>
						</div>
					</li>
				</c:forEach>
			</ul>		
		</div>
		<c:choose>
			<c:when test="${!empty list}">
				<div class="listBtn">${pageNavi }</div>
			</c:when>
		</c:choose>
		
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
const lis = $(".list>ul>li"); 
const pic = $(".topList>ul>li>img");
	lis.on("click",function(){
		const index = lis.index(this);
		pic.hide();
		pic.eq(index).show();
		
		lis.css("color","darkgray");
		lis.css("text-decoration","none");
		lis.css("font-weight","500");
		lis.eq(index).css("font-weight","600").css("transition-duration","0.3s");
		lis.eq(index).css("color", "#f4791f");
		lis.eq(index).css("text-decoration","underline");
	});
const search = $(".search");
const searchBar = $(".searchBar");
	search.on("click",function(){
		searchBar.toggle(400);
	});
</script>
</html>