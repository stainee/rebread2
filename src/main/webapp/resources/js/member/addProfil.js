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
    if($("#addr").val()=="" ||  $("#phone").val()=="" || $("#whos").val() =="0"){
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
};





 