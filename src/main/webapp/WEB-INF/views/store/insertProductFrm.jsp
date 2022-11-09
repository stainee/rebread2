<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="/resources/css/common/default.css">
<link rel="stylesheet" href="/resources/css/common/insertproduct.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
	<div class="top">
		<img src="/resources/img/common/logo2.png">
	</div>
	<div class="total_wrapper">
		<div class="left_container">
			<div class="memberInfo">
				<p>[${storeName }]</p>
				<p><a href="/detailStore.do?storeNo=${storeNo}">${storeAddr}</a></p>
			</div>
		</div>

		<div class="right_container">
			<div class="content-top"><h2>상품 등록</h3></div>
			<div class="content_container">
				<form action="/insertProduct.do" method="post" enctype="multipart/form-data">
					<div id="product-viewer">
						<img id="img-view" width="350px">
					</div>
					<table border="1">
						<tr>
							<th>상품명</th>
							<td><input type="text" name="productName"></td>
						</tr>
						<tr>
							<th>판매가격</th>
							<td><input type="text" name="productPrice"></td>
						</tr>
						<tr>
							<th>수량</th>	
							<td><input type="text" name="productStock"></td>
						</tr>
						
						<tr>
							<th>유통기한</th>
							<td><input type="date" name="productDate"></td>	
						</tr>
						
						<tr>
							<th>상품이미지</th>
							<td><input type="file" name="upFile" accept="image/*" onchange="loadImg(this);"></td>
						</tr>
						<tr>
							<th>할인율</th>
							<td><input type="text" name="productSale"></td>
						</tr>
						<tr>
							<th>빵종류</th>
							<td>
								<select name="productType">
									<option value="0">로스빵</option>
									<option value="1">일반빵</option>
								</select>
								<input type="hidden" name="storeNo" value="${storeNo}">
							</td>
						</tr>	
						<tr>
							<th>상품정보</th>
							<td><textarea name="productContent" style="resize: none;"></textarea></td>
						</tr>
						<tr>
							<th colspan="2">
								<input type="submit" class="btn bc4 bs3" value="빵등록하기">
								<!-- <a href="/detailStore.do?storeNo=${storeNo}" class="btn bc4 bs3">취소하기</a> -->
							</th>
							
						</tr>
					</table>

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
	</script>
</body>
	
</html>