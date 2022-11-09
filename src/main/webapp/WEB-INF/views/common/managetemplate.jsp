<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="/resources/css/common/managetemplate.css">
<body>
<div class="total_wrapper">
        <div class="left_container">
            <div class="memberInfo">
                <p>[${storeName }]</p>
            </div>
            <div class="selectList">
                <ul>
                	<li><a href="/detailStore.do?storeNo=${storeNo}">${storeAddr}</a></li> 
                </ul>
            </div>
        </div>

        <div class="right_container">
            <div class="content_container">
            
            </div>
        </div>
    </div>
</body>
<script>
	let index=0;
	$(function(){
		let total = $(".selectList a").length;
		for(let i=0; i<total; i++){
			$(".selectList a").eq(i).removeClass("index");
		}
		$(".selectList a").eq(index).addClass("index");
	})
</script>
</html>