<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
     <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 마이페이지-기부 관리</title>
</head>
<link rel="stylesheet" href="resources/css/font/font.css">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/common/managetemplate.css">
<link rel="stylesheet" href="/resources/css/admin/memberList.css">
<link rel="stylesheet" href="/resources/css/admin/donateList.css">
<body>
<div class="total_wrapper">
        <div class="left_container">
            <div class="memberInfo">
                <p>[관리자]</p>
                <p>박예진님</p>
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
            		<button class="donate_edit_btn" onclick="donateDetail()">기부 등록/수정</button>
            	</div>
				<table class="membertbl">
					<tr>
						<th>기부번호</th>
						<th>기부단체</th>
						<th>기부내용</th>
						<th>관리</th>
					</tr>				
					<tr>
						<td>1</td>
						<td>컨선월드와이드</td>
						<td>잔인한 추위 속 비명으로 얼룩진 우크라이나를 도와주세요 근데 내용이 넘으면 어케 돼?</td>
						<td>
							<button class="edit_btn">수정</button>
							<button class="delete_btn">삭제</button>
						</td>
					</tr>
				</table>
			</div>
         </div>
 
</div>
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
	
	function donateDetail(memberNo){
		window.open("/donateDetail.do", "기부 등록/수정", "width=800px, height=600px, top=100px, left=250px");
	}
	
	function deleteMember(memberNo){
		$.ajax({
			url:"/memberDelete.do?memberNo="+memberNo+"",
			success:function(){
				window.location.reload();
			}
			
		})
	}
</script>
</html>