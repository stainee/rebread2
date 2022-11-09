
//메뉴,리뷰,위치 탭이벤트 활성화
const tabs = $(".tabs>li");
tabs.on("click",function(){
    tabs.css("color","rgba(0, 120, 170, 1)").css("background-color","#fff");
    $(this).css("color","#fff").css("background-color","rgba(0, 120, 170, 1)");
    const index= tabs.index(this);
    //console.log(index);
    const text=$(this).text();
    //console.log(text);
   $(".tabcontent").hide();
   const showContent = $("#"+text);
   showContent.show();
    $(".tabcontent").eq(index).show();
});
tabs.eq(0).click();

const closeBtn = $(".detail-header span");
closeBtn.on("click",function(){
    $(".detail-modal").hide();
});
$(".menu-box").on("click",function(){
    $(".detail-modal").css("display","flex");
});




//플러스 마이너스 버튼 누를 시 수량 변경
$("[name=plus]").on("click",function(){
    let amount = $("[name=amount]").val();
    amount++;
    $("[name=amount]").attr("value",amount);

    //개당 가격 추출
    let price = $(".detail-price p").text();
    //가격에서 콤마 제거
    price2= minusComma(price);
    
    let totalPrice = amount * price2;
    //console.log(totalPrice);
    let totalPrice2 = addComma(totalPrice);
    $(".total-price p").text(totalPrice2);
});
    
//마이너스 버튼 누를 시
$("[name=minus]").on("click",function(){
    let amount = $("[name=amount]").val();

    if( amount <= 1){
        alert("1개 이상일 때 주문가능합니다.");
        return;
    }else{ 
        amount = amount-1;
        //개당 가격 추출
        let price = $(".detail-price p").text();
        price2 = minusComma(price);
        let totalPrice = amount * price2;
        let totalPrice2 = addComma(totalPrice);
        console.log(totalPrice2);
        $(".total-price p").text(totalPrice2);
        $("[name=amount]").attr("value",amount);
    }
});



//콤마 제거 펑션
function minusComma(value){
    value = value.toString().replace(/[^\d]+/g, "");
    return value; 
};

//콤마 추가 펑션
function addComma(value){
    value = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    return value; 
};

