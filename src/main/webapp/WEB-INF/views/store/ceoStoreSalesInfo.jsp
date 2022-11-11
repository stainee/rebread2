<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지-가게 정보</title>
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
                        <option value="배송준비">배송준비</option>
				        <option value="배송중">배송중</option>
				        <option value="배송완료">배송완료</option>
				        <option value="픽업준비">픽업준비</option>
				        <option value="픽업완료">픽업완료</option>
                    </select>
                </div>
                <div class="store_info_wrapper">
                    <c:forEach items="${list}" var="o">
                    <div class="store_info_wrap_box">
                        <div class="store_info_left">
                            <div class="store_img">
                                <img src="resources/img/member/testImg.jfif">
                            </div>
                  			<form action="/salesInfoUpdate.do" method="post">
                            <div class="store_name">주문번호 : ${o.orderNo }</div>
                        </div>
                        <div class="product_info_right">
                            <div class="product_info_form">
                                <div class="store_info_status">
                                    <select class="store_sales_info" name="orderState">
                                        <option value="" selected hidden>${o.orderState }</option>
				                        <option value="결제완료">결제완료</option>
                                        <option value="배송준비">배송준비</option>
				                        <option value="배송중">배송중</option>
				                        <option value="배송완료">배송완료</option>
				                        <option value="픽업준비">픽업준비</option>
				                        <option value="픽업완료">픽업완료</option>
                                    </select>
                                </div>
                                <div class="store_info_status_btn_box">
		                            <input type="hidden" name="orderNo" value="${o.orderNo }">
                                    <button type="submit" class="store_info_status_btn">변경</button>
                                </div>
                 				</form>
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
                    </div>
                </div>
                
                <div class="navi_box_footer">
                    <ul class="pagination">
                        <li class="page-item">
                            <a class="page-link" href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <li class="page-item"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
<script>
	const selectList = $(".selectList li");
	selectList.on("click",function(e){
		selectList.css("background-color","#f5f2f3").css("color","gray");
		$(this).css("background-color","lightgray").css("color","black");
		
		const index = selectList.index(this);
		
		$(".content_container").hide();
		$(".content_container").eq(index).fadeIn(0.6*1000);
		e.stopPropagation();
	});
	$(this).eq(2).click();
	
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
	
	
	
</script>
</html>