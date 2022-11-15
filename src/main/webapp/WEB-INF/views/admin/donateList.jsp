<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 마이페이지-기부 관리</title>
</head>
     <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<link rel="stylesheet" href="resources/css/font/font.css">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/admin/memberList.css">
<link rel="stylesheet" href="/resources/css/admin/donateList.css">
<link rel="stylesheet" href="/resources/css/common/managetemplate.css">
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
            <div class="content_container">
            	<div class="donate_edit_btn_box">
            		<button class="donate_edit_btn" onclick="donateInsert()">기부 등록</button>
            	</div>
				<table class="membertbl">
					<tr>
						<th>기부번호</th>
						<th>기부단체</th>
						<th>기부내용</th>
						<th>관리</th>
					</tr>				
				<c:forEach items="${list }" var="d">
					<tr>
						<td>${d.donateNo }</td>
						<td>${d.donateOrgan }</td>
						<td>${d.donateContent }</td>
						<td>
							<button class="edit_btn" onclick="donateEdit(${d.donateNo})">수정</button>
							<button class="delete_btn" onclick="donateDelete(${d.donateNo})">삭제</button>
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
	let index=4;
	$(function(){
		let total = $(".selectList a").length;
		for(let i=0; i<total; i++){
			$(".selectList a").eq(i).removeClass("index");
		}
		$(".selectList a").eq(index).addClass("index");
	})
	
	// 등록버튼 클릭 시
	function donateInsert(){
		window.open("/donateInsertFrm.do", "기부 등록", "width=800px, height=600px, top=100px, left=250px");
	}
	
	// 수정버튼 클릭 시
	function donateEdit(donateNo){
		window.open("/donateModify.do?donateNo="+donateNo+"", "기부정보 수정", "width=800px, height=600px, top=100px, left=250px");
	}
	
	// 삭제버튼 클릭 시
	function donateDelete(donateNo){
		$.ajax({
			url:"/donateDelete.do?donateNo="+donateNo+"",
			success:function(){
				window.location.reload();
			}
		})
	};
	
	/* 더보기 버튼 구현 */
    $(function(){
        $(".membertbl tr").slice(0, 8).show(); // 초기갯수
        $(".donate_content_box:nth-child(-n+8)").css("display","inline-block");
        $(".more_btn").click(function(e){ // 클릭시 more
            e.preventDefault();
            $(".donate_content_box:hidden").slice(0, 4).show().css("display","inline-block"); // 클릭시 more 갯수 지정
            console.log($(".donate_content_box:hidden").length); // 남아있는 컨텐츠 박스 갯수 출력
            
         // 더보여줄 것이 없으면 더보기 버튼을 숨기고 "마지막페이지입니다" text 출력
            if($(".donate_content_box:hidden").length == 0){ 
            	$(".more_btn_box").css("display","none");
            	$(".more_end_box").css("display","block");
            }
        });
    });
</script>
</html>