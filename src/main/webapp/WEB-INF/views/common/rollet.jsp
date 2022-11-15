<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>REBREAD EVENT</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/common/rolletMain.css">
<link rel="stylesheet" href="/resources/css/common/event.css">
<!--aos라이브러리-->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="page-content">
		<div class="page-title"
		 style="padding-bottom: 10px;"
		 data-aos="fade-right" data-aos-duration="1000" data-aos-delay="500">
		<h2>룰렛 이벤트</h2>
		<p>토큰을 사용하여 마일리지를 적립해보세요 !</p>
		</div>
		<input type="hidden" value="${sessionScope.m.memberId }" id="memberId">
		<input type="hidden" value="${sessionScope.m.memberMileage }" id="memberMileage">
		<div class="item-basket-box">
			<table style="margin: 0 auto;">
                <tr>
                    <td width="438" height="582" class="the_wheel" align="center" valign="center">
                        <canvas id="canvas" width="434" height="434">
                        </canvas>
                    </td>
                    <td id="how" width="400" height="582">
                    	<h2>${sessionScope.m.memberName }님의 정보</h2>
                    	<h2>토큰 개수 : ${sessionScope.m.token }개</h2>
                    	<h2>마일리지 : ${sessionScope.m.memberMileage } M</h2>
                    	<h2>사용법</h2>
                    	<p>1. Power를 선택해주세요.</p>
                    	<p>2. Start버튼을 눌러주세요. </p>
                    	<p>3. 한번 더 시도하기 위해서는 하단의 again버튼을 눌러주세요</p>
                    	<p> → 1회 회전에 1토큰이 소요됩니다. </p>
                    	<p> → 토큰이 부족하면 룰렛 사용이 제한됩니다.</p>
                    	
                    </td>
                </tr>
            </table>
            <div class="power_controls">
                 <table class="power" style="margin: 0 auto;">
                     <tr>
                        <th align="center" style="background-color: #fff;">Power
                        <p style="margin-top:-5px; font-size: 10px;">choose</p>
                        </th>
                        <td width="78" align="center" id="pw3" onClick="powerSelected(3);">High</td>
                        <td align="center" id="pw2" onClick="powerSelected(2);">Med</td>
                        <td align="center" id="pw1" onClick="powerSelected(1);">Low</td>
                 </table>
            <div id="spin_button" alt="Spin" onClick="startSpin();">START</div>
            <div id="again"><a href="#" onClick="resetWheel(); return false;">Play Again</a></div>
            </div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
<!-- AOS 스크립트 초기화 -->
<script>
	AOS.init();
</script>
<!-- //AOS 스크립트 초기화 -->
<div aos="fade-up" data-aos-offset="200" data-aos-easing="ease-out-cubic" data-aos-duration="500"></div>
<script src="http://cdnjs.cloudflare.com/ajax/libs/gsap/latest/TweenMax.min.js"></script>
<script type="text/javascript" src="/resources/js/common/Winwheel.js"></script>





<script>
	let theWheel = new Winwheel({
	    'numSegments'  : 8,     // Specify number of segments.
	    'outerRadius'  : 212,   // Set outer radius so wheel fits inside the background.
	    'textFontSize' : 28,    // Set font size as desired.
	    'segments'     :       // Define segments including colour and text.
	    [
	       {'fillStyle' : '#e3e0cf', 'text' : '100','textFillStyle' : '#555555'},
	       {'fillStyle' : '#fff', 'text' : '2000', 'textFillStyle' : '#1617ad'},
	       {'fillStyle' : '#e3e0cf', 'text' : '50','textFillStyle' : '#555555'},
	       {'fillStyle' : '#fff', 'text' : '2500', 'textFillStyle' : '#1617ad'},
	       {'fillStyle' : '#e3e0cf', 'text' : '100','textFillStyle' : '#555555'},
	       {'fillStyle' : '#fff', 'text' : '50', 'textFillStyle' : '#1617ad'},
	       {'fillStyle' : '#e3e0cf', 'text' : '3000','textFillStyle' : '#555555'},
	       {'fillStyle' : '#fff', 'text' : '100', 'textFillStyle' : '#1617ad'}
	    ],
	    'animation' :           // Specify the animation to use.
	    {
	        'type'     : 'spinToStop',
	        'duration' : 5,     // Duration in seconds.
	        'spins'    : 8,     // Number of complete spins.
	        'callbackFinished' : alertPrize
	    }
	});
	
	let wheelPower    = 0;
	let wheelSpinning = false;
	
	function powerSelected(powerLevel)
	{
	    if (wheelSpinning == false) {
	        document.getElementById('pw1').className = "";
	        document.getElementById('pw2').className = "";
	        document.getElementById('pw3').className = "";
	
	        if (powerLevel >= 1) {
	            document.getElementById('pw1').className = "pw1";
	        }
	
	        if (powerLevel >= 2) {
	            document.getElementById('pw2').className = "pw2";
	        }
	
	        if (powerLevel >= 3) {
	            document.getElementById('pw3').className = "pw3";
	        }
	
	        wheelPower = powerLevel;
	
	        document.getElementById('spin_button').src = "spin_on.png";
	        document.getElementById('spin_button').className = "clickable";
	    }
	}
	
	function startSpin()
	{
	    if (wheelSpinning == false) {
	        if (wheelPower == 1) {
	            theWheel.animation.spins = 3;
	        } else if (wheelPower == 2) {
	            theWheel.animation.spins = 8;
	        } else if (wheelPower == 3) {
	            theWheel.animation.spins = 15;
	        }
	
	        document.getElementById('spin_button').src       = "spin_off.png";
	        document.getElementById('spin_button').className = "";
	
	        theWheel.startAnimation();
	
	        wheelSpinning = true;
	    }
	}
	
	function resetWheel()
	{
	    theWheel.stopAnimation(false);  // Stop the animation, false as param so does not call callback function.
	    theWheel.rotationAngle = 0;     // Re-set the wheel angle to 0 degrees.
	    theWheel.draw();                // Call draw to render changes to the wheel.
	
	    document.getElementById('pw1').className = "";  // Remove all colours from the power level indicators.
	    document.getElementById('pw2').className = "";
	    document.getElementById('pw3').className = "";
	
	    wheelSpinning = false;          // Reset to false to power buttons and spin can be clicked again.
	}
	
	function alertPrize(indicatedSegment)
	{
	    //alert(indicatedSegment.text +"마일리지 적립 성공 !" );
	    $.ajax({
	    	type :"post",
	    	url : "/rolletEvent.do",
	    	data : {
	    		token : indicatedSegment.text,
	    		memberId : $("#memberId").val(),
	    	},
	    	success : function(data){
	    		alert(indicatedSegment.text +"마일리지 적립 성공 !" );
	    	}
	    })	
	}
</script>

</html>