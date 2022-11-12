<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://js.tosspayments.com/v1"></script>
<link rel="stylesheet" href="/resources/css/font/font.css">
<link rel="stylesheet" href="/resources/css/order/order.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="content">
        <div class="content-wrap">
            <div class="deliver-wrap" style="width: 40%;">
            	<c:choose>
            		<c:when test="${type eq '배달준비중' }">
                		<p>배달내역</p>
                	</c:when>
                	<c:otherwise>
                		<p>픽업내역</p>
                	</c:otherwise>
                </c:choose>
                <div class="deliver-product">
                    <table>
                		<!-- for문 시작 -->
                		<c:forEach items="${list }" var="o">
                        <tr>
                            <td rowspan="2"><img src="${o.productImg }" style="margin: 10px;"></td>
                            <td style="width: 80%;">${o.productName }</td>
                            <td class="product-quan" style="width: 15%;">${o.productStock }</td>
                        </tr>
                        <tr>
                            <td style="color: #cbcbcb; font-size: 0.9em;">${o.productContent }</td>
                            <td class="product-price" style="color: #cbcbcb; font-size: 0.9em;">${o.productPrice }</td>
                        </tr>
                        </c:forEach>
		                <!-- for문 종료 -->
                    </table>
                </div>

                <div class="product-total">
                    <div class="one">
                        <span>상품가격</span>
                        <span class="product-total-price">20000원</span>
                    </div>
                    <div class="two">
                        <span>배송비</span>
                        <span class="product-delivery-price">3000원</span>
                    </div>
                    <div class="three">
                        <span>적립예정마일리지</span>
                        <span class="product-mileage">100원</span>
                    </div>
                    <div class="four">
                        <span>결제금액</span>
                        <span class="product-final-price"></span>
                    </div>
                </div>

            </div>

            <div class="line"></div>
        
            <div class="deliver-addr-wrap">
                <div class="deliver-addr-content" style="width: 40%;">
                    <p>배송지정보</p>
                    <button type="button" class="deliver-addr-update">수정</button>
                    <button type="button" class="deliver-addr-complete" style="display:none;">완료</button>
                    <div class="deliver-addr">
                    	<div class="addr-box">
                        	<input type="text" id="orderName" value="${sessionScope.m.memberName}" readonly="readonly">
                        </div>
                        <div class="addr-box">
                        	<input type="text" id="orderAddr" value="${sessionScope.m.memberAddr}" readonly="readonly">
                        </div>
                        <table>
							<tr>
								<td>
									<input type="text" id="addr" readonly="readonly">
									<button id="address" type="button" onclick="execution_daum_address()">주소검색</button>
									<br>
									<input type="text" id="addr1" readonly="readonly"
									style="margin-top: 5px; width: 385px;" 
									>
									<br>
									<input type="text" id="addr2" readonly="readonly"
									style="margin-top: 5px; width: 385px;" 
									>
									<input type="hidden" name="memberAddr" id="mAddr">
								</td>
							</tr>
                        </table>
                        <div class="addr-box">
                        	<input type="text" id="orderPhone" value="${sessionScope.m.memberPhone}" readonly="readonly">
                        </div>
                    </div>
                </div>
                <div class="pay-method" style="width: 40%;">
                    <p>결제수단선택</p>
                    <div id="pay-kakao">
                    	<div class="pay-card-wrap">
                    		<img src="/resources/img/order/kakaoPay.svg">
                    		<div class="pay-card-comment">카카오페이 간편결제</div>
                    	</div>
                    </div>
                    <div id="pay-card">
                    	<div class="pay-card-wrap">
                    		<img src="/resources/img/order/card.svg">
                    		<div class="pay-card-comment">신용/체크카드</div>
                    	</div>
                    </div>
                    <div id="pay-account">
                    	<div class="pay-card-wrap">
                    		<img src="/resources/img/order/accountPay.svg">
                    		<div class="pay-card-comment">무통장입금</div>
                    	</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" name="memberNo" value="${sessionScope.m.memberNo }">
    <input type="hidden" name="memberId" value="${sessionScope.m.memberId }">
	<script>
	
		function execution_daum_address(){
			new daum.Postcode({
		        oncomplete: function(data) {
		 // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
		        	// 각 주소의 노출 규칙에 따라 주소를 조합한다.
		            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		            var addr = ''; // 주소 변수
		            var extraAddr = ''; // 참고항목 변수
	
		            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                addr = data.roadAddress;
		            } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                addr = data.jibunAddress;
		            }
	
		            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		            if(data.userSelectedType === 'R'){
		                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                    extraAddr += data.bname;
		                }
		                // 건물명이 있고, 공동주택일 경우 추가한다.
		                if(data.buildingName !== '' && data.apartment === 'Y'){
		                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                }
		                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                if(extraAddr !== ''){
		                    extraAddr = ' (' + extraAddr + ')';
		                }
		             	// 주소변수 문자열과 참고항목 문자열 합치기
		                addr += extraAddr;
		            
		            } else {
		            	 addr += '';
		            }
		            // 우편번호와 주소 정보를 해당 필드에 넣는다.
					$("#addr").val(data.zonecode);
					$("#addr1").val(addr);
		            // 커서를 상세주소 필드로 이동한다.
					$("#addr2").attr("readonly",false);
			        $("#addr2").focus();
		        }
		    }).open(); 
		}
		
		// 총 상품들 가격 합
		function price(){
			const productPrice = $(".product-price").text(); // 20000000
			console.log(Number(productPrice).toLocaleString()); // 20,000,000
			$(".product-price").text(Number(productPrice).toLocaleString());
		}
		price();
		
		// 배송지정보
		const update = $(".deliver-addr-update");
		const complete = $(".deliver-addr-complete");
		const inputText = $(".addr-box input");
		update.on("click",function(){
			// 수정 버튼 클릭
			update.hide();
			complete.show();
			$(".addr-box input").removeAttr("readonly");
			inputText.css("text-decoration","underline");
			complete.on("click",function(){
				// 완료 버튼 클릭
				update.show();
				complete.hide();
				$(".addr-box input").attr("readonly","readonly");
				inputText.css("text-decoration","none");
			});
		});


	
		// 가격
		const orderMileage = $("#product-mileage").text();
		
		// 결제 api
    	var clientKey = 'test_ck_YPBal2vxj81njJPnPLe35RQgOAND'
    	var tossPayments = TossPayments(clientKey) // 클라이언트 키로 초기화하기
    	
    	// orderId에 들어갈 현재시간
    	var today = new Date();
    	
    	var year = today.getFullYear();
    	var month = ('0' + (today.getMonth() + 1)).slice(-2);
    	var day = ('0' + today.getDate()).slice(-2);
    	
    	var hours = ('0' + today.getHours()).slice(-2);
    	var minutes = ('0' + today.getMinutes()).slice(-2);
    	var seconds = ('0' + today.getSeconds()).slice(-2);
    	
    	// 현재날짜+현재시간까지
    	var todayString = year+month+day+hours+minutes+seconds;
    	
    	const payKakao = $("#pay-kakao");
    	const payCard = $("#pay-card");
    	const payAccount = $("#pay-account");
    	const memberNo = $("[name=memberNo]").val();
    	const memberId = $("[name=memberId]").val();
    	const storeNo = $("[name=storeNo]").val();

    	// 카카오페이 간편결제
    	payKakao.on("click",function(){
    		$.ajax({
    			  type: "POST",
    			  url: "/kakao.do",
    			  dataType: 'json', 
    			  success: function(){
				    	
				}
    		}); 
    	});
    	
    	// 카드결제
    	payCard.on("click", function(){
    		if(inputText.prop('readonly') == true){
	    		// 배송지 정보
	    		const orderName = $("#orderName").val();
	    		const orderAddr = $("#orderAddr").val();
	    		const orderPhone = $("#orderPhone").val();
	
	    		$.ajax({
	    			  type: "POST",
	    			  url: "/insertOrder.do",
	    			  data: 
	    			  	{
	    				  	memberNo:memberNo,
	    					orderName:orderName,
	    					orderAddr:orderAddr,
	    					orderPhone:orderPhone,
	    					orderMileage:20000
	    					
	    			  	},
	    			  success: function(){
					    	tossPayments.requestPayment('카드', { // 결제 수단 파라미터
					    		  // 결제 정보 파라미터
					    		  amount: 222,
					    		  orderId: memberId+'-'+todayString,
					    		  orderName: '토스 티셔츠 외 2건',
					    		  customerName: orderName,
					    		  successUrl: 'http://localhost:8888/orderCard.do',
					    		  failUrl: 'http://localhost:8888/fail.do'
					    	});
	    			  }  
	    		});  
    		}else{
    			alert("배송지 정보 수정을 완료해주세요.");
    		}
    	});
    	
    		
    	
    	// 무통장결제
    	payAccount.on("click", function(){
    		if(inputText.prop('readonly') == true){    		
	    		// 배송지 정보
	    		const orderName = $("#orderName").val();
	    		const orderAddr = $("#orderAddr").val();
	    		const orderPhone = $("#orderPhone").val();
	    		
	    		$.ajax({
	    			  type: "POST",
	    			  url: "/insertOrder.do",
	    			  data: 
	    			  	{
	    				  	memberNo:memberNo,
	    					orderName:orderName,
	    					orderAddr:orderAddr,
	    					orderPhone:orderPhone,
	    					orderMileage:20000
	    					
	    			  	},
	    			  success: function(){
					    	tossPayments.requestPayment('가상계좌', { // 결제 수단 파라미터
					    		  // 결제 정보 파라미터
					    		  amount: 222,
					    		  orderId: memberId+'-'+todayString,
					    		  orderName: '첫번째상품이름'+' 외 '+'2'+'건',
					    		  customerName: orderName,
					    		  successUrl: 'http://localhost:8888/orderAccount.do',
					    		  failUrl: 'http://localhost:8888/fail.do'
					    	});
	    			  }  
	    		});
    		}else{
    			alert("배송지 정보 수정을 완료해주세요.");
    		}
    	});
    	
    	
    	
    	
	</script>
    
   	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>