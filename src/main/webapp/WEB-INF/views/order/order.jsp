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
<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
</head>
<body>
   <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="content">
        <div class="content-wrap">
            <div class="deliver-wrap" style="width: 40%;">
               <c:choose>
                  <c:when test="${type eq '결제완료' }">
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
                      <input type="hidden" name="productNo" value="${o.productNo }">
                        <tr>
                            <td rowspan="2"><img src="${o.productImg }" style="margin: 10px;"></td> 
                            <td class="product-name" style="width: 80%;">${o.productName }</td>
                            <td class="product-quan" style="width: 15%;">${o.productStock }</td><td>개</td>
                        <tr>
                            <td style="color: #cbcbcb; font-size: 0.9em;">${o.productContent }</td>
                            <td class="product-price" style="color: #cbcbcb; font-size: 0.9em;">${o.productPrice }</td><td style="color: #cbcbcb; font-size: 0.9em;">원</td>
                        </tr>
                      </c:forEach>
                      <!-- for문 종료 -->
                    </table>
                </div>

                <div class="product-total">
                    <div class="one">
                        <span>상품가격</span>
                        <span class="product-total-price"></span>
                    </div>
                    <div class="two">
                        <span>배송비</span>
                        <c:choose>
                           <c:when test="${type eq '결제완료' }">
                              <span class="product-delivery-price">3000</span>
                           </c:when>
	                     <c:otherwise>
	                        <span class="product-delivery-price">0</span>
	                     </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="three">
                        <span>적립예정마일리지</span>
                        <span class="product-mileage"></span>
                    </div>
                    <div class="four">
                        <span>결제금액</span>
                        <span class="product-final-price"></span>
                    </div>
                </div>

            </div>

            <div class="line"></div>
        
            <div class="deliver-addr-wrap">
				<c:choose>
					<c:when test="${type eq '결제완료' }">
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
		                        <div class="addr-box">
		                           <input type="text" id="orderPhone" value="${sessionScope.m.memberPhone}" readonly="readonly">
		                        </div>
		                    </div>
		                </div>
					</c:when>            
					<c:otherwise>
						<div class="deliver-addr-content" style="width: 40%;">
		                    <p>매장정보</p>
		                    <div class="deliver-addr">
		                       <div class="addr-box">
		                           <input type="text" id="storeName" value="${s.storeName}" readonly="readonly">
		                        </div>
		                        <div class="addr-box">
		                           <input type="text" id="storeAddr" value="${s.storeAddr}" readonly="readonly">
		                        </div>
		                        <div class="addr-box">
		                           <input type="text" id="storePhone" value="${s.storePhone}" readonly="readonly">
		                           <input type="hidden" id="orderName" value="${sessionScope.m.memberName}">
		                           <input type="hidden" id="orderPhone" value="${sessionScope.m.memberPhone}">
		                           <input type="hidden" id="orderAddr">
		                        </div>
		                    </div>
		                </div>
					</c:otherwise>
				</c:choose>
                
                
                
                <div class="pay-method" style="width: 40%;">
                    <p>결제수단선택</p>
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
    <input type="hidden" name="orderState" value="${type }">
    <input type="hidden" name="storeNo" value="${storeNo }">
    <input type="hidden" name="storeImg" value="${s.storeImg }">
    
    
   <script>
   
      const orderState = $("[name=orderState]").val();
      console.log(orderState);
      const storeNo = $("[name=storeNo]").val();
      const storeImg = $("[name=storeImg]").val();
      let productNo = $("[name=productNo]");

      const firstProductName = $(".product-name").eq(0).text();
      
      const pName = $(".product-name");
      
      

      
      
      
      // 상품 가격
      let productPrice = $(".product-price");
      let totalPrice = $(".product-total-price");
      let mileage = $(".product-mileage");
      
      let deliveryPrice = $(".product-delivery-price");
      let finalPrice = $(".product-final-price");
      
      
      // 상품가격 계산을 위한 변수 선언
      let sum = 0;
      
      // 상품 총 가격
      function Price(){
         for(let j=0;j<productPrice.length;j++){
            sum += Number(productPrice.eq(j).text());
         }
         totalPrice.text(sum);
      }
      Price();
      
      // 상품 총 가격 + 배송비
      finalPrice.text(Number(totalPrice.text())+Number(deliveryPrice.text()));
      let finalPrice1 = finalPrice.text();
      
      // 마일리지 계산
      mileage.text(totalPrice.text()/10);
      let mileage1 = mileage.text();
      
      // 총 주문 수량
      let quan = 0;
      let productQuan = $(".product-quan");
      for(let i=0;i<productQuan.length;i++){
         quan += Number(productQuan.eq(i).text());
      }
      
      let productName = "";
      if(productQuan.length == 1){
    	  productName = firstProductName;
      }else{
	      productName = firstProductName+" 외 "+(productQuan.length-1)+"건";
      }
      
      
      
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
                       storeNo:storeNo,
                       orderState:orderState,
                       orderTotalQuan:quan,
                       orderPrice:finalPrice1,
                       orderName:orderName,
                       orderAddr:orderAddr,
                       orderPhone:orderPhone,
                       orderMileage:mileage1,
                       orderProductName:productName,
                       orderProductImg:storeImg
                    },
                 success: function(){
                     tossPayments.requestPayment('카드', { // 결제 수단 파라미터
                          // 결제 정보 파라미터
                          amount: finalPrice1,
                          orderId: memberId+'-'+todayString,
                          orderName: productName,
                          customerName: orderName,
                          successUrl: 'http://localhost:8888/orderCard.do',
                          failUrl: 'http://localhost:8888/fail.do'
                     });
		             for(var i=0;i<productQuan.length;i++){
		            	 let pQuan = productQuan.eq(i).text();
		            	 let pNo = productNo.eq(i).val();
		            	 (function(i){
				             $.ajax({
				            	 type: "POST",
				            	 url: "/insertOrderProduct.do",
				            	 async: false,
				            	 data:
				            		 {
				            		 	productNo:pNo,
				            		 	orderProductQuan:pQuan
				            		 }
				             });
		            		 
		            	 })(i);
		             }
                 }  
            });
   	  
     }else{
        alert("배송지 정보 수정을 완료해주세요.");
     }
  });
       

       
       // 무통장결제
       payAccount.on("click", function(){
          if(inputText.prop('readonly') == true){
        	  if(orderState == "픽업준비중"){
        		  alert("픽업은 카드결제만 가능합니다.")
        	  }else{
        		  
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
	                        storeNo:storeNo,
	                        orderState:'입금대기',
	                        orderTotalQuan:quan,
	                        orderPrice:finalPrice1,
	                        orderName:orderName,
	                        orderAddr:orderAddr,
	                        orderPhone:orderPhone,
	                        orderMileage:mileage1,
	                        orderProductName:productName,
	                        orderProductImg:storeImg
	                     },
	                  success: function(){
	                      tossPayments.requestPayment('가상계좌', { // 결제 수단 파라미터
	                           // 결제 정보 파라미터
	                           amount: finalPrice1,
	                           orderId: memberId+'-'+todayString,
	                           orderName: productName,
	                           customerName: orderName,
	                           successUrl: 'http://localhost:8888/orderAccount.do',
	                           failUrl: 'http://localhost:8888/fail.do'
	                      });
			             for(var i=0;i<productQuan.length;i++){
			            	 let pQuan = productQuan.eq(i).text();
			            	 let pNo = productNo.eq(i).val();
			            	 (function(i){
					             $.ajax({
					            	 type: "POST",
					            	 url: "/insertOrderProduct.do",
					            	 async: false,
					            	 data:
					            		 {
					            		 	productNo:pNo,
					            		 	orderProductQuan:pQuan
					            		 }
					             });
			            		 
			            	 })(i);
			             }
	                  }  
	             });
        	  }
          }else{
             alert("배송지 정보 수정을 완료해주세요.");
          }
       });
       
       
       
       
       
       // 콤마 추가
      for(let i=0;i<productPrice.length;i++){
         let price = (productPrice.eq(i).text());
         productPrice.eq(i).text(addComma(price));
      }
      totalPrice.text(addComma(totalPrice.text())+"원");
      deliveryPrice.text(addComma(deliveryPrice.text())+"원");
      mileage.text(addComma(mileage.text())+"원");
      finalPrice.text(addComma(finalPrice.text())+"원");
       
      
      function addComma(value){
         value = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
         return value; 
      };
   </script>
    
      <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>