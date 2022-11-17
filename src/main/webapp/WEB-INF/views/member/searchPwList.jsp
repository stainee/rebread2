<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/member/searchPw.css">
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
<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
</head>
<body>
	<div class="wrap">
		<div class="page-content">
			<div class="textArea" data-aos="fade-right" data-aos-delay="300" data-aos-duration="1500">
				<div>
					<a href="/"><h1>R E B R E A D</h1></a>
					<h2>패스워드 찾기</h2>
					<p>회원님의 패스워드를 재설정 해주세요.</p>	
				</div>
			</div>
			<div class="content">
				<form action="/changePw.do" method="post">
					<p class="password">
						<strong>비밀번호</strong><span id="pwCheck"></span>
						<div style="text-align: center;"><input type="password" name="memberPw" id="pw"></div>
						<p id="jek">영문 대소문자/숫자 4~12자</p>
					</p>
					<p class="passwordRe">
						<strong>비밀번호 재확인</strong><span id="pwReCheck"></span>
						<div style="text-align: center;"><input type="password" id="pwRe"></div>
					</p>
					<div id="sub">
						<input type="hidden" name="memberId" value=${m.memberId } id="id">
						<input type="button" value="변경하기" id="changePw">
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
<script>
	AOS.init();
</script>
<!-- //AOS 스크립트 초기화 -->
<div aos="fade-up" data-aos-offset="200" data-aos-easing="ease-out-cubic" data-aos-duration="500">
<script>
	let checkPw = false;
	let checkRePw = false;
	//패스워드 유효성 검사
	$("#pw").on("keyup",function(){
		console.log(11);
	    const pwReg = /^[a-zA-Z0-9]{4,16}$/;
	    const pwVal = $("#pw").val();
	    const pwmsg = $("#pwCheck");
	    if(pwReg.test(pwVal)){
	        pwmsg.text("사용 가능한 패스워드입니다.");
	        pwmsg.css("color", "blue");
	        checkPw = true;
	    }else{
	        pwmsg.text("조건에 맞지 않는 패스워드입니다.");
	        pwmsg.css("color", "red");
	        checkPw = false;
	    }
	    if(pwVal==""){
	        pwmsg.text(" ");
	    }
	});
	//재확인 패스워드 일치여부
	$("#pwRe").on("change",function(){
	    const pwReVal = $("#pwRe").val();
	    const pwRemsg = $("#pwReCheck");
	    const pwVal = $("#pw").val();
	    if(pwReVal == pwVal){
	        pwRemsg.text("패스워드가 일치합니다.");
	        pwRemsg.css("color", "blue");
	        checkRePw = true;
	    }else{
	        pwRemsg.text("패스워드가 동일하지 않습니다.");
	        pwRemsg.css("color", "red");
	        checkRePw = false;
	    }
	    if(pwReVal==""){
	        pwRemsg.text(" ");
	    }
	});
	//전에 썻던 패스워드와 일치하는경우
	$("#changePw").on("click",function(){
		$.ajax({
			type:"post",
			url: "/checkPw.do",
			data : {
				memberPw : $("#pw").val(),
				memberId : $("#id").val()
			},
			success : function(data){
				console.log(data);
				if(data == "1"){
					//기존 패스워드와 동일한 경우
					alert("기존의 패스워드와 동일합니다");
					return false;
				}else{
					if(checkPw == true && checkRePw == true){
						$.ajax({
							type :"post",
							url : "/changePw.do",
							data : {
								memberPw : $("#pw").val(),
								memberId : $("#id").val()
							},
							success : function(data){
								if(data =="0"){
									//비밀번호가 성공적으로 변경되었을경우
									alert("비밀번호가 변경되었습니다.");
									location.href="/loginFrm.do";
								}else{
									alert("오류발생")
								}
							}
						})
						return true;
					}else{
						//입력값이 잘못입력되었을경우
						alert("입력값을 확인해주세요.");
						return false;
					}
				}
			}
		})
	});
	
</script>
</html>