<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 상세 목록</title>
<link rel="stylesheet" href="/resources/css/common/default.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
<link rel="stylesheet" href="/resources/css/store/storeDetail.css">
<style>
	.cart-box-wrap{
    width: 100%;
    margin: 0 auto;
	}
</style>
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
					<ul class="delivery-tabs">
						<li class="btn bc4">배달</li>
						<li class="btn bc4">픽업</li>
					</ul>
					
					<!-- 사장님 화면-->
					<c:if test="${sessionScope.memberNo eq sd.s.memberNo}"> 
						<ul>
							<a href="/insertProductFrm.do?storeNo=${sd.s.storeNo}&storeName=${sd.s.storeName }&storeAddr=${sd.s.storeAddr}" class="btn bc4">빵등록</a>
							<!-- <a href="/updateProductFrm.do?storeNo=${s.storeNo}&storeName=${s.storeName }&storeAddr=${s.storeAddr}" class="btn bc4">빵수정</a> -->
						</ul>
					</c:if>
					<!-- <button class="btn bc4"onclick="delivery();">배달</button>
                        <button class="btn bc4"onclick="pickup();">픽업</button> -->
				</div>
				
				<div class="tab-wrap">
					<ul class="tabs">
						<li class="btn bc44">MENU</li>
						<li class="btn bc44">RIVIEW<!-- <span>(${sd.s.reviewCount })</span> --></li>
						<li class="btn bc44">MAP</li>
					</ul>
					<div class="content-wrap">
						<div class="tabcontent" id="MENU">
				
							<c:if test="${not empty sd.lossList}">
							<div class="category">
								<h2>REBREAD 마감빵</h2>
								<div class="sdl">
								<c:forEach items="${sd.lossList}" var="sdl">
									<div class="menu-box" idx="${sdl.productNo }">
										<div id="bread-img">
											<img id="Img" src="/resources/upload/product/${sdl.productImg }">
										</div>
										<div class="bread-info">
											<span id="bread-name">${sdl.productName }</span><br> <span
												id="bread-detail">${sdl.productContent }</span>
										</div>
										<div class="bread-price">
											<span id="discount">${sdl.productSale }%</span><br> 
											<span id= "price"style="text-decoration: line-through; color: #999999;">${sdl.productPrice }</span>
											<span>→ <strong class="lastPrice">${sdl.productPrice-(sdl.productPrice*sdl.productSale /100)}</strong></span>
										</div>
										<c:if test="${sessionScope.memberNo eq sd.s.memberNo}">
										<div class="fix">
											<a href="/updateProductFrm.do?productNo=${sdl.productNo }&storeNo=${sdl.storeNo}&storeName=${sd.s.storeName}&storeAddr=${sd.s.storeAddr}" class="btn bc4">수정</a>
											<a href="/deleteProduct.do?productNo=${sdl.productNo}&storeNo=${sd.s.storeNo}" class="btn bc4">삭제</a>
										</div>
										</c:if>
									</div>
								</c:forEach>
								</div>
							</div> 
							</c:if>
							
							<c:if test="${not empty sd.nomalList }">
							<div class="category">
								<h2>REBREAD 일반빵</h2>
								<div class="sdn">
								<c:forEach items="${sd.nomalList}" var="sdn">
								<div class="menu-box" idx="${sdn.productNo }">
									<div id="bread-img">
										<img id="Img"src="/resources/upload/product/${sdn.productImg }">
									</div>
									<div class="bread-info">
										<span id="bread-name">${sdn.productName }</span><br> 
										<span id="bread-detail">${sdn.productContent }</span>
									</div>
									<div class="bread-price">
										<span id="discount">${sdn.productSale }%</span><br> 
										<span id="price" style="text-decoration: line-through; color: #999999;">${sdn.productPrice }</span>
										<span>→ <strong class="lastPrice">${sdn.productPrice-(sdn.productPrice*sdn.productSale /100)}</strong></span>
									</div>
									<c:if test="${sessionScope.memberNo eq sd.s.memberNo}">
									<div class="fix">
										<a href="/updateProductFrm.do?productNo=${sdn.productNo }&storeNo=${sdn.storeNo}&storeName=${sd.s.storeName}&storeAddr=${sd.s.storeAddr}" class="btn bc4">수정</a>
										<a href="/deleteProduct.do?productNo=${sdn.productNo}&storeNo=${sd.s.storeNo}" class="btn bc4">삭제</a>
									</div>
									</c:if>
								</div>
								</c:forEach>
								</div>
							</div>
							</c:if>
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
                    <div class="mid-title"><h2>CART</h2></div>
                    <form action="#" method="post">
                        <div class="cart-wrap">
                            <input type="hidden" name="memberNo" value="">
                            <input type="hidden" name="storeNo"value="">
                            <div class="cart-box-wrap">
                            <!-- 
                            <div class="cart-box">
                            	 
                                <div id="cart-img"><img src="/img/거북이빵.jpg" width="60px" height="60px"></div>
                                <div class="cart-name">
                                    <input type="text" name="productName" value="" readonly>
                                    <input type="hidden" name="productNo" value="">
                                </div>
                                <div class="cart-amount">
                                    <span><input type="text" name="productStock" value="3" readonly>개</span>
                                    <span><input type="hidden" name="productPrice" value="3000">3,000원</span>
                                </div>
                                
                            </div>
                            -->
                            </div>
                            <div class="price-zone">
                                <div>
                                    <span>상품가격</span>
                                    <span><strong></strong> 원</span>
                                </div>
                                <div>
                                    <span>배송비</span>
                                    <span><strong>3,000</strong> 원</span>
                                </div>
                                <div>
                                    <span>결제예정금액</span>
                                    <span><input type="hidden" name="orderPrice" value="">원</span>
                                </div>
                            </div>
                            <div class="subBtn">
                                <input type="submit" value="결제하기" class="btn bc5 bs4">
                            </div>
                        </div>
                        
                    </form>
                </div>
                <!--장바구니 화면 끝-->

		</div>


		<!-- 상품 상세페이지(수량 선택하기)-->
		<div class="detail-modal">
			<div class="detail-wrap">
				<div class="detail-header">
					<h1>메뉴 상세</h1>
					<span id="closeBtn"class="material-symbols-outlined">close</span>
				</div>
				<div class="detail-content">
					<div class="detail-img">
						<img id="imgSrc"src="">
					</div>
					<div class="detail-text">
						<div class="detail-name"></div>
						<div class="detail-info"></div>
					</div>
				</div>
				<div class="detail-price">
					<strong>가격</strong>
					<div>
						<p></p>원
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
						<p></p>원
					</div>
				</div>
				<div class="detail-btn">
					<button type="button" class="btn bc5 bs4" idx="">주문표에 추가</button>
				</div>
			</div>
		</div>
		<!--상품 상세페이지 끝-->
	</div>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
	<script src="/resources/js/store/storeDetail.js"></script>
	<script>
	
	<%--
	let price = $(".lastPrice").text();
	price2 = Math.floor(price);
	console.log("소수점 제거: "+price2);
	comPrice = addComma(price2);
	console.log(comPrice);
	$(".lastPrice").text(comPrice);
	--%>
	
	const arr = $(".lastPrice");
	console.log(arr.length);
	for(let i=0;i<arr.length;i++){
		let price = (arr.eq(i).text());
		price = parseInt(Math.floor(price));
		arr.eq(i).text(addComma(price));
	}
	
	$(".menu-box").on("click",function(){
		const productNo = $(this).attr("idx");
		//console.log("idx : "+productNo);
		const productName = $(this).find("#bread-name").text();
		const src= $(this).find("#Img").attr("src");
		console.log(src);

		const detail = $(this).find("#bread-detail").text();
		//console.log("설명 : "+detail);
		
		const showPrice = $(this).find(".lastPrice").text();
		
		$("#imgSrc").attr("src",src);
		$(".detail-name").text(productName);
		$(".detail-info").text(detail);
		$(".detail-price p").text(showPrice);
		$(".total-price p").text(showPrice);
		$(".detail-btn button").attr("idx",productNo);
		
	});
	
	//주문표에 추가 버튼 누를 시
	$(".detail-btn button").on("click",function(){
		
		const productNo = $(this).attr("idx");
		//console.log("제품번호"+productNo);
		const src= $(this).parents().find("#imgSrc").attr("src");
		//console.log("주문표에 추가 버튼 누를 시 : "+src);
		const name= $(this).parents().find(".detail-name").text();
		//console.log("빵이름"+name);
		const info =$(this).parents().find(".detail-info").text();
		//console.log(info);
		const showPrice = $(this).parents().find(".total-price p").text();
		//console.log(showPrice);
		const inputPrice = minusComma(showPrice);
		//console.log(inputPrice);
		const amount = $(this).parents().find("[name=amount]").val();
		//console.log(amount);
		
		//버튼 누른 후 모달창 닫기, 수량 1로 바꿔주기
		$(".detail-modal").hide();
		$("[name=amount]").attr("value",1);
		
		const cartWrap = $(".cart-wrap");
		
		//같은 제품이 담겨있는지 먼저 체크(for문으로 검사)하고 cartwrap에 담기
		let arr = $(".cart-name [name=productNo]");
		for(let i=0;i<arr.length;i++){
			const checkNo = arr.eq(i).val();
			
			if(productNo ==checkNo){
				alert("이미 카트에 담겨있는 상품입니다.");
				return;
			}
		}
		//포문으로 카트에 담기
		for(let i=0;i<cartWrap.length;i++){
			
			let html = '';
			
			html += '<div class="cart-box">';
			html += '<div id="cart-img"><img src="'+src+'"width="60px" height="60px"></div>';
			html += '<div class="cart-name">';
			html += '	<input type="text" name="productName" value="'+name+'" readonly>';
			html += '	<input type="hidden" name="productNo" value="'+productNo+'">';
			html += '	<input type="hidden" name="productContent value="'+info+'">';
			html += '</div>';
			html += '<div class="cart-amount">';
			html += '	<span><input type="text" name="productStock" value="'+amount+'" readonly>개</span>';
			html += '	<span><input type="hidden" name="productPrice" value="'+inputPrice+'">'+showPrice+'원</span>';
			html += '</div>';
			html += '</div>';
			
			const boxWrap = $(".cart-box-wrap");
			boxWrap.append(html);
		};
		
		
	});
	
	
	//콤마 추가 펑션
	function addComma(value){
		value = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		return value; 
	};

	</script>
</body>
</html>