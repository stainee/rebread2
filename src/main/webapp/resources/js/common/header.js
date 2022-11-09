$(window).on("scroll",function(){
    const position = $(window).scrollTop();
    const navi = $(".header-navi");
    const login = $(".header-navi-login");
    const img = $(".header-img"); 
    
    if(position > 43){
        navi.addClass("active");
        navi.removeClass("deactive");
        login.css("display", "block");
        img.css("display", "block");
    }else{
        navi.addClass("deactive");
        navi.removeClass("active");
        login.css("display", "none");
        img.css("display", "none");
    }
});    


