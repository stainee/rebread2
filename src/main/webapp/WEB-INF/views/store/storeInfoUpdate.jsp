<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지-가게 정보 수정</title>
<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
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
	                <form action="/storeInfoUpdateSuccess.do" method="post" enctype="multipart/form-data">
                	<div class="store_update_form">
                		<div class="store_update_title">매장명</div>
                		<div class="store_update_input">
                			<input type="text" name="storeName" value="${s.storeName }" required>
                		</div>
	                <input type="hidden" name="storeNo" value="${s.storeNo }">
	                <input type="hidden" name="memberNo" value="${sessionScope.m.memberNo }">
                	</div>
                	<div class="store_update_form">
                		<div class="store_update_title">매장 주소</div>
                		<div class="store_update_input">
                			<input type="text" name="storeAddr" value="${s.storeAddr }" required>
                		</div>
                	</div>
                	<div class="store_update_form">
                		<div class="store_update_title">매장 전화번호</div>
                		<div class="store_update_input">
                			<input type="text" name="storePhone" value="${s.storePhone }" required>
                		</div>
                	</div>
                	
                	
                	<div class="store_update_form">
                		<div class="store_update_title">매장 이미지</div>
                		<div class="store_update_input" style="display: flex; justify-content: space-between;">
                			<input type="hidden" name="storeNo" value="${s.storeNo }">
                			<input type="hidden" name="status" value="stay">
							<c:choose>
							<c:when test="${not empty s.storeImg }"> <!-- 이미지가 있는 상태면.. -->
								<span class="delFile">${s.storeImg }</span><button type="button" class="delFile" onchange="loadImg(this);">파일 선택</button>
								<input type="file" name="upFile" accept="image/*" style="display:none;">
								<input type="hidden" name="oldImg" value="${s.storeImg }">	   		
                			</c:when>
                			<c:otherwise> <!-- 이미지가 없는 상태면.. -->
                				<input type="file" name="upFile" accept="image/*" value="${s.storeImg }" onchange="loadImg(this);" required>
                			</c:otherwise>
                			</c:choose>
                		</div>
                	</div>
                	
                	
                	<div class="store_update_form">
                		<div class="store_update_title">계좌 번호</div>
                		<div class="store_update_input">
                			<input type="text" name="storeAccount" value="${s.storeAccount }" required>
                		</div>
                	</div>
                	<div class="store_update_form">
                		<div class="store_update_title">사업자 번호</div>
                		<div class="store_update_input">
                			<input type="text" name="storeRegistNum" value="${s.storeRegistNum }" required>
                		</div>
                	</div>
                	<div class="store_update_form">
                		<div class="store_update_title">오픈 시간</div>
                		<div class="store_update_input">
                			<input type="text" name="openTime" value="${s.openTime }" required>
                		</div>
                	</div>
                	<div class="store_update_form">
                		<div class="store_update_title">마감 시간</div>
                		<div class="store_update_input">
                			<input type="text" name="closeTime" value="${s.closeTime }" required>
                		</div>
                	</div>
                	<div class="store_update_form">
                		<div class="store_update_title">매장 정보</div>
                		<div class="store_update_input">
                			<textarea name="storeContent" required>${s.storeContent }</textarea>
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
	index=1;
	$(function(){
		let total = $(".selectList a").length;
		for(let i=0; i<total; i++){
			$(".selectList a").eq(i).removeClass("index");
		}
		$(".selectList a").eq(index).addClass("index");
	})

	$("button.delFile").on("click",function(){
		$(".delFile").hide();
		$(this).next().show();
		$("[name=status]").val("delete");
	});
</script>
</html>