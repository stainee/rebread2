<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/common/default.css">
<link rel="stylesheet" href="/resources/css/common/insertproduct.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>!!Rebread UPdate!!</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="total_wrapper">
		<div class="left_container">
			<div class="memberInfo">
				<p>[${storeName }]</p>
				<p><a href="/detailStore.do?storeNo=${storeNo}">${storeAddr}</a></p>
			</div>
		</div>

		<div class="right_container">
			<div class="content-top"><h2>상품 수정</h3></div>
			<div class="content_container">
				<form action="/updateProduct.do" method="post" enctype="multipart/form-data">
					<div id="product-viewer">
						<img id="img-view" width="200px" height="200px" src="/resources/upload/product/${p.productImg }">
						<span>상품 썸네일</span>
					</div>
					<div class="product-box">
					<input type="hidden" name="memberNo" value="${sessionScope.m.memberNo}">
					<table>
						<tr>
							<th>상품명</th>
							<td><input type="text" name="productName" required="required" maxlength=16 value="${p.productName}" ></td>
						</tr>
						<tr>
							<th>판매가격</th>
							<td><input type="text" name="productPrice"  required="required" placeholder="숫자만 입력해주세요" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" 
							value="${p.productPrice }"></td>
						</tr>
						<tr>
							<th>수량</th>	
							<td><input type="text" name="productStock" required="required" placeholder="숫자만 입력해주세요" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="2" value="${p.productStock }"></td>
						</tr>
						
						<tr>
							<th>유통기한</th>
							<td><input type="date" name="productDate" min="2022-11-17" max="2022-11-24" required="required" value="${p.productDate }"></td>	
						</tr>
						<tr>
							<th>상품이미지</th>
							<td>
								<input type="hidden" name="productNo" value="${p.productNo }">
								<input type="hidden" name="status" value="stay">
								<input type="hidden" name="storeNo" value="${storeNo }">
								<c:choose>
								<c:when test="${not empty p.productImg }">
									<span class="delFile">${p.productImg }</span><button type="button" class="btn bc4 delFile">삭제</button>
									<input type="file" name="upFile" accept="image/*" onchange="loadImg(this);" style="display:none;">
									<input type="hidden" name="oldImg" value="${p.productImg }">							
								</c:when>
								<c:otherwise>
									<input type="file" name="upFile" accept="image/*" onchange="loadImg(this);" value="${p.productImg }">
								</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th>할인율</th>
							<td><input type="text" name="productSale" placeholder="숫자만 입력해주세요" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"
							maxlength=2 value="${p.productSale }"></td>
						</tr>
						<tr>
							<th>빵종류</th>
							<td class="select">
									<input type="radio" id="select" name="productType" value="0" required="required"><label for="select">로스빵</label>
     								<input type="radio" id="select2" name="productType" value="1" required="required"><label for="select2">일반빵</label>
								<input type="hidden" name="storeNo" value="${storeNo}">
							</td>
						</tr>	
						<tr>
							<th>상품정보</th>
							<td><textarea name="productContent" maxlength="100" required="required" placeholder="100자 이내로 상품정보를 입력해주세요." style="resize: none;">${p.productContent }</textarea></td>
						</tr>
						<tr>
							<th colspan="2">
								<input type="submit" class="btn bc4" value="수정하기">
								<!-- <a href="/detailStore.do?storeNo=${storeNo}" class="btn bc4 bs3">취소하기</a> -->
							</th>
							
						</tr>
					</table>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script>
	function loadImg(f){
	    console.log(f.files);
	    
	    if(f.files.length !=0 && f.files[0] != 0 ){
	        const reader = new FileReader(); // 파일 정보를 읽어올 수 있는 객체
	        reader.readAsDataURL(f.files[0]);//선택한 파일 정보 읽어옴
	        //파일리더가 파일을 다 읽어오면 동작할 함수 작성
	        reader.onload = function(e){
	            $("#img-view").attr("src",e.target.result);
	        }
	    }else{
	        $("#img-view").attr("src","");
	    }
	}
	
	$("button.delFile").on("click",function(){
			$(".delFile").hide();
			$("#img-view").attr("src","");
			$(this).next().show();
			$("[name=status]").val("delete");
	});
	</script>
</body>
	
</html>