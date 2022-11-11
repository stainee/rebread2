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
	                    <li><a href="/memberReviewList.do?memberNo=${sessionScope.m.memberNo }&reqPage=1">내 등록 리뷰</a></li>
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
	        			<div class="content-product">
	        				<div class="content-img-box">
	        					<div class="content-img"><img src="/resources/img/common/logo.png"></div>
	        					<div class="content-img-info">
	        						<div>빵이름제목</div>
	        						<div>1개</div>
	        					</div>
	        				</div>
	        			</div>
	        		</div>
	        		<div class="content-box4">
	        			<div class="content-price">
							<div class="content-info">
		        				<div>상품 가격</div>
		        				<div>10,000원</div>
		        			</div>
							<div class="content-info">
		        				<div>적립예정마일리지</div>
		        				<div>100원</div>
		        			</div>
							<div class="content-info">
		        				<div>배송비</div>
		        				<div>3,000원</div>
		        			</div>
							<div class="content-info">
		        				<div>최종 결제 금액</div>
		        				<div>13,000원</div>
		        			</div>
	        			</div>
	        		</div>
	        		<div class="content-box5">
	        			<div class="order-cancel">
        					<c:choose>
	        					<c:when test="${o.orderState eq '취소완료' }">
			        				<a class="cancel-confirm">
		        						<div style="text-decoration: line-through; color: #cbcbcb;">주문 취소</div>
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
		console.log(orderState);
		console.log(orderState);
		console.log(orderState);
		function orderCancel(orderNo,reqPage){
			if(confirm("주문을 취소하시겠습니까?")){
				if(orderState == "결제완료"){
					location.href="/orderCancel.do?orderNo="+orderNo+"&reqPage="+reqPage;
				}else{
					alert("취소할 수 없습니다.");
				}
			}
		}
	</script>
</body>
</html>