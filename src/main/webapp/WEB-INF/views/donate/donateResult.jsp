<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기부 결과페이지</title>
<link rel="stylesheet" href="resources/css/font/font.css">
<link rel="stylesheet" href="resources/css/donate/donateResult.css">

</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="donate_result_wrapper">
		<div class="donate_result_wrap_frm">
			<div class="donate_result_title">
				<h1>"감사합니다. 기부금을 소중하게 사용하겠습니다."</h1>
			</div>
			<div class="donate_result_comment_top_wrap">
			<div class="donate_result_comment_top"></div><div class="donate_result_comment_top"></div><div class="donate_result_comment_top"></div><div class="donate_result_comment_top"></div>
			</div>
			<div class="donate_result_comment_box">
				<div class="donate_result_comment">
					<h2>나눔의 뿌듯함, 한 번으로 아쉽다면?</h2>
					<h3>다른 이웃들에게도 도움의 손길을 주세요</h3>
					<div class="donate_result_comment_btn_box">
						<a href="/donateMain.do"><button class="donate_result_comment_btn">계속 기부하기</button></a>
					</div>
				</div>
			</div>
			<div class="donate_info_title"><h3>기부정보 확인</h3></div>
			<div class="donate_info_frm">
				<div class="donate_info_comment"><strong>100</strong><span>원 기부되었습니다</span></div>
				<div class="donate_info_name_box">
					<div class="donate_info_title_name_box">
						<div class="donate_info_title_name">모금함명</div>
						<div class="donate_info_title_content">잔인한 추위 속 비명으로 얼룩진 우크라이나를 도와주세요</div>
					</div>
					<div class="donate_info_organ_name_box">
						<div class="donate_info_organ_name">단체명</div>
						<div class="donate_info_organ_content">컨선월드와이드</div>
					</div>
				</div>
			</div>
			<div class="donate_return_btn_box">
				<a href="/"><button class="donate_return_btn">확인</button></a>
			</div>
		</div>
	</div>
</body>
</html>