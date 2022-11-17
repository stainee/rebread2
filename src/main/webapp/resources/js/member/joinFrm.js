/**
 * 
 */
 //전체동의 했을경우 모두 check
$(".checkbox_group").on("click","#allChk",function(){
    var checked = $(this).is(":checked");
    if(checked){
        $(this).parents(".checkbox_group").find('input').prop("checked",true);
    }else{
        $(this).parents(".checkbox_group").find('input').prop("checked",false);
    }
});
// 체크박스 개별 선택
$(".checkbox_group").on("click", ".normal", function() {
    var is_checked = true;
    $(".checkbox_group .normal").each(function(){
        is_checked = is_checked && $(this).is(":checked");
    });
    $("#allChk").prop("checked", is_checked);
});
//필수동의 약관 동의 선택
$("#joinme").on("click", function(){
    var check = $(".ness").is(":checked");
    if(check){
        return true;
    }else{
        alert("필수 동의 약관을 확인해주세요");
        return false;
    }    
});
$("#joinme").on("click",function(){
    if($("#id").val()=="" || $("#pw").val()=="" || $("#rePw").val()=="" || $("#name").val()=="" || $("#addr").val()=="" ||  $("#phone").val()=="" ||$("#email").val()==""){
        alert("필수 입력값을 기입해주세요");
        return false;
    }else{
        return true;
    }
});

//회원가입 유효성 검사
function checks(){
    //이메일 검사
    var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
    var getCheckId= RegExp(/^[a-zA-Z0-9]{4,16}$/);
    var getCheckPw= RegExp(/^[a-zA-Z0-9]{4,16}$/);
    var getName= RegExp(/^[가-힣]+$/);
    if(!getCheckID.test($("#id").val())){
        alert("형식에 맞게 입력해주세요");
        return false;
    }
};

let checkId = false;
let checkPw = false;
let checkRePw = false;
$("#id").on("change",function(){
	const memberId = $("#id").val();
	$.ajax({
		url : "/idCheck.do",
		data : {memberId : memberId},
		success : function(data){
			if(data =="0"){				
				const idReg = /^[a-zA-Z0-9]{4,12}$/;
			    const idmsg = $("#idCheck");
			    if(idReg.test(memberId)){
			        idmsg.text("사용 가능한 아이디입니다.");
			        idmsg.css("color", "blue");
			        checkId = true;
			    }else{
			        idmsg.text("사용 불가능한 아이디입니다.");
			        idmsg.css("color", "red");
			        checkId = false;
			    }
			    if(idVal==""){
			        idmsg.text(" ");
			    }
			}else{
				$("#idCheck").text("이미 사용중인 아이디입니다.");
				$("#idCheck").css("color","red");
			}
		}
	});
});

$("#pw").on("keyup",function(){
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
$("#rePw").on("change",function(){
    const pwReVal = $("#rePw").val();
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
let checkName = false;
let checkEmail = false;
$("#name").on("change",function(){
    const nameReg = /^[가-힣]{2,15}$/;
    const nameVal = $("#name").val();
    const nameMsg = $("#nameCheck");
    if(nameReg.test(nameVal)){
        nameMsg.text("");
        checkName = true;
    }else{
        nameMsg.text("옳바르지 않은 이름입니다.");
        nameMsg.css("color","red");
    }
    if(nameVal==""){
        nameMsg.text(" ");
    }
});

$("#email").on("change",function(){
    const emailReg = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
    const emailVal = $("#email").val();
    const emailMsg = $("#emailCheck");
    if(emailReg.test(emailVal)){
        emailMsg.text("");
        checkEmail = true;
    }else{
        emailMsg.text("옳바르지 못한 이메일입니다.");
        emailMsg.css("color","red");
    }
    if(emailVal==""){
        emailMsg.text(" ");
    }
});


function startTimer(count, display) {  
    var minutes, seconds;
    timer = setInterval(function () {
    minutes = parseInt(count / 60, 10);
    seconds = parseInt(count % 60, 10);
    minutes = minutes < 10 ? "0" + minutes : minutes;
    seconds = seconds < 10 ? "0" + seconds : seconds;
    display.html(minutes + ":" + seconds);

    if (--count < 0) {
        clearInterval(timer);
        display.html("시간초과");
        $("#phoneChk").attr("disabled", true);
        isRunning = false;
        }
    }, 1000);
    isRunning = true;
}

//비밀번호 보이게
$("#eye1").hover(function(){
    $("#pw").toggleClass("eactive");
    if($("#pw").hasClass("eactive")==true){
        $("#pw").attr("type","text");
        $("#eye1").text("HIDE");
    }else{
        $("#pw").attr("type","password");
        $("#eye1").text("SHOW");
    }
});
$("#eye2").hover(function(){
    $("#rePw").toggleClass("eactive");
    if($("#rePw").hasClass("eactive")==true){
        $("#rePw").attr("type","text");
        $("#eye2").text("HIDE");
    }else{
        $("#rePw").attr("type","password");
        $("#eye2").text("SHOW");
    }
});

 