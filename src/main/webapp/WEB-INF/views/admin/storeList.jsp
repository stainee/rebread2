<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="/resources/css/font/font.css">
<link rel="stylesheet" href="/resources/css/common/admin.css">
<link rel="stylesheet" href="/resources/css/admin/storeList.css">
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div class="total_wrapper">
        <div class="left_container">
            <div class="memberInfo">
                <p>[관리자]</p>
                <p>${sessionScope.m.memberName}님</p>
                <!-- <button onclick="callAPI()">임시API호출버튼</button> -->
            </div>
            <div class="selectList">
                <ul>
                	<li><a href="/adminMain.do">내정보</a></li> 
                    <li><a href="/storeList.do">가게관리</a></li>
                    <li><a href="/memberList.do">회원관리</a></li>
                    <li><a href="/csList.do">문의관리</a></li>
                </ul>
            </div>
        </div>

        <div class="right_container">
        	<div class="search_wrap">
        		<input type="text" id="storeName" placeholder="검색할 상호명을 입력해주세요">
        		<button onclick="search();" id="searchBtn">검색</button>
        	</div>
            <div class="content_container">
				<table class="sellertbl">
					<tr>
						<th>판매자번호</th>
						<th>상호명</th>
						<th>사업자등록번호</th>
						<th>계좌번호</th>
						<th>관리</th>
					</tr>
					<c:forEach items="${list}" var="s">
						<tr>
							<td>${s.storeNo}</td>
							<td>${s.storeName}</td>
							<td>${s.storeRegistNum}</td>
							<td>${s.storeAccount}</td>
							<td>
								<button class="info" onclick="viewStoreInfo(${s.storeNo})">정보</button>
								<button class="account" onclick="viewAccountInfo(${s.storeNo})">정산</button>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
         </div>
      
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />	
</body>
<script>
	let index=1;
	$(function(){
		let total = $(".selectList a").length;
		for(let i=0; i<total; i++){
			$(".selectList a").eq(i).removeClass("index");
		}
		$(".selectList a").eq(index).addClass("index");
	})
	
	function viewStoreInfo(storeNo){
		window.open("/storeListDetail.do?storeNo="+storeNo+"", "가게정보", "width=800px, height=600px, top=100px, left=250px");
	}
	function viewAccountInfo(storeNo){
		window.open("/storeAccount.do?storeNo="+storeNo+"", "가게정보", "width=800px, height=600px, top=100px, left=250px");
	}
	//이체 API 테스트 메소드
	function callAPI(){
		$.ajax({
			url:"/testCallAPI.do"
		})
	}
	
	
	function search(){
		storeName = $("#storeName").val();
		if(storeName != ""){
			$.ajax({
				url:"/storeSearch.do",
				data:{storeName : storeName
				},
				dataType: "json",
				success:function(list){
					convert(list);
				}
			})
		}
	}
	
	function convert(data){
		const list = $(".sellertbl tr");
		//리스트의 내용을 지운다.
		for(let i=1; i<list.length; i++){
			list.eq(i).remove();
		}
		//리스트의 내용을 넣는다
		const tbl = $(".sellertbl");
		
		for(let k=0; k<data.length; k++){
			const tr = $("<tr>");
			tr.append("<td>"+data[k].storeNo+"</td>");
			tr.append("<td>"+data[k].storeName+"</td>");
			tr.append("<td>"+data[k].storeRegistNum+"</td>");
			tr.append("<td>"+data[k].storeAccount+"</td>");
			const btnTd =$("<td>");
			btnTd.append("<button class='info' onclick='viewStoreInfo("+data[k].storeNo+")' style='margin-right:4px;'>정보</button>");
			btnTd.append("<button class='account' onclick='viewAccountInfo("+data[k].storeNo+")'>정산</button>");
			tr.append(btnTd);
			tbl.append(tr);
		}
	}
	
	$("#storeName").on("keyup", function(key){
		if(key.keyCode == 13){
			search();
		}
	});
</script>
</html>