<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>패스워드찾기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/resources/css/member/searchMember2.css">
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
</head>
<body>
	<div class="wrap">
		<div class="page-content">
			<div class="textArea" data-aos="fade-right" data-aos-delay="300" data-aos-duration="1500">
				<div>
					<a href="/"><h1>R E B R E A D</h1></a>
					<h2>패스워드 찾기</h2>	
					<p>가입하신 방법에 따라 비밀번호 찾기가 가능합니다</p>
				</div>
			</div>
			<div class="content">
				<p class="member">
					<strong>회원유형</strong>
					<select id="searchTpye" name="memberGrade" style="font-size: 15px; color: #555555">
						<option selected="selected" value="0">선택</option>
						<option value="1">개인 회원</option>
						<option value="2">개인 사업자회원</option>
						<option value="3">관리자 회원</option> 
					</select>
				</p>
				<p class="id">
					<strong id="name_label">아이디</strong>
					<input id="id" name="memberId" type="text">
				</p>
				<p class="phone">
					<strong id="phone_label">휴대폰번호</strong>
					<input id="phone1" type="text"> -
					<input id="phone2" type="text"> -
					<input id="phone3" type="text">
					<input type="hidden" name="memberPhone" id="phone">
				</p>
				<div id="btnarea"><button id="searchId">확 인</button></div>
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
	$("#searchId").on("click",function(){
		const phone1 = $("#phone1").val();
		const phone2 = $("#phone2").val();
		const phone3 = $("#phone3").val();
		const memberPhone = $("#phone").val(phone1+phone2+phone3);
		if($("#searchTpye").val()=="0"|| $("#id").val()==""||$("#phone1").val()==""||$("#phone2").val()==""||$("#phone3").val()==""){
			alert("입력값을 확인해주세요");
			return false;
		}else{
			location.href="/searchPw1.do?memberId="+$("#id").val()+"&memberPhone="+memberPhone.val()+"&memberGrade="+$("#searchTpye").val();   
		}
	});


</script>
</html>