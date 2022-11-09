
setInterval(slide,4000);
function slide() {
        $("#slider1").animate({
        marginLeft: -1500
        },1500,slideNext);
}
function slideNext(){
        $("#slider1>li").eq(0).appendTo("#slider1");
        $("#slider1").animate({
        marginLeft: 0
        },0);
}