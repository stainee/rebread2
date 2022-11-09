<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 상세 목록</title>
<link rel="stylesheet" href="/resources/css/common/default.css">
<link rel="stylesheet" href="/resources/css/store/storeDetail.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<div class="page-content">
		<div class="page-wrap">
			<!--가게 정보, 메뉴 -->
			<div class="left-content">
				<div class="mid-title">
					<h2>${sd.s.storeName }</h2>
				</div>
				<div class="store-detail-box">
					<div class="img">
						<img src="/resources/upload/store/${sd.s.storeImg }">
					</div>
					<div class="store-detail">
						<span id="star">★ ${sd.s.rating }</span>
						<p>${sd.s.storeContent }</p>
					</div>
				</div>
				
				<div id="delivery-type">
					<%-- 
					<ul class="delivery-tabs">
						<li class="btn bc4">배달</li>
						<li class="btn bc4">픽업</li>
					</ul>
					--%>
					<ul>
						<a href="/insertProductFrm.do?storeNo=${sd.s.storeNo}&storeName=${sd.s.storeName }&storeAddr=${sd.s.storeAddr}" class="btn bc4">빵등록</a>
						<!-- <a href="/updateProductFrm.do?storeNo=${s.storeNo}&storeName=${s.storeName }&storeAddr=${s.storeAddr}" class="btn bc4">빵수정</a> -->
					</ul>
					<!-- <button class="btn bc4"onclick="delivery();">배달</button>
                        <button class="btn bc4"onclick="pickup();">픽업</button> -->
				</div>
				
				<div class="tab-wrap">
					<ul class="tabs">
						<li class="btn bc44">MENU</li>
						<li class="btn bc44">RIVIEW</li>
						<li class="btn bc44">MAP</li>
					</ul>
					<div class="content-wrap">
						<div class="tabcontent" id="MENU">
							<div class="category">
								<c:forEach items="${sd.lossList}" var="sdl">
									<h2>REBREAD 마감빵</h2>
									<div class="menu-box">
										<div id="bread-img">
											<img src="/resources/upload/product/${sdl.productImg }">
										</div>
										<div class="bread-info">
											<span id="bread-name">${sdl.productName }</span><br> <span
												id="bread-detail">${sdl.productContent }</span>
										</div>
										<div class="bread-price">
											<span id="discount">${sdl.productSale }%</span><br> 
											<span id= "price"style="text-decoration: line-through; color: #999999;">${sdl.productPrice }</span><span>→
												3000</span>
										</div>
										<div class="fix"></div>
									</div>
								</c:forEach>
							</div>
							<!--  
							<div class="category">
								<h2>BEST MENU</h2>
								<div class="menu-box">
									<div id="bread-img">
										<img src="img/거북이빵.jpg">
									</div>
									<div class="bread-info">
										<span id="bread-name">예시 따끈따끈한 빵</span><br> 
										<span id="bread-detail">갓 만든 따끈따끈한 케로로 빵 갓 만든 따끈따끈한 케로로 빵 갓
											만든 따끈따끈한 케로로 빵</span>
									</div>
									<div class="bread-price">
										<span id="discount">70%</span><br> <span
											style="text-decoration: line-through; color: #999999;">10,000</span><span>→
											3,000</span>
									</div>
								</div>
							</div>
							-->
						</div>
						<div class="tabcontent" id="REVIEW"></div>
						<div class="tabcontent" id="MAP">
							<h2>MAP</h2>
						</div>
					</div>
				</div>
			</div>
			<!-- 오른쪽 장바구니 -->
			<div class="right-content">
				<div class="mid-title">
					<h2>CART</h2>
				</div>
				<foam action="#" method="post">
				<div class="cart-wrap">
					<div class="cart-box">
						<div id="cart-img">
							<img src="">
						</div>
						<div id="cart-name">
							<input type="hidden" name="productNo" value="">
						</div>
						<div id="cart-amount">
							<table>
								<tr>
									<th><input type="button" value="-" name="minus"></th>
									<th><input type="text" value="" name="amount" readonly></th>
									<th><input type="button" value="+" name="plus"></th>
								</tr>
							</table>
							<div>
								<input type="text" name="">원
							</div>
						</div>
					</div>
					<div class="cart-box">
						<div id="cart-img">
							<img src="">
						</div>
						<div id="cart-name">
							<input type="hidden" name="productNo" value="">
						</div>
						<div id="cart-amount">
							<table>
								<tr>
									<th><input type="button" value="-" name="minus"></th>
									<th><input type="text" value="" name="amount" readonly></th>
									<th><input type="button" value="+" name="plus"></th>
								</tr>
							</table>
							<div>
								<input type="text" name="orderProprice">원
							</div>
						</div>
					</div>
				</div>
				</foam>
			</div>
			<!--장바구니 화면-->

		</div>


		<!-- 상품 상세페이지(수량 선택하기)-->
		<div class="detail-modal">
			<div class="detail-wrap">
				<div class="detail-header">
					<h1>메뉴 상세</h1>
					<span class="material-symbols-outlined">close</span>
				</div>
				<div class="detail-content">
					<div class="detail-img">
						<img src="img/거북이빵.jpg">
					</div>
					<div class="detail-text">
						<div class="detail-name">태빵 56호</div>
						<div class="detail-info">명장 브래드리의 섬세한 손길로 탄생한 태빵 56호 명장
							브래드리의 섬세한 손길로 탄생한 태빵 56호</div>
					</div>
				</div>
				<div class="detail-price">
					<strong>가격</strong>
					<div>
						<p>5,600</p>원
					</div>
				</div>
				<div class="quantity-control">
					<strong>수량</strong>
					<table>
						<tr>
							<th><input type="button" value="-" name="minus"></th>
							<th><input type="text" value="1" name="amount" readonly></th>
							<th><input type="button" value="+" name="plus"></th>
						</tr>
					</table>
				</div>
				<div class="total-price">
					<strong>총 주문금액</strong>
					<div>
						<p>5,600</p>원
					</div>
				</div>
				<div class="detail-btn">
					<button type="button" class="btn bc5 bs4">주문표에 추가</button>
				</div>
			</div>
		</div>
		<!--상품 상세페이지 끝-->
	</div>
	
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<script src="/resources/js/store/storeDetail.js"></script>
</body>
</html>