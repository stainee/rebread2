<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지-가게 정보</title>
</head>
<link rel="stylesheet" href="resources/css/font/font.css">
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
                    <select class="sales_info">
                        <option value="delivery_processed">배송 준비</option>
                        <option value="delivery">배송 중</option>
                        <option value="delivery_complete">배송 완료</option>
                        <option value="pickup_processed">픽업 준비</option>
                        <option value="pickup_complete">픽업 완료</option>
                    </select>
                </div>
                <div class="store_info_wrapper">
                    <div class="store_info_wrap_box">
                        <div class="store_info_left">
                            <div class="store_img">
                                <img src="resources/img/member/testImg.jfif">
                            </div>
                            <div class="store_name">주문자 명 : 최선우</div>
                        </div>
                        <div class="product_info_right">
                            <div class="product_info_form">
                                <div class="store_info_status">
                                    <select class="store_sales_info">
                                        <option value="delivery_processed">배송 준비</option>
				                        <option value="delivery">배송 중</option>
				                        <option value="delivery_complete">배송 완료</option>
				                        <option value="pickup_processed">픽업 준비</option>
				                        <option value="pickup_complete">픽업 완료</option>
                                    </select>
                                </div>
                                <div class="store_info_status_btn_box">
                                    <button class="store_info_status_btn">변경</button>
                                </div>
                                <div class="store_info_date">구매 일자 : 2022-10-25</div>
                            </div>
                            <div class="product_info_form">
                                <div class="product_info_content">상품 이름 : 맛있는 빵</div>
                            </div>
                            <div class="product_info_form">
                                <div class="product_info_content">배송지 : 당산 KH정보교육원 A Class</div>
                            </div>
                            <div class="product_info_form">
                                <div class="product_info_content">주문자 번호 : 010-8318-1206</div>
                            </div>
                        </div>
                    </div>
                    <div class="store_info_wrap_box">
                        <div class="store_info_left">
                            <div class="store_img">
								<img src="resources/img/member/testImg.jfif">
                            </div>
                            <div class="store_name">주문자 명 : 최선우</div>
                        </div>
                        <div class="product_info_right">
                            <div class="product_info_form">
                                <div class="store_info_status">
                                    <select class="store_sales_info">
                                        <option value="">배송 준비</option>
                                        <option value="">배송 중</option>
                                        <option value="">배송 완료</option>
                                        <option value="">픽업 준비</option>
                                        <option value="">픽업 완료</option>
                                    </select>
                                </div>
                                <div class="store_info_status_btn_box">
                                    <button class="store_info_status_btn">변경</button>
                                </div>
                                <div class="store_info_date">구매 일자 : 2022-10-25</div>
                            </div>
                            <div class="product_info_form">
                                <div class="product_info_content">상품 이름 : 맛있는 빵</div>
                            </div>
                            <div class="product_info_form">
                                <div class="product_info_content">배송지 : 당산 KH정보교육원 A Class</div>
                            </div>
                            <div class="product_info_form">
                                <div class="product_info_content">주문자 번호 : 010-8318-1206</div>
                            </div>
                        </div>
                    </div>
                    <div class="store_info_wrap_box">
                        <div class="store_info_left">
                            <div class="store_img">
                                <img src="resources/img/member/testImg.jfif">
                            </div>
                            <div class="store_name">주문자 명 : 최선우</div>
                        </div>
                        <div class="product_info_right">
                            <div class="product_info_form">
                                <div class="store_info_status">
                                    <select class="store_sales_info">
                                        <option value="">배송 준비</option>
                                        <option value="">배송 중</option>
                                        <option value="">배송 완료</option>
                                        <option value="">픽업 준비</option>
                                        <option value="">픽업 완료</option>
                                    </select>
                                </div>
                                <div class="store_info_status_btn_box">
                                    <button class="store_info_status_btn">변경</button>
                                </div>
                                <div class="store_info_date">구매 일자 : 2022-10-25</div>
                            </div>
                            <div class="product_info_form">
                                <div class="product_info_content">상품 이름 : 맛있는 빵</div>
                            </div>
                            <div class="product_info_form">
                                <div class="product_info_content">배송지 : 당산 KH정보교육원 A Class</div>
                            </div>
                            <div class="product_info_form">
                                <div class="product_info_content">주문자 번호 : 010-8318-1206</div>
                            </div>
                        </div>
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
</script>
</html>