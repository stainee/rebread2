 //저장된 주소 불러오기
    const addr= $("[name=addr]").val();
    console.log("주소: "+addr);
    
    //저장된 상호명 불러오기
    const storeName = $(".left-content>.mid-title h2").text();
    console.log("상호명 : "+storeName);

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
    
    
    if(index==2){
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

    // 지도를 생성합니다    
    var map = new kakao.maps.Map(mapContainer, mapOption); 

    // 주소-좌표 변환 객체를 생성합니다
    var geocoder = new kakao.maps.services.Geocoder();

    // 주소로 좌표를 검색합니다
    geocoder.addressSearch(addr, function(result, status) {
			
            // 정상적으로 검색이 완료됐으면 
            if (status === kakao.maps.services.Status.OK) {

                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			
                // 결과값으로 받은 위치를 마커로 표시합니다
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });

                // 인포윈도우로 장소에 대한 설명을 표시합니다
                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="width:150px;text-align:center;padding:6px 0;">'+storeName+'</div>'
                });
                infowindow.open(map, marker);

                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(coords);
            } 
        });    
    }
});
tabs.eq(0).click();

const closeBtn = $(".detail-header span");
closeBtn.on("click",function(){
    $(".detail-modal").hide();
});
$(".menu-box").on("click",function(){
    $(".detail-modal").css("display","flex");
});


function loadImg(f){
	    console.log(f.files);
	    
	    if(f.files.length !=0 && f.files[0] != 0 ){
	        const reader = new FileReader(); // 파일 정보를 읽어올 수 있는 객체
	        reader.readAsDataURL(f.files[0]);//선택한 파일 정보 읽어옴
	        //파일리더가 파일을 다 읽어오면 동작할 함수 작성
	        reader.onload = function(e){
	            $("#img-view").attr("src",e.target.result);
	        }
	    }else{
	        $("#img-view").attr("src","");
	    }
	}



    
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

	//콤마 추가 펑션
	function addComma(value){
		value = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		return value; 
	};
	//콤마 제거 펑션
	function minusComma(value){
	    value = value.toString().replace(/[^\d]+/g, "");
	    return value; 
	};


/*
$(tabs.eq(1)).on("click",function(){
			const storeNos =$("[name=storeNo]").val();
			console.log(storeNos);
			$.ajax({
				url:"/selectReview.do",
				data:{
					storeNo : storeNos
					},
				success:function(data){
					console.log(data);
					var html = "";
					html += "<li>";
					html += "<p class='comment-info'>";
					html += "<span id='writer'>tntkssk12</span>";
					html += "<span id='date'>2022-11-16</span>";
					html += "<span id='updateBtn'>수정</span>";
					html += "<span id='deleteBtn'>삭제</span>";
					html += "</p>";
					html += "<p class='comment-content'>너무 맛있다~~</p>";
					html += "<textarea name='ncContent' class='input-form' style='min-height:96px; display:none;'></textarea>";
					html += "<p class='comment-link'>";
					html += "</li>";
					$(".posting-comment").html(html);
				}
				
				});
				});
	*/