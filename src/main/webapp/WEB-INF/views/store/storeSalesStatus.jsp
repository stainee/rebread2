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
<link rel="stylesheet" href="resources/css/font/font.css">
<link rel="stylesheet" href="/resources/css/common/managetemplate.css">
<link rel="stylesheet" href="/resources/css/store/ceoStoreInfo.css">
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
                <div class="navi_box">가게 정보</div>
                
                <!-- 매출 현황 -->
                <c:forEach items="${list}" var="s">
                <div class="store_sales_info_wrapper">
                    <div class="store_sales_info_wrap_box">
                        <div class="store_info_left">
                            <div class="store_img">
                                <img src="resources/img/store/${s.storeImg }">
                            </div>
                            <div class="store_name">
                            	<input type="text" name="storeName" value="${s.storeName }">
                            </div>
                        </div>
                        
                        
                        <div class="store_info_right">
                            <div class="store_info_form">
                                <div class="store_status_title">일 매출</div>
                                <div class="store_sales_info_content">
                                	<input type="text" name="today" class="today" value="${s.today }" dir="rtl">원
                                </div>
                            </div>
                            <div class="store_info_form">
                                <div class="store_status_title">월 매출</div>
                                <div class="store_sales_info_content">
                                	<input type="text" name="month" class="month" value="${s.month }" dir="rtl">원
                                </div>
                            </div>
                            <div class="store_info_form">
                                <div class="store_status_title">연 매출</div>
                                <div class="store_sales_info_content">
                                	<input type="text" name="years" class="years" value="${s.years }" dir="rtl">원
                                </div>
                                <button class="store_sale_btn">돌아가기</button>
                            </div>
                        </div>
                    </div>
                </div>
                </c:forEach>
                
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
<script>
function addComma(value){
		value = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return value;
};

const todayVal = addComma($(".today").val());
const monthVal = addComma($(".month").val());
const yearsVal = addComma($(".years").val());
$(".today").val(todayVal); 
$(".month").val(monthVal);
$(".years").val(yearsVal);



index=1;
$(function(){
	let total = $(".selectList a").length;
	for(let i=0; i<total; i++){
		$(".selectList a").eq(i).removeClass("index");
	}
	$(".selectList a").eq(index).addClass("index");
})
	

$(".navi_btn").on("click",function(){
	$(".navi_btn").css("display","none");
	$(".navi_box").text("가게 등록");
	$(".store_insert_wrapper").css("display","block");
	$(".store_info_wrapper").css("display","none");
	$(".navi_box_footer").css("display","none");
});

$(".store_edit_btn").on("click",function(){
	location.href="/storeInfoUpdate.do?storeNo="+$(this).prev().val();
});

$(".store_sale_btn").on("click",function(){
	location.href="/ceoStoreInfo.do?storeNo="+$(this).prev().val();
});

$(function(){
    $(".store_sales_info_wrapper").slice(0, 3).show(); // 초기갯수
    $(".store_sales_info_wrapper:nth-child(-n+4)").css("display","flex");
    $(".more_btn").click(function(e){ // 클릭시 more
        e.preventDefault();
        $(".store_sales_info_wrapper:hidden").slice(0, 3).show().css("display","flex"); // 클릭시 more 갯수 지정
        console.log($(".store_sales_info_wrapper:hidden").length); // 남아있는 컨텐츠 박스 갯수 출력
    });
});
</script>
</html>