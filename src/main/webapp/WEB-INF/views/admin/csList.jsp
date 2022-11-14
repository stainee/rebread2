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
<link rel="stylesheet" href="/resources/css/admin/csList.css">
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
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
                    <li><a href="/donateList.do">기부관리</a></li>
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
				<table class="cstbl">
					<tr>
						<th>상담번호</th>
						<th>아이디</th>
						<th>이름</th>
						<th>상담종류</th>
						<th>상담정보</th>
						<th>관리</th>
					</tr>
					
					<c:forEach items="${list}" var="cs">
						<tr>
							<td>${cs.csNo}</td>
							<td>${cs.memberId}</td>
							<td>${cs.memberName}</td>
							<td>${cs.csCategory}</td>
							<td>
								<button class="detail" onclick="viewCSDetail(${cs.csNo})">정보</button>
							</td>
							<td id="checkTd">
							<c:if test="${cs.csCheck eq 1}">
								<button class="check cancel" onclick="csCheck(this, ${cs.csNo},${cs.csCheck})">취소</button>
							</c:if>
							<c:if test="${cs.csCheck eq 0}">
								<button class="check complete" onclick="csCheck(this, ${cs.csNo},${cs.csCheck})">완료</button>
							</c:if>
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
	let index=3;
	$(function(){
		let total = $(".selectList a").length;
		for(let i=0; i<total; i++){
			$(".selectList a").eq(i).removeClass("index");
		}
		$(".selectList a").eq(index).addClass("index");
	})
	
	function viewCSDetail(csNo){
		window.open("/CSDetail.do?csNo="+csNo+"", "회원정보", "width=800px, height=600px, top=100px, left=250px");
	}
	
	
	function csCheck(obj, csNo, csCheck){
		$.ajax({
			url:"/CScheckUpdate.do?csNo="+csNo+"&csCheck="+csCheck+"",
			success:function(updateCheck){
				console.log(updateCheck);
			
				if(updateCheck==1){
					let btn = $("<button>").addClass("check").addClass("cancel");
					btn.html("취소");
					btn.attr("onclick", "csCheck(this, "+csNo+", 1)");
					$(obj).parent().append(btn);
					$(obj).remove();
				}
				else if(updateCheck==0){
					let btn = $("<button>").addClass("check").addClass("complete");
					btn.html("완료");
					btn.attr("onclick", "csCheck(this, "+csNo+", 0)");
					$(obj).parent().append(btn);
					$(obj).remove();
				}
			}
		})
	}
	
	function search(){
		searchValue = $("#search_value").val();
		searchOption = $("#search_option").val();
		if(searchValue != ""){
			$.ajax({
				url:"/csSearch.do",
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
		const list = $(".cstbl tr");
		//리스트의 내용을 지운다.
		for(let i=1; i<list.length; i++){
			list.eq(i).remove();
		}
		//리스트의 내용을 넣는다
		const tbl = $(".cstbl");
		
		for(let k=0; k<data.length; k++){
			const tr = $("<tr>");
			tr.append("<td>"+data[k].csNo+"</td>");
			tr.append("<td>"+data[k].memberId+"</td>");
			tr.append("<td>"+data[k].memberName+"</td>");
			tr.append("<td>"+data[k].csCategory+"</td>");
			const btnTd =$("<td>");
			
			btnTd.append("<button class='detail' onclick='viewCSDetail("+data[k].csNo+")'>정보</button>");
			tr.append(btnTd);
			const btnTd2 = $("<td>")
			btnTd2.attr('id', 'checkTd');
			if(data[k].csCheck == 1){
				btnTd2.append("<button class='check cancel' onclick='csCheck(this, ${cs.csNo},${cs.csCheck})'>취소</button>")		
			}else if(data[k].csCheck == 0){
				btnTd2.append("<button class='check complete' onclick='csCheck(this, ${cs.csNo},${cs.csCheck})'>완료</button>")	
			}
			tr.append(btnTd2);
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