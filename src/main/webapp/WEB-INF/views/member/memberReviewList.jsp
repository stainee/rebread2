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
<link rel="stylesheet" href="/resources/css/member/memberReview.css">
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

        <div class="right_container" style="min-height: 260px;">
            <div class="content_container">
            	<c:choose>
            		<c:when test="${empty list }">
            			<div class="review-empty" style="line-height: 200px;">작성한 리뷰가 아직 없습니다.</div>
            		</c:when>
            		<c:otherwise>
		            	<c:forEach items="${list }" var="r">
			           		<a href="/memberReviewDetail.do?reviewNo=${r.reviewNo }&reqPage=${reqPage}">
								<div class="content-box">
				            		<div class="content-img"><img src="/resources/upload/review/${r.reviewImg }"></div>
				            		<div class="content-wrap">
				            			<div class="content-status-date">
					            			<div class="deliver-status">
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
					            			<span>ㅣ</span>
					            			<div class="order-date">${r.reviewDate }</div>
				            			</div>
				            			<div class="content-product-name">${r.reviewContent }</div>   		
				            		</div>
				            	</div>
			            	</a>
		            	</c:forEach>
            		</c:otherwise>
            	</c:choose>
            </div>
            <div class="review-page-wrap">
	            <div class="review-page">${pageNavi }</div>
			</div>
        </div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script>
		index=2;
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