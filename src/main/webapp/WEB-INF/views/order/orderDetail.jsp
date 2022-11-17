<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/common/managetemplate.css">
<link rel="stylesheet" href="/resources/css/font/font.css">
<link rel="stylesheet" href="/resources/css/order/orderDetail.css">
<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="total_wrapper" style="justify-content: center;">
	        <div class="left_container" style="max-height: 357px;">
	            <div class="memberInfo">
	                <p>[고객]</p>
	                <p>${sessionScope.m.memberName }님</p>
	                <div class="member-point">내 마일리지 : ${sessionScope.memberMileage }원</div>
	            </div>
	            <div class="selectList">
	                <ul>
						<li><a href="/memberMain.do?memberNo=${sessionScope.m.memberNo }">내정보</a></li>
	                    <li><a href="/memberOrderList.do?memberNo=${sessionScope.m.memberNo }&reqPage=1">최근 주문 내역</a></li>
	                    <li><a href="/memberReviewList.do?reviewWriter=${sessionScope.m.memberId }&reqPage=1">내 등록 리뷰</a></li>
	                </ul>
	            </div>
	        </div>
	
	        <div class="right_container" style="min-height: 357px;">
	        	<div class="content_container">
	        		<div class="content-box1">
	        			<div class="content-title-comment">
	        				<div class="content-title-state">
	        					<div>
	        						<a href="/memberOrderList.do?memberNo=${sessionScope.m.memberNo }&reqPage=${reqPage}"><img src="/resources/img/order/화살표.svg"></a>
	        					</div>
	        					<div>${o.orderState}</div>
	        				</div>
	        			</div>
	        			<div class="content-title-date">${o.orderDate }</div>
	        		</div>
	        		<div class="content-box2">
	        			<div class="content-addr">배송지 정보</div>
	        			<div class="content-info">
	        				<div>이름</div>
	        				<div>${o.orderName }</div>
	        			</div>
	        			<div class="content-info">
	        				<div>연락처</div>
	        				<div>${o.orderPhone }</div>
	        			</div>
	        			<div class="content-info">
	        				<div>주소</div>
	        				<div>${o.orderAddr }</div>
	        			</div>
	        		</div>
	        		<div class="content-box3">
	        			<c:forEach items="${list }" var="op" varStatus="i">
		        			<div class="content-product">
		        				<div class="content-img-box">
		        					<div class="content-img"><img src="/resources/upload/product/${pList[i.index].productImg }"></div>
		        					<div class="content-img-info">
		        						<div>${pList[i.index].productName }</div>
		        						<div>${op.orderProductQuan}개</div>
		        					</div>
		        				</div>
		        			</div>

	        			</c:forEach>
	        		</div>
	        		<div class="content-box4">
	        			<div class="content-price">
							<div class="content-info">
		        				<div>상품 가격</div>
		        				<div>1</div>
		        			</div>
							<div class="content-info">
		        				<div>적립예정마일리지</div>
		        				<div>${o.orderMileage }</div>
		        			</div>
							<div class="content-info">
		        				<c:choose>
		        					<c:when test="${o.orderState eq '픽업준비중' }">
										<div style="color: #cbcbcb;">배송비</div>
		        						<div style="color: #cbcbcb;">0</div>
		        					</c:when>
		        					<c:otherwise>
				        				<div>배송비</div>
				        				<div>3000</div>
		        					</c:otherwise>
		        				</c:choose>
		        			</div>
							<div class="content-info">
		        				<div>최종 결제 금액</div>
		        				<div>${o.orderPrice }원</div>
		        			</div>
	        			</div>
	        		</div>
	        		<div class="content-box5">
	        			<div class="order-cancel">
        					<c:choose>
	        					<c:when test="${o.orderState eq '취소완료' }">
			        				<a class="cancel-confirm">
		        						<div style="text-decoration: none; color: #cbcbcb;">주문 취소</div>
			        				</a>
	        					</c:when>
								<c:otherwise>
									<a style="cursor: pointer;" onclick="orderCancel(${o.orderNo },${reqPage })">
										<div>주문 취소</div>
			        				</a>
								</c:otherwise>
        					</c:choose>
	        			</div>
	        		</div>
	        	</div>
	        </div>
	</div>
	<input type="hidden" name="orderPrice" value="${o.orderPrice }">
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script>
		index=1;
		$(function(){
			let total = $(".selectList a").length;
			for(let i=0; i<total; i++){
				$(".selectList a").eq(i).removeClass("index");
			}
			$(".selectList a").eq(index).addClass("index");
		})	
		
		const orderState = $(".content-title-state").children().last().text();

		function orderCancel(orderNo,reqPage){
			if(confirm("주문을 취소하시겠습니까?")){
				if(orderState == "결제완료" , orderState == "입금대기"){
					location.href="/orderCancel.do?orderNo="+orderNo+"&reqPage="+reqPage;
				}else{
					alert("취소할 수 없습니다.");
				}
			}
		}
		
		// 상품 가격 계산
		const orderPrice = $("[name=orderPrice]").val();
		let price = $(".content-info").eq(3).children().next();
		price.text(addComma(Number(orderPrice-3000))+"원");

		
		function addComma(value){
	         value = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	         return value; 
	    };
	    
		let orderMileage = $(".content-info").eq(4).children().next();
	    orderMileage.text(addComma(orderMileage.text())+"원");
	    
	    let deliveryPrice = $(".content-info").eq(5).children().next();
	    deliveryPrice.text(addComma(deliveryPrice.text())+"원");
	    
	    const finalPrice = $(".content-info").eq(6).children().next();
	    finalPrice.text(addComma(finalPrice.text()));
		
	</script>
</body>
</html>