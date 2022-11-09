<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <div class="donate_content_box">
			<a href="#ex1" rel="modal:open">
                <img src="resources/img/donate/donateImg-1.jpg" class="donate_img">
                <div class="donate_content">
                    <div class="donate_content_title">잔인한 추위 속 비명으로 얼룩진 우크라이나를 도와주세요</div>
                    <div class="donate_content_organ">컨선월드와이드</div>
                    <div class="donate_content_bar"></div>
                    <div class="donate_content_footer">
                        <strong class="donate_percent_num">30</strong>
                        <strong class="donate_percent_per">%</strong>

                        <strong class="donate_amount_won">원</strong>
                        <strong class="donate_amount_num">3,333,333</strong>
                    </div>
                </div>
                </a>
            </div>
            
            <!-- 모달창 시작 --> 
            <div id="ex1" class="modal">
	            <div class="donate_content_box">
				<a href="#ex1" rel="modal:open">
	                <img src="resources/img/donate/donateImg-1.jpg" class="donate_img">
	                <div class="donate_content">
	                    <div class="donate_content_title">잔인한 추위 속 비명으로 얼룩진 우크라이나를 도와주세요</div>
	                    <div class="donate_content_organ">컨선월드와이드</div>
	                    <div class="donate_content_bar"></div>
	                    <div class="donate_content_footer">
	                        <strong class="donate_percent_num">30</strong>
	                        <strong class="donate_percent_per">%</strong>
	
	                        <strong class="donate_amount_won">원</strong>
	                        <strong class="donate_amount_num">3,333,333</strong>
	                    </div>
	                </div>
	                </a>
	            </div>
	            <div class="donate_div">
	            	<div class="donate_input_area">
	            		<div class="my_donate_sum">내 보유금액 : 총 4,000원</div>
	            		<div class="donate_btn_box">
	            			<button class="donate_btn">기부</button>
	            		</div>
	            	</div>
		            <div class="modal_close">
	  					<a href="#" rel="modal:close">닫기</a>
	  				</div>
	            </div>
			</div>
			
			<!-- 모달창 끝 -->
            <div class="donate_content_box">
                <a href="#">
                <img src="resources/img/donate/donateImg-2.jpg" class="donate_img">
                <div class="donate_content">
                    <div class="donate_content_title">잔인한 추위 속 비명으로 얼룩진 우크라이나를 도와주세요</div>
                    <div class="donate_content_organ">컨선월드와이드</div>
                    <div class="donate_content_bar"></div>
                    <div class="donate_content_footer">
                        <strong class="donate_percent_num">30</strong>
                        <strong class="donate_percent_per">%</strong>

                        <strong class="donate_amount_won">원</strong>
                        <strong class="donate_amount_num">3,333,333</strong>
                    </div>
                </div>
                </a>
            </div>
            <div class="donate_content_box">
                <a href="#">
                <img src="resources/img/donate/donateImg-3.png" class="donate_img">
                <div class="donate_content">
                    <div class="donate_content_title">잔인한 추위 속 비명으로 얼룩진 우크라이나를 도와주세요</div>
                    <div class="donate_content_organ">컨선월드와이드</div>
                    <div class="donate_content_bar"></div>
                    <div class="donate_content_footer">
                        <strong class="donate_percent_num">30</strong>
                        <strong class="donate_percent_per">%</strong>

                        <strong class="donate_amount_won">원</strong>
                        <strong class="donate_amount_num">3,333,333</strong>
                    </div>
                </div>
                </a>
            </div>
            <div class="donate_content_box">
                <a href="#">
                <img src="resources/img/donate/donateImg-4.jpg" class="donate_img">
                <div class="donate_content">
                    <div class="donate_content_title">잔인한 추위 속 비명으로 얼룩진 우크라이나를 도와주세요</div>
                    <div class="donate_content_organ">컨선월드와이드</div>
                    <div class="donate_content_bar"></div>
                    <div class="donate_content_footer">
                        <strong class="donate_percent_num">30</strong>
                        <strong class="donate_percent_per">%</strong>

                        <strong class="donate_amount_won">원</strong>
                        <strong class="donate_amount_num">3,333,333</strong>
                    </div>
                </div>
                </a>
            </div>
            <div class="donate_content_box">
                <a href="#">
                <img src="resources/img/donate/donateImg-5.jpg" class="donate_img">
                <div class="donate_content">
                    <div class="donate_content_title">잔인한 추위 속 비명으로 얼룩진 우크라이나를 도와주세요</div>
                    <div class="donate_content_organ">컨선월드와이드</div>
                    <div class="donate_content_bar"></div>
                    <div class="donate_content_footer">
                        <strong class="donate_percent_num">30</strong>
                        <strong class="donate_percent_per">%</strong>

                        <strong class="donate_amount_won">원</strong>
                        <strong class="donate_amount_num">3,333,333</strong>
                    </div>
                </div>
                </a>
            </div>
            <div class="donate_content_box">
                <a href="#">
                <img src="resources/img/donate/donateImg-6.jpg" class="donate_img">
                <div class="donate_content">
                    <div class="donate_content_title">잔인한 추위 속 비명으로 얼룩진 우크라이나를 도와주세요</div>
                    <div class="donate_content_organ">컨선월드와이드</div>
                    <div class="donate_content_bar"></div>
                    <div class="donate_content_footer">
                        <strong class="donate_percent_num">30</strong>
                        <strong class="donate_percent_per">%</strong>

                        <strong class="donate_amount_won">원</strong>
                        <strong class="donate_amount_num">3,333,333</strong>
                    </div>
                </div>
                </a>
            </div>
            <div class="more_btn_box">
                <button class="more_btn">더보기</button>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>