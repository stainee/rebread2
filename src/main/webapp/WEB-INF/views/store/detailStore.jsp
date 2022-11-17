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
<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>

</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<div class="page-content">
		<div class="page-wrap">
			<!--가게 정보, 메뉴 -->
			<div class="left-content">
				<div class="mid-title">
					<h2>${sd.s.storeName }</h2>
					<c:choose>
						<c:when test="${not empty sessionScope.m }">
							<c:choose>
								<c:when test="${not empty sd.l}">
									<span id="delLike" class="material-symbols-outlined">favorite</span>
									<span id="like" class="material-symbols-outlined" style="display: none;">favorite</span>
								</c:when>
								<c:otherwise>
									<span id="like" class="material-symbols-outlined">favorite</span>
									<span id="delLike" class="material-symbols-outlined" style="display: none;">favorite</span>
								</c:otherwise>
							</c:choose>
						</c:when>
						<%--비로그인 시 로그인 창 뜨도록 --%>
						<c:otherwise>
							<span class="material-symbols-outlined" onclick="alarm();">favorite</span>
						</c:otherwise>
					</c:choose>
					
				</div>
				<div class="store-detail-box">
					<div class="img">
						<img src="/resources/img/store/${sd.s.storeImg }">
					</div>
					<div class="store-detail">
						<span id="star">★ ${sd.s.rating }</span>
						<input type="hidden" name="addr" value="${sd.s.storeAddr }">
						<p>${sd.s.storeContent }</p>
					</div>
				</div>
				
				<div id="delivery-type">
					<!-- 사장님 화면일 때 -->
					<c:choose>
						<c:when test="${sessionScope.m.memberNo eq sd.s.memberNo}">
							<a href="/insertProductFrm.do?storeNo=${sd.s.storeNo}&storeName=${sd.s.storeName }&storeAddr=${sd.s.storeAddr}" class="btn bc4">빵등록</a>
							<!-- <a href="/updateProductFrm.do?storeNo=${s.storeNo}&storeName=${s.storeName }&storeAddr=${s.storeAddr}" class="btn bc4">빵수정</a> -->
						</c:when>
						<c:otherwise>
							<button class="btn bc4"onclick="delivery();">배달</button>
                    		<button class="btn bc4"onclick="pickup();">픽업</button>
						</c:otherwise>
					</c:choose>
				
				</div>
				
				<div class="tab-wrap">
					<ul class="tabs">
						<li class="btn bc44">MENU</li>
						<li class="btn bc44">RIVIEW<!-- <span>(${sd.s.reviewCount })</span> --></li>
						<li class="btn bc44">LOCATION</li>
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
										
										<!-- 사장님에게만 수정,삭제버튼 노출 -->
										<c:if test="${sessionScope.m.memberNo eq sd.s.memberNo}">
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
						<div class="tabcontent" id="REVIEW">
							<div class="review-box-wrap">	
								<c:if test="${not empty sessionScope.m }">
								<div class="input-comment-box">
									<form action="/insertReview.do" method="post" enctype="multipart/form-data">
		                      			<div id="product-viewer">
											<img id="img-view" width="150px">
										</div>	
		                      			<div>
		                      				<div>
		                  						<span>별점</span>
		                  						<select name="rating">
		                  							<option value="1">★</option>
		                  							<option value="2">★★</option>
		                  							<option value="3">★★★</option>
		                  							<option value="4">★★★★</option>
		                  							<option value="5">★★★★★</option>
		                  						</select>
		                      					<input type="file" name="upFile" accept="image/*" onchange="loadImg(this);" required="required">
		                      				</div>
		                      				
		                           			<div class="inputReview">
		                           				<input type="hidden" name="memberNo" value="${sessionScope.m.memberNo }">
		                           				<input type="hidden" name="reviewWriter" value="${sessionScope.m.memberId }">
				                                <input type="hidden" name="storeNo" value="${sd.s.storeNo}">
				                                <input type="hidden" name="reviewComment" value="0"><%--대댓글용 댓글번호 --%>
				                                <textarea name="reviewContent" required="required" maxlength="200"></textarea>
				                                <input type="submit" id="commentBtn"class="btn bc5" value="댓글달기">
		                           			</div>
		   
		                        		</div>
									</form>
                    			</div>
                    			</c:if>
                    			<div class="category">
									<h2>REBREAD 리뷰</h2>
								</div>
                    			<div class="review-list-wrap">
                    			//여기여기
                    			</div>
                    		</div>
				
						</div>
						
						<!-- 지도  -->
						<div class="tabcontent" id="LOCATION">
							<h2>${sd.s.storeAddr }</h2>
							
							<div id="map" style="width:600px;height:400px;"></div>
						</div>
						<!-- 지도 끝 -->
					</div>
				</div>
			</div>
			
			<!-- 오른쪽 장바구니 -->
                <div class="right-content">
                    <div class="mid-title"><h2>CART</h2></div>
                    <form action="/orderFrm.do" method="post">
                        <div class="cart-wrap">
                            <input type="hidden" name="memberNo" value="${sessionScope.m.memberNo}">
                            <input type="hidden" name="storeNo"value="${sd.s.storeNo}">
                            <input type="hidden" name="deliveryType" value="배달준비중">
                            <div class="cart-box-wrap">
                           	<!-- 물품 내역 담길 곳 -->
                           	
                            </div>
                            <div class="price-zone">
                                <div>
                                    <span>상품가격</span>
                                    <span id="p1"><strong></strong> 원</span>
                                </div>
                                <div>
                                    <span>배송비</span>
                                    <span><strong id="dPrice">3,000</strong> 원</span>
                                </div>
                                <div>
                                    <span>결제예정금액</span>
                                    <span id="lP"><input type="hidden" name="orderPrice" value=""> 원</span>
                                </div>
                            </div>
                            <c:choose>
    							<c:when test="${not empty sessionScope.m.memberNo}">
		                            <div class="subBtn">
		                                <input type="submit" value="결제하기" class="btn bc5 bs4">
		                            </div>
	                            </c:when>
	                            <c:otherwise>
	                            	<div class="subBtn">
		                                <button type="button"class="btn bc5 bs4" onclick="alarm();">결제하기</button>
		                            </div>
	                            </c:otherwise>
                            </c:choose>
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
				<c:choose>
					<c:when test="${not empty sessionScope.m.memberNo}">
						<div class="detail-btn">
							<button type="button" class="btn bc5 bs4" idx="" >주문표에 추가</button>
						</div>
					</c:when>
					<c:otherwise>
						<div class="login-btn">
							<button type="button" class="btn bc5 bs4" onclick="alarm();" >주문표에 추가</button>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<!--상품 상세페이지 끝-->
		
		<!-- 로그인 알림 -->
		<div class="alarm-modal">
			<div class="alarm-wrap">
				<div>리브래드에 먼저 로그인을 해주세요.</div>
				<div class="btnZone">
					<a href="/login.do" class="btn bc4">예</a>
					<button type="button" class="btn bc4">아니요</button>
				</div>
			</div>
		</div>
		<!-- 로그인 알림 모달 끝 -->
	</div>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7eb9ba960e94dd83c11243c2a4da622f&libraries=services"></script>
	<script src="/resources/js/store/storeDetail.js"></script>
	<script>
	
	//좋아요 버튼 누를 시 delete
	$("#delLike").on("click",function(e){
		const storeNo =$("[name=storeNo]").val();
		const memberNo=$("[name=memberNo]").val();
		
		//$("#delLike").css("color","black");
		
		$.ajax({
			url:"/deleteLike.do",
			data:{storeNo:storeNo, memberNo:memberNo},
			success:function(data){
				if(data == 1){
					//$("#delLike").off('click');
					$("#like").show();
					$("#delLike").hide();
				}
			}
			
		});
		
	});
	
	//좋아요 버튼 누를 시  insert
	$("#like").on("click",function(e){
		const storeNo =$("[name=storeNo]").val();
		const memberNo=$("[name=memberNo]").val();
		
		//$("#like").css("color","red");
		
		$.ajax({
			url:"/insertLike.do",
			data:{storeNo:storeNo, memberNo:memberNo},
			success:function(data){
				//console.log(data);
				if(data == 1){
					//$("#like").off('click');
					$("#delLike").show();
					$("#like").hide();
				}
			}
		});
	});
	
	
	function delivery(){
		//<input type="hidden" name="deliveryType" value="1">
		$("[name=deliveryType]").attr("value","배달준비중");
	};
	function pickup(){
		$("[name=deliveryType]").attr("value","픽업준비중");
	};
	
	function alarm(){
		$(".alarm-modal").css("display","flex");
	};
	
	//주문표에 추가 버튼 누를 시 로그인 화면으로 이동하기
	$(".btnZone [type=button]").on("click",function(){
		$(".alarm-modal").hide();
	});

	//가격 계산을 위한 변수 선언
		let p1 =0;
		
		const arr = $(".lastPrice");
		//console.log(arr.length);
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
			const inputPrice = Number(minusComma(showPrice));
			//console.log(inputPrice);
			const amount = $(this).parents().find("[name=amount]").val();
			//console.log(amount);
			
			//버튼 누른 후 모달창 닫기, 수량 1로 바꿔주기
			$(".detail-modal").hide();
			$("[name=amount]").attr("value",1);
			
			//같은 제품이 담겨있는지 먼저 체크(for문으로 검사)하고 wrap에 담기
			let arr = $(".cart-name [name=pNo]");
			for(let i=0;i<arr.length;i++){
				const checkNo = arr.eq(i).val();
				
				if(productNo ==checkNo){
					alert("이미 카트에 담겨있는 상품입니다.");
					return;
				}
			}
			
			let html = '';
				
			html += '<div class="cart-box">';
			html += '	<div id="cart-img"><img src="'+src+'"width="60px" height="60px"></div>';
			html += '	<div class="cart-name">';
			html += '		<input type="text" name="pName" value="'+name+'" readonly>';
			html += '		<input type="hidden" name="pNo" value="'+productNo+'">';
			html += '		<input type="hidden" name="pContent" value="'+info+'">';
			html += '		<input type="hidden" name="pImg" value="'+src+'">';
			html += '	</div>';
			html += '	<div class="cart-amount">';
			html += '		<span><input type="text" name="pStock" value="'+amount+'" readonly>개</span>';
			html += '		<span><input type="hidden" name="pPrice" value="'+inputPrice+'">'+showPrice+'원</span>';
			html += '	</div>';
			html += '	<div class="delBtn">';
			html += '		<span class="material-symbols-outlined" onclick="cancel(this);">cancel</span> ';
			html += '	</div>';
			html += '</div>';
			
			const boxWrap = $(".cart-box-wrap");
			boxWrap.append(html);
			
			if($(".cart-box").length == 0){
				$("#p1 strong").text(0);
				$(".cart-amount [name=pPrice]").attr("value",0);
			}else{
				p1 += Number($(".cart-amount [name=pPrice]").eq($(".cart-box").length-1).val());
				let p2 = addComma(p1);
				$("#p1 strong").text(p2);
				let price2 = p1+3000;
				$("#p1 [name=orderPrice]").attr("value",price2);
				$("#lP").text(addComma(price2));
			}
		});
		
	
		//리뷰탭 클릭 시 리뷰 불러오기
		$(tabs.eq(1)).on("click",function(){
			const storeNo =$("[name=storeNo]").val();
			
			$.ajax({
				url:"/selectReview.do",
				data:{storeNo:storeNo},
				success:function(data){
					//console.log(data);
					
					var html = '';
					for(let i=0; i<data.length; i++){
						console.log(data[i]);
						html += '<div class="review-box">';
						html += '	<div id="bread-img">';
						html +=	'		<img id="Img" src="/resources/upload/review/'+data[i].reviewImg+'">';
						html +=	'	</div>';
						html +=	'	<div class="review-info">';
						html +=	'		<div class="review-mid">';
						html += '			<div class="rating">';	
						html += '				<span id="reviewer">'+data[i].reviewWriter+'</span>';
						html += '				<span>★  '+data[i].Rating +'</span>';
						html += '			</div>';	
						html += '			<div class="reviewfix">';
						html += '				<span>'+data[i].reviewDate+'</span>';
						html += '				<span id="dBtn" idx="'+data[i].reviewNo+'">삭제</span>';
						html += '			</div>';
						html += '		</div>';	
						html += '		<div class="review-content">';
						html += '			<p>'+data[i].reviewContent+'</p>';
						html += '		</div>';
						html += '	</div>';
						html += '</div>';
						
					}
					$(".review-list-wrap").html(html);
					
				}
			});
		});
		
		
		
		//카트에 담긴 장바구니 삭제버튼 클릭시
		function cancel(obj){
			let min =$(obj).parent().parent().find(".cart-amount [name=pPrice]").val();
			console.log("마이너스 할 금액 : "+min);
			//let p3 = Number(minusComma($("#p1 strong").text()));
			console.log("더해져있던 금액 : "+p1);
			let minP = addComma(p1-min)
			$("#p1 strong").text(minP);
			$(obj).parent().parent().remove();
			
			if($(".cart-box").length == 0){
				//$("[name=orderPrice]").attr("value",0);
				$("#lP").text("0 원");
				p1 = 0;
				$("#p1 strong").text("0");
			}else{
				let lP =Number(minusComma($("#p1 strong").text()))+Number(minusComma($("#dPrice").text()));
				console.log(lP);
				$("#lP").text(addComma(lP));	
			}
			
		};
				
		//콤마 추가 펑션
		function addComma(value){
			value = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			return value; 
		};
		//콤마 제거 펑션
		function minusComma(value){
		    value = value.toString().replace(/[^\d]+/g, "");
		    return value; 
		};
	</script>
</body>
</html>