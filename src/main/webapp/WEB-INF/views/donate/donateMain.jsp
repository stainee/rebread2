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
	<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="donate_title">
        <h1>REBREAD DONATE PAGE</h1>
    </div>
    <div class="donate_wrap">
        <div class="donate_content_wrap">
        
        	<c:forEach items="${list }" var="d">
            <div class="donate_content_box">
			<a href="#ex1" rel="modal:open" onclick="openModal(this);">
                <img src="resources/img/donate/${d.donateImg }" class="donate_img">
                <div class="donate_content">
                    <div class="donate_content_title">${d.donateContent }</div>
                    <div class="donate_content_organ">${d.donateOrgan }</div>
                    <div class="donate_content_bar">
                    	<progress value="${d.donateSum/10000}" max="100"></progress>
                    </div>
                    <div class="donate_content_footer">
                        <strong class="donate_percent_num"></strong>
                        <strong class="donate_percent_per">%</strong>

                        <strong class="donate_amount_won">원</strong>
                        <strong class="donate_amount_num">${d.donateSum }</strong>
                        <input type="hidden" value="${d.donateSum }" name="donateSum">
                        <input type="hidden" value="${d.donateEnd }" name="donateEnd">
                        <input type="hidden" value="${d.donateNo }" name="donateNo">
                        <input type="hidden" value="${m.memberMileage }" name="memberMileage">
                        <input type="hidden" value="${d.donateContent }" name="donateContent">
                        <input type="hidden" value="${d.donateOrgan }" name="donateOrgan">
                    </div>
                </div>
                </a>
            </div>
			</c:forEach>
            <!-- 모달창 시작 --> 
            <div id="ex1" class="modal">
	            <div class="donate_content_box_modal">
					<a href="#ex1" rel="modal:open" class="modal_a">
                		<img class="donate_img" id="modal_img">
			            <div class="donate_content">
			                <div class="donate_content_title" id="modal_title"></div>
			                <div class="donate_content_organ" id="modal_organ"></div>
			                <div class="donate_content_bar" id="modal_bar">
			                	<progress value="" max="100"></progress>
			                </div>
			                <div class="donate_content_footer">
			                    <strong class="donate_percent_num" id="modal_percent_num"></strong>
			                    <strong class="donate_percent_per">%</strong>
			
			                    <strong class="donate_amount_won">원</strong>
			                    <strong class="donate_amount_num" id="modal_amount_num"></strong>
			                </div>
			            </div>
                	</a>
	            </div>
	            <div class="donate_div">
	            	<div class="donate_input_area">
	            		<div class="my_donate_sum">
	            			<p class="my_donate_sum_holding">내 보유금액 : </p>
	            			<p class="my_donate_sum_amount">${sessionScope.m.memberMileage }</p>
	            			<p class="my_donate_sum_won">원</p>
	            		</div>
	            		<div class="donate_btn_box_sum">
	            			<div class="donate_btn_box_input">
	            				<input type="text" value="" name="donateInput"><span>원</span>
	            			</div>
			            	<div class="donate_btn_box">
			            		<button class="donate_btn">기부</button>
			            	</div>
						</div>
	            	</div>
		            <div class="modal_close">
	  					<a href="#" rel="modal:close">닫기</a>
	  				</div>
	            </div>
			</div>
			<!-- 모달창 끝 -->
            
            <div class="more_btn_box">
                <button class="more_btn">더보기</button>
            </div>
            <div class="more_end_box">마지막 페이지입니다</div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    <script>
    	const donateBox = $(".donate_content_box");
    	
    	$(".donate_btn").on("click", function(){
    		let donateVal = $("input[name=donateInput]").val();
    		let donateSumVal = Number(removeComma($("#modal_amount_num").text()));
    		
    		let donateNo = $("input[name=donateNo]").val();
    		let donateContent = $("#modal_title").text();
    		let donateOrgan = $("#modal_organ").text();
    		
    		location.href="/donateMileage.do?donateVal="+donateVal+"&donateSumVal="+donateSumVal+
    				"&donateNo="+donateNo+"&donateContent="+donateContent+"&donateOrgan="+donateOrgan;
    	});
    
    
    
    	/* 모달창과 기부 리스트 연결 */
    	function openModal(obj){
    		$("#modal_img").attr("src",$(obj).children().first().attr("src"));
    		$("#modal_title").text($(obj).children().eq(1).children().eq(0).text());
    		$("#modal_organ").text($(obj).children().eq(1).children().eq(1).text());
    		$("#modal_percent_num").text($(obj).children().eq(1).children().eq(3).children().eq(0).text());
    		$("#modal_amount_num").text($(obj).children().eq(1).children().eq(3).children().eq(3).text());
    		$("#modal_bar").children().val($(obj).children().eq(1).children().eq(2).children().val());
    		$(".header-wrap2").css("z-index","0");
    		$("input[name=donateNo]").val($(obj).children().eq(1).children().eq(3).children().eq(6).val())
    		// $("body").css("margin-right","16px");
    	}
    	
    	
    	/* 세자리 콤마 정규 표현식 */
	    function addComma(value){
	   		value = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	   		return value;
	    };
	    /* 세자리 콤마 제거 정규 표현식 */
	    function removeComma(value){
	        value = value.toString().replace(/[^\d]+/g, "");
	        return value; 
	    }
	    
	    /* 세자리 콤마 화면에 출력 */
	    let donateLength = $(".donate_content_box");
	    for(let i=0;i<$(".donate_amount_num").length;i++){
			let CommaNum = addComma($(".donate_amount_num").eq(i).text())
			$(".donate_amount_num").eq(i).text(CommaNum);
			
		}
	    
	    for(let i=0;i<donateLength.length;i++){
		    let donateSum = $("input[name=donateSum]").eq(i).val();
		    let donateEnd = $("input[name=donateEnd]").eq(i).val();
		    let donateCountSum = $(".donate_percent_num").eq(i).text(Number((donateSum/donateEnd)*100).toFixed());
	    }
	    
		let memberMileage = addComma($("input[name=memberMileage]").val());
		$(".my_donate_sum_amount").text(memberMileage);
	    
	    /* 더보기 버튼 구현 */
	    $(function(){
	        $(".donate_content_box").slice(0, 8).show(); // 초기갯수
	        $(".donate_content_box:nth-child(-n+8)").css("display","inline-block");
	        $(".more_btn").click(function(e){ // 클릭시 more
	            e.preventDefault();
	            $(".donate_content_box:hidden").slice(0, 4).show().css("display","inline-block"); // 클릭시 more 갯수 지정
	            console.log($(".donate_content_box:hidden").length); // 남아있는 컨텐츠 박스 갯수 출력
	            
	         // 더보여줄 것이 없으면 더보기 버튼을 숨기고 "마지막페이지입니다" text 출력
	            if($(".donate_content_box:hidden").length == 0){ 
	            	$(".more_btn_box").css("display","none");
	            	$(".more_end_box").css("display","block");
	            }
	        });
	    });
    </script>
</body>
</html>