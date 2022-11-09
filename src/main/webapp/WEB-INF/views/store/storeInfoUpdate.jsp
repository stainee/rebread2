<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지-가게 정보 수정</title>
</head>
<link rel="stylesheet" href="resources/css/font/font.css">
<link rel="stylesheet" href="/resources/css/common/managetemplate.css">
<link rel="stylesheet" href="/resources/css/store/storeInfoUpdate.css">
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
                <div class="navi_box">가게 정보 수정</div>
                <!-- 가게 수정창을 띄우는 div -->
                <div class="store_update_wrapper">
	                <form action="/storeInfoUpdateSuccess.do" method="post">
                	<div class="store_update_form">
                		<div class="store_update_title">매장명</div>
                		<div class="store_update_input">
                			<input type="text" name="storeName" value="${s.storeName }">
                		</div>
	                <input type="hidden" name="storeNo" value="${s.storeNo }">
	                <input type="hidden" name="memberNo" value="${sessionScope.m.memberNo }">
                	</div>
                	<div class="store_update_form">
                		<div class="store_update_title">매장 주소</div>
                		<div class="store_update_input">
                			<input type="text" name="storeAddr" value="${s.storeAddr }">
                		</div>
                	</div>
                	<div class="store_update_form">
                		<div class="store_update_title">매장 전화번호</div>
                		<div class="store_update_input">
                			<input type="text" name="storePhone" value="${s.storePhone }">
                		</div>
                	</div>
                	<div class="store_update_form">
                		<div class="store_update_title">매장 이미지</div>
                		<div class="store_update_input">
                			<input type="text" name="storeImg" value="${s.storeImg }">
                		</div>
                	</div>
                	<div class="store_update_form">
                		<div class="store_update_title">계좌 번호</div>
                		<div class="store_update_input">
                			<input type="text" name="storeRegistNum" value="${s.storeRegistNum }">
                		</div>
                	</div>
                	<div class="store_update_form">
                		<div class="store_update_title">사업자 번호</div>
                		<div class="store_update_input">
                			<input type="text" name="storeAccount" value="${s.storeAccount }">
                		</div>
                	</div>
                	<div class="store_update_form">
                		<div class="store_update_title">오픈 시간</div>
                		<div class="store_update_input">
                			<input type="text" name="openTime" value="${s.openTime }">
                		</div>
                	</div>
                	<div class="store_update_form">
                		<div class="store_update_title">마감 시간</div>
                		<div class="store_update_input">
                			<input type="text" name="closeTime" value="${s.closeTime }">
                		</div>
                	</div>
                	<div class="store_update_form">
                		<div class="store_update_title">매장 정보</div>
                		<div class="store_update_input">
                			<textarea name="storeContent">${s.storeContent }</textarea>
                		</div>
                	</div>
                	<div class="store_update_btn_box">
                		<button type="submit" class="store_update_btn" >가게 정보 수정</button>
                	</div>
                	</form>
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
});
selectList.eq(0).click();

</script>
</html>