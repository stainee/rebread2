const userInfoContent = $(".updateAble input");

$(".edit_btn").on("click",function(){
    userInfoContent.css("border-bottom","1px solid black");
    userInfoContent.attr("readonly",false);
    $(".edit_btn").css("display","none");
    $(".edit_complete_btn").css("display","inline-block");
});

$(".edit_complete_btn").on("click",function(){
	userInfoContent.attr("readonly",true);
	userInfoContent.css("border-bottom","1px solid white");
});


	