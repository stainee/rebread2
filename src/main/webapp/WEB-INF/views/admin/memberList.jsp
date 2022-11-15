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
<link rel="stylesheet" href="/resources/css/admin/memberList.css">
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div class="page-content" style="height: 800px;">
<div class="total_wrapper">
        <div class="left_container">
            <div class="memberInfo">
                <p>[관리자]</p>
                <p>${sessionScope.m.memberName}님</p>
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
        		<select id ="search_option">
        			<option value="memberId">아이디</option>
        			<option value="memberName">이름</option>
        		</select>
        		<input type="text" id="search_value">
        		<button onclick="search();" id="searchBtn">검색</button>
        	</div>
            <div class="content_container">
				<table class="membertbl">
					<tr>
						<th>회원번호</th>
						<th>아이디</th>
						<th>이름</th>
						<th>전화번호</th>
						<th>관리</th>
					</tr>				
					<c:forEach items="${list}" var="m">
						<tr>
							<td>${m.memberNo }</td>
							<td>${m.memberId }</td>
							<td>${m.memberName}</td>
							<td>${m.memberPhone}</td>
							<td>
								<button class="info" onclick="viewMemberDetail(${m.memberNo})">정보</button>
								<button class="remove" onclick="deleteMember(${m.memberNo})">삭제</button>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
         </div>
 
</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />	
</body>
<script>
	let index=2;
	$(function(){
		let total = $(".selectList a").length;
		for(let i=0; i<total; i++){
			$(".selectList a").eq(i).removeClass("index");
		}
		$(".selectList a").eq(index).addClass("index");
	})
	
	function viewMemberDetail(memberNo){
		window.open("/memberModify.do?memberNo="+memberNo+"", "회원정보", "width=800px, height=600px, top=100px, left=250px");
	}
	
	function deleteMember(memberNo){
		$.ajax({
			url:"/memberDelete.do?memberNo="+memberNo+"",
			success:function(){
				window.location.reload();
			}
			
		})
	}
	
	function search(){
		searchValue = $("#search_value").val();
		searchOption = $("#search_option").val();
		if(searchValue != ""){
			$.ajax({
				url:"/memberSearch.do",
				data:{searchValue: searchValue,
					  searchOption : searchOption
				},
				dataType: "json",
				success:function(list){
					convert(list);
				}
			})
		}
	}
	
	function convert(data){
		const list = $(".membertbl tr");
		//리스트의 내용을 지운다.
		for(let i=1; i<list.length; i++){
			list.eq(i).remove();
		}
		//리스트의 내용을 넣는다
		const tbl = $(".membertbl");
		
		for(let k=0; k<data.length; k++){
			const tr = $("<tr>");
			tr.append("<td>"+data[k].memberNo+"</td>");
			tr.append("<td>"+data[k].memberId+"</td>");
			tr.append("<td>"+data[k].memberName+"</td>");
			tr.append("<td>"+data[k].memberPhone+"</td>");
			const btnTd =$("<td>");
			btnTd.append("<button class='info' onclick='viewMemberDetail("+data[k].memberNo+")' style='margin-right:4px;'>정보</button>");
			btnTd.append("<button class='remove' onclick='deleteMember("+data[k].memberNo+")'>삭제</button>");
			tr.append(btnTd);
			tbl.append(tr);
		}
	}
	
	$("#search_value").on("keyup", function(key){
		if(key.keyCode == 13){
			search();
		}
	});
</script>
</html>