<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/cs/csChat.css">
<link rel="stylesheet" href="/resources/css/font/font.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="title-wrapper">
		<p>고객상담</p>
	</div>
	<input type="hidden" value="${sessionScope.m.memberId}" id="memberId">
	<input type="hidden" value="${sessionScope.m.memberNo}" id="memberNo">
	<div class="chatting_header">
		<p>Rebread 1:1 문의</p>
	</div>
	<div class="chatting">
		<div class="messageArea"></div>
		<div class="sendBox">
			<input type="text" id="sendMsg" readonly>
			<button id="sendBtn" onclick="sendMsg();">전송</button>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
<script>
	//웹소켓 객체를 저장할 변수
	let ws;
	let memberId = $("#memberId").val();
	let memberNo = $("#memberNo").val();
	let csData = {memberNo : memberNo};
	initChat();
	function initChat(){
		//웹소켓 연결 시도
		ws = new WebSocket("ws://192.168.10.37:8888/chat.do");
		//웹소켓 연결 성공시 실행할 함수 지정
		ws.onopen = startChat;
		//서버에서 데이터를 받으면 처리할 함수 지정
		ws.onmessage = receiveMsg;
		//웹소켓 연결이 종료되면 실행할 함수 지정
		ws.onclose = endChat;
	}
	//웹소켓 연결 성공시
	function startChat(){
		const data = {type:"enter", msg:memberId};
		ws.send(JSON.stringify(data));
	}
	function receiveMsg(param){
		appendChat(param.data);
	}
	
	//첫번째 선택 항목에 대해서 처리
	function selectOne(obj, num){
		const msg = $(obj).attr("id");
		const selectmsg = $(obj).text();
		//서버에서 처리하도록 값을 서버로 보낸다
		const data = {type:"bot", msg:msg, select:num};
		ws.send(JSON.stringify(data));
		appendChat("<div class='chat left'>"+selectmsg+"</div>");
		disabled();
		
		//질문 depth별 객체 저장
		if(num==1){
			csData.csCategory = selectmsg;
		}
		else if(num==2){
			temp = csData.csCategory
			csData.csCategory = temp+" > "+selectmsg;
		}
	}
	
	function inputAble(){
		$("#sendMsg").attr("readonly", false);
		appendChat("<div class='chat left'>"+"추가문의 </div>");
		disabled();
	}
	
	function disabled(){
		$(".bot button").attr("disabled", "true");
	}
	//전송버튼 누를시 전송하는 부분
	function sendMsg(){
		const msg = $("#sendMsg").val();
		if(msg != ''){
			//서버에 채팅 종료를 알린다
			//문자열을 전송
			const data = {type:"bot", msg:msg, select:3};
			ws.send(JSON.stringify(data));
			$("#sendMsg").val("");
			appendChat("<div class='chat left'>"+msg+"</div>");
			setTimeout(function(){
				appendChat("<div class='bot right'>"+"문의 내용 확인 후 이메일을 통해 답변 드리겠습니다.감사합니다.</div>");
				appendChat("<div class='bot right'><button id='reset' onclick='reset();'>처음으로</button></div>");
				$("#sendMsg").attr("readonly", true);
			},1000);

			//서버에서 처리하도록 저장한 값을 서버로 보낸다
			csData.csContent = msg;
			$.ajax({
				url:"/insertCS.do",
				data: csData,
				success:function(){
					console.log("data send success");
				}
			})
		}
	}
	
	function appendChat(msg){
		$(".messageArea").append(msg);
		$(".messageArea").scrollTop($(".messageArea")[0].scrollHeight);
	}
	
	function reset(){
		window.location.reload();
	}
	
	$("#sendMsg").on("keyup", function(key){
		if(key.keyCode == 13){
			sendMsg();
		}
	});
</script>
</html>