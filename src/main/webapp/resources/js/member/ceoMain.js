const userInfoContent = $(".updateAble input");

$(".edit_btn").on("click",function(){
    userInfoContent.css("border-bottom","1px solid gray");
    userInfoContent.attr("readonly",false);
    $(".edit_btn").css("display","none");
    $(".edit_complete_btn").css("display","inline-block");
});

$(".edit_complete_btn").on("click",function(){
	userInfoContent.attr("readonly",true);
	userInfoContent.css("border-bottom","1px solid white");
});

function deleteMember(memberNo){
	$.ajax({
		url:"/memberDelete.do?memberNo="+memberNo+"",
	});
};
	
const deleteBtn = $(".footer_box_btn");
deleteBtn.on("click",function(){
	if(!confirm("정말 탈퇴하시겠습니까?")){
		// 아니오 클릭 시 이벤트
	}else{
		// 예 클릭시 이벤트
		function deleteMember(memberNo){
		};
		location.href = "/";
		alert("회원 탈퇴가 완료되었습니다.")
	}
});

	