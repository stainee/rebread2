<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기부 페이지</title>
    <link rel="stylesheet" href="resources/css/font/font.css">
    <link rel="stylesheet" href="resources/css/donate/donateMain.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="donate_title">
        <h1>기부하면 좋습니다(가명)</h1>
    </div>
    <div class="donate_wrap">
        <div class="donate_content_wrap">
        
        	<c:forEach items="${list }" var="d">
            <div class="donate_content_box">
			<a href="#ex1" rel="modal:open">
                <img src="resources/img/donate/${d.donateImg }" class="donate_img">
                <div class="donate_content">
                    <div class="donate_content_title">${d.donateContent }</div>
                    <div class="donate_content_organ">${d.donateOrgan }</div>
                    <div class="donate_content_bar"></div>
                    <div class="donate_content_footer">
                        <strong class="donate_percent_num">30</strong>
                        <strong class="donate_percent_per">%</strong>

                        <strong class="donate_amount_won">원</strong>
                        <strong class="donate_amount_num">${d.donateSum }</strong>
                    </div>
                </div>
                </a>
            </div>
            </c:forEach>
            
            <!-- 모달창 시작 --> 
            <c:forEach items="${list }" var="d">
            <div id="ex1" class="modal">
	            <div class="donate_content_box">
				<a href="#ex1" rel="modal:open">
                <img src="resources/img/donate/${d.donateImg }" class="donate_img">
                <div class="donate_content">
                    <div class="donate_content_title">${d.donateContent }</div>
                    <div class="donate_content_organ">${d.donateOrgan }</div>
                    <div class="donate_content_bar"></div>
                    <div class="donate_content_footer">
                        <strong class="donate_percent_num">30</strong>
                        <strong class="donate_percent_per">%</strong>

                        <strong class="donate_amount_won">원</strong>
                        <strong class="donate_amount_num">${d.donateSum }</strong>
                    </div>
                </div>
                </a>
	            </div>
	            <div class="donate_div">
	            	<div class="donate_input_area">
	            		<div class="my_donate_sum">내 보유금액 : 
	            			<p class="my_donate_sum_amount">${d.memberMileage }</p>
	            			<p class="my_donate_sum_won">원</p>
	            		</div>
	            		<div class="donate_btn_box">
	            			<button class="donate_btn">기부</button>
	            		</div>
	            	</div>
		            <div class="modal_close">
	  					<a href="#" rel="modal:close">닫기</a>
	  				</div>
	            </div>
			</div>
			</c:forEach>
			
			<!-- 모달창 끝 -->
            
            <div class="more_btn_box">
                <button class="more_btn">더보기</button>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    <script>
    	/* 세자리 콤마 정규 표현식 */
	    function addComma(value){
	   		value = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	   		return value;
	    };
		
		let donateAmountNum = $(".donate_amount_num");
	    let memberMileage = $(".my_donate_sum_amount");

		for(let i=0; i<donateAmountNum.length; i++){
	    
		}
		
		console.log(donateAmountNum.eq(0).text());
		console.log(memberMileage.eq(0).text());
	    /*
	    addComma(memberMileage);
	    console.log(addComma(memberMileage));
	    */
    </script>
</body>
</html>