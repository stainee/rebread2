<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="/resources/css/member/customerService.css">
<link rel="stylesheet" href="/resources/css/font/font.css">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="/resources/img/favicon/favicon.ico"/>
<link rel="apple-touch-icon" href="/resources/img/favicon/apple-touch-icon.png"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container">
		<div class="title">
			<p>고객센터</p>
		</div>
		<div class="sub_container">
			<div class="sub_title">
				<p>자주 묻는 질문</p>
			</div>
			
			<div class="qna_wrapper">
				<ul>
					<li class="quest"><p>회원가입은 어떻게 하나요?
						<span class="material-symbols-outlined expand">expand_more</span></p>
					</li>
					<li class="answer"><p>리브레드 웹페이지 오른쪽 상단 [회원가입] 버튼을 클릭하여 진행해주시기 바랍니다.</p></li>	
				</ul>
				<ul>
					<li class="quest"><p>회원정보 수정은 어떻게 하나요?
					<span class="material-symbols-outlined expand">expand_more</span></p>
					</li>
					<li class="answer"><p>로그인 후 마이페이지 > 내정보에서 정보 변경이 가능합니다.</p></li>	
				</ul>
				<ul>
					<li class="quest"><p>배송정보 수정은 어떻게 하나요?
					<span class="material-symbols-outlined expand">expand_more</span></p>
					</li>
					<li class="answer"><p>결제시 배송정보를 변경할 수 있는 입력란이 존재합니다.<br>
					해당 입력란에서 배송정보를 수정하실 수 있습니다.</p></li>	
				</ul>
				<ul>
					<li class="quest"><p>빵을 보관하는 방법
					<span class="material-symbols-outlined expand">expand_more</span></p>
					</li>
					<li class="answer"><p>리브레드에서는 자연 해동 방식을 가장 추천드리고 있습니다.<br>
					1. 하나씩 공기를 빼면서 알루미늄 호일 또는 랩,지퍼락에 싸서 냉동합니다.<br>
					2. 호일이라면 벗겨주시고, 랩이라면 감은 채 상온에서 자연 해동합니다.<br>
					이때, 작은 빵은 30분~2시간, 큰 빵은 1시간~4시간 정도가 소요됩니다.</p></li>	
				</ul>
				<ul>
					<li class="quest"><p>빵을 판매하는 방법
					<span class="material-symbols-outlined expand">expand_more</span></p>
					</li>
					<li class="answer"><p>리브레드 웹페이지 왼쪽 상단 [입점문의] 버튼을 클릭하여 진행해주시기 바랍니다.<br>
					사업자 등록번호가 필요로 하오니 참고 부탁드립니다.</p></li>	
				</ul>
			</div>
			
			<div class="sub_title">
				<p>1:1 고객센터</p>
			</div>
			<div class="text_wrapper">
			<p>물품에 대한 문제가 생겼거나 판매절차에서 문제가 생겼을시 전화 문의 및 채팅 문의가 가능합니다.<br>
			채팅문의의 경우 문의 사항을 남겨주실 시 이메일로 빠른 답변을 남겨드립니다.<br>
			영업시간 : 9:30 ~ 18:00 (토,일,공휴일 제외)</p>
			</div>
			<div class="text_wrapper"><p>전화문의 : 00-0000-0000</p></div>
			<div class="text_wrapper"><p>채팅문의:</div>
			<c:choose>
				<c:when test="${not empty sessionScope.m.memberNo}">
					<div id="btn_chat"><a href="/chatting.do">채팅상담</a></div>
				</c:when>
				<c:otherwise>
					<div id="btn_chat" class="btn_not"><a>채팅상담</a></div>
				</c:otherwise>
			</c:choose>
			
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />	
	
</body>

<script>
$(".qna_wrapper .quest").on("click", function(){
	$(this).next().slideToggle();
	console.log($(this));
})

$(".btn_not").on("click",function(){
	alert("로그인이 필요한 서비스입니다");
})
</script>
</html>