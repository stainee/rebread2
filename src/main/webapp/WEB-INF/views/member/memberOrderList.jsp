<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/common/managetemplate.css">
<link rel="stylesheet" href="/resources/css/member/memberOrderList.css">
<link rel="stylesheet" href="/resources/css/font/font.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-content" style="height: 800px;">
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
	
	        <div class="right_container" style="min-height: 260px;">
	            <div class="content_container">
	            	<c:choose>
	            		<c:when test="${empty list }">
	            			<div class="order-empty" style="line-height: 200px;">주문내역이 아직 없습니다.</div>
	            		</c:when>
	            		<c:otherwise>
		            		<c:forEach items="${list }" var="o">
				           		<a href="/orderDetail.do?orderNo=${o.orderNo }&reqPage=${reqPage}">
									<div class="content-box">
					            		<div class="content-img"><img src="/resources/img/common/logo.png"></div>
					            		<c:choose>
					            			<c:when test="${o.orderState eq '취소완료' }">
							            		<div class="content-wrap" style="text-decoration: line-through; color: #cbcbcb;">
							            			<div class="content-status-date">
								            			<div class="deliver-status">${o.orderState }</div>
								            			<span>ㅣ</span>
								            			<div class="order-date">${o.orderDate }</div>
							            			</div>
							            			<div class="content-product-name">빵이름상품이름</div>            		
							            		</div>
						            		</c:when>
						            		<c:otherwise>
							            		<div class="content-wrap">
							            			<div class="content-status-date">
								            			<div class="deliver-status">${o.orderState }</div>
								            			<span>ㅣ</span>
								            			<div class="order-date">${o.orderDate }</div>
							            			</div>
							            			<div class="content-product-name">빵이름상품이름</div>            		
							            		</div>
						            		</c:otherwise>
					            		</c:choose>
					            	</div>
				            	</a>
		            		</c:forEach>
	            		</c:otherwise>
	            	</c:choose>
	            </div>
	            <div class="order-page-wrap">
		            <div class="order-page">${pageNavi }</div>
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
		});
	</script>
</body>
</html>