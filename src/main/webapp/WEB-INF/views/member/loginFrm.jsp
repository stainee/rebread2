	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String errMsg = (String)session.getAttribute("errMsg");
	if(errMsg == null) errMsg ="";
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/member/loginFrm.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Yanone+Kaffeesatz:wght@500&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap"
	rel="stylesheet">
<!--aos라이브러리-->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<title>REBREAD LOGIN</title>
<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
</head>
<body>
	<div class="wrap">
		<div class="page-content">
			<a href="/">
				<div class="content-header">
						<div>
						<span data-aos="fade-top" data-aos-delay="300"
							data-aos-duration="1500">R</span> <span data-aos="fade-top"
							data-aos-duration="1500" data-aos-delay="500">E</span> <span
							data-aos="fade-top" data-aos-duration="1500" data-aos-delay="700">B</span>
						<span data-aos="fade-top" data-aos-duration="1500"
							data-aos-delay="900">R</span> <span data-aos="fade-top"
							data-aos-duration="1500" data-aos-delay="1100">E</span> <span
							data-aos="fade-top" data-aos-duration="1500" data-aos-delay="1300">A</span>
						<span data-aos="fade-top" data-aos-duration="1500"
							data-aos-delay="1500">D</span>
						</div>
					<div>로 그 인</div>
				</div>
			</a>
			<div class="content">
				<p id="errMsg" style="color:red; text-align:center; font-size: 13px;"><%=errMsg%></p>
				<form action="/login.do" method="post">
				<div class="idpw">
					<div id="id" class="memberIn">
						<span>ID</span>
						<input type="text" name="memberId"> 
					</div>
					<div id="pw" class="memberIn">
						<span>PW</span>
						<input type="password" name="memberPw">
					</div>
				</div>
					<div id="search" class="logSave">
						<input type="checkbox" class="save_id" name="checkId" id="checkId" >
    					<label for="checkId" id="labelId" style="margin-left: 10px;">아이디 저장</label>
						<a href="/searchPw.do">비밀번호 찾기</a>
						<a href="/searchId.do">아이디 찾기&nbsp;&nbsp;</a>
					</div>
					<div id="login">
						<input type="submit" value="&nbsp&nbsp&nbsp; 리브레드 로그인">
					</div>
				</form>
				<div class="kakao">
					<a href="/kakao_login.do">
						<img src="/resources/img/common/kakaologin.png">
					</a>
				</div>
				<div id="naver">
					<a href="${url }">
						<div class="naver">
							<span><img src="/resources/img/common/naverlog.png"></span>
							<span>네이버 로그인</span>
						</div>
					</a>
				</div>
				<div class="join">
					<p>아직 회원이 아니신가요?</p>
					<p>고객님을 위한 다양한 해택이 준비되어 있습니다.</p>
					<span>
						<a href="/joinStep.do">회원가입</a>
					</span>
					
				</div>
			</div>
		</div>
	</div>
</body>
</html>
	
</body>
<script>
	AOS.init();
</script>
<!-- //AOS 스크립트 초기화 -->
<div aos="fade-up" data-aos-offset="200" data-aos-easing="ease-out-cubic" data-aos-duration="500">
<script>


$(document).ready(function(){
	var key = getCookie("key");
    $("#id").val(key); 
     
    // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
    if($("#id").val() != ""){ 
        $("#checkId").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $("#checkId").change(function(){ // 체크박스에 변화가 있다면,
        if($("#checkId").is(":checked")){ // ID 저장하기 체크했을 때,
            setCookie("key", $("#id").val(), 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("key");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("#id").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#checkId").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            setCookie("key", $("#id").val(), 7); // 7일 동안 쿠키 보관
        }
    });
});
// 쿠키 저장하기 
// setCookie => saveid함수에서 넘겨준 시간이 현재시간과 비교해서 쿠키를 생성하고 지워주는 역할
function setCookie(cookieName, value, exdays) {
	var exdate = new Date();
	exdate.setDate(exdate.getDate() + exdays);
	var cookieValue = escape(value)
			+ ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
	document.cookie = cookieName + "=" + cookieValue;
}

// 쿠키 삭제
function deleteCookie(cookieName) {
	var expireDate = new Date();
	expireDate.setDate(expireDate.getDate() - 1);
	document.cookie = cookieName + "= " + "; expires="
			+ expireDate.toGMTString();
}
 
// 쿠키 가져오기
function getCookie(cookieName) {
	cookieName = cookieName + '=';
	var cookieData = document.cookie;
	var start = cookieData.indexOf(cookieName);
	var cookieValue = '';
	if (start != -1) { // 쿠키가 존재하면
		start += cookieName.length;
		var end = cookieData.indexOf(';', start);
		if (end == -1) // 쿠키 값의 마지막 위치 인덱스 번호 설정 
			end = cookieData.length;
            console.log("end위치  : " + end);
		cookieValue = cookieData.substring(start, end);
	}
	return unescape(cookieValue);
}

</script>
</html>