<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/common/managetemplate.css">
<link rel="stylesheet" href="/resources/css/font/font.css">
<link rel="stylesheet" href="/resources/css/member/memberReviewDetail.css">
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
        						<a href="/memberReviewList.do?reviewWriter=${sessionScope.m.memberId }&reqPage=${reqPage}"><img src="/resources/img/order/화살표.svg"></a>
        					</div>
        					<div>
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
        			</div>
        			<div class="content-title-date">${r.reviewDate }</div>
        		</div>
        		        		
        		<div class="content-box3">
        			<div class="content-product">
        				<div class="content-img-box">
        					<div class="content-img"><img src="/resources/img/common/logo.png"></div>
        				</div>
        				<div class="content-img-box">
							<div style="font-size: 1.5em; color: #785c37;">${storeName }</div>
        				</div>
        			</div>
        		</div>
        		
        		<div class="content-box2">
        			<div class="content-addr">리뷰 내용</div>
        			<div class="content-info">
        				<div>${r.reviewContent }</div>
        			</div>
        		</div>


        		<div class="content-box5">
        			<div class="review-cancel">
						<a href="/memberDeleteReview.do?reviewNo=${r.reviewNo }&reviewWriter=${r.reviewWriter }&reqPage=${reqPage}">
							<div>삭제하기</div>
	       				</a>
        			</div>
        		</div>
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