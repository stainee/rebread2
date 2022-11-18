<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지-가게 정보</title>
<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
</head>
<link rel="stylesheet" href="/resources/css/font/font.css">
<link rel="stylesheet" href="/resources/css/common/managetemplate.css">
<link rel="stylesheet" href="/resources/css/store/ceoStoreInfo.css">
<link rel="stylesheet" href="/resources/css/store/ceoStoreSalesInfo.css">

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="total_wrapper">
        <div class="left_container">
            <div class="memberInfo">
                <p>[판매자]</p>
                <p>${sessionScope.m.memberName }님</p>
            </div>
            <div class="selectList">
                <ul>
                	<li><a href="/ceoMain.do">내정보</a></li> 
                    <li><a href="/ceoStoreInfo.do">가게 정보</a></li>
                    <li><a href="/ceoStoreSalesInfo.do">상품 판매 정보</a></li>
                </ul>
            </div>
        </div>

        <div class="right_container">
            <div class="content_container">
                <div class="navi_box">상품 판매 정보
                    <select class="store_sales_info_select_box" name="orderState">
                    	<option value="" disabled selected hidden>선택해주세요</option>
                        <option value="전체보기">전체보기</option>
                        <option value="결제완료">결제완료</option>
                        <option value="배송준비중">배송준비중</option>
				        <option value="배송중">배송중</option>
				        <option value="배송완료">배송완료</option>
				        <option value="픽업준비중">픽업준비중</option>
				        <option value="픽업완료">픽업완료</option>
                    </select>
                </div>
             		<form action="/salesInfoUpdate.do" method="post">
                    <c:forEach items="${list}" var="o">
                    <div class="store_sales_info_wrapper">
                        <div class="store_info_left">
                            <div class="store_img">
                                <img src="resources/img/store/${o.orderProductImg }">
                            </div>
                            <div class="store_name">주문번호 : ${o.orderNo }</div>
                        </div>
                        <div class="product_info_right">
                            <div class="product_info_form">
                                <div class="store_info_status">
                                    <select class="store_sales_info" name="orderState">
                                        <option value="" selected hidden>${o.orderState }</option>
				                        <option value="결제완료">결제완료</option>
                                        <option value="배송준비중">배송준비중</option>
				                        <option value="배송중">배송중</option>
				                        <option value="배송완료">배송완료</option>
				                        <option value="픽업준비중">픽업준비중</option>
				                        <option value="픽업완료">픽업완료</option>
                                    </select>
                                </div>
                                <div class="store_info_status_btn_box">
		                            <input type="hidden" name="orderNo" value="${o.orderNo }">
                                    <button type="submit" class="store_info_status_btn">변경</button>
                                </div>
                                <div class="store_info_date">구매 일자 : ${o.orderDate }</div>
                            </div>
                            <div class="product_info_form">
                                <div class="product_info_content">주문자 : ${o.orderName }</div>
                            </div>
                            <div class="product_info_form">
                                <div class="product_info_content">주문자 번호 : ${o.orderPhone }</div>
                            </div>
                            <div class="product_info_form">
                                <div class="product_info_content">배송지 : ${o.orderAddr }</div>
                            </div>
                            <div class="product_info_form">
                                <div class="product_info_content">판매 가게 : ${o.storeName }</div>
                            </div>
                        </div>
                        </div>
                        </c:forEach>
                 				</form>
                </div>
                
                <div class="more_btn_box">
                	<button class="more_btn">더보기</button>
            	</div>
            	<div class="more_end_box">마지막 페이지입니다</div>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
<script>
index=2;
$(function(){
	let total = $(".selectList a").length;
	for(let i=0; i<total; i++){
		$(".selectList a").eq(i).removeClass("index");
	}
	$(".selectList a").eq(index).addClass("index");
})
	
	$(".store_info_status_btn").on("click",function(){
		const orderNo = $(this).prev().prev().val();
	});
	
	$(".store_sales_info_select_box").on("change", function(){
		const orderState = $(this).val();
		location.href="/salesInfoSelect.do?orderState="+orderState;
		if(orderState == "전체보기"){
			location.href="/ceoStoreSalesInfo.do";
		}
	});
	$(function(){
	    $(".store_sales_info_wrapper").slice(0, 3).show(); // 초기갯수
	    $(".store_sales_info_wrapper:nth-child(-n+4)").css("display","flex");
	    $(".more_btn").click(function(e){ // 클릭시 more
	        e.preventDefault();
	        $(".store_sales_info_wrapper:hidden").slice(0, 5).show().css("display","flex"); // 클릭시 more 갯수 지정
	        console.log($(".store_sales_info_wrapper:hidden").length); // 남아있는 컨텐츠 박스 갯수 출력
	        
	     // 더보여줄 것이 없으면 더보기 버튼을 숨기고 "마지막페이지입니다" text 출력
	        if($(".store_sales_info_wrapper:hidden").length == 0){ 
	        	$(".more_btn_box").css("display","none");
	        	$(".more_end_box").css("display","block");
	        }
	    });
	});
	
	
</script>
</html>