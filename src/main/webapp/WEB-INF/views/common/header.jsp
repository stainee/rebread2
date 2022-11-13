<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/resources/css/common/header.css">
<link rel="stylesheet" href="/resources/css/common/font.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="Icon" href="/resources/img/favicon/favicon-16x16.png">


<div class="wrap">
    <header>
        <div class="header-wrap1">
            <div class="header-top">
                <div class="header-left">
                    <span><a href="#">입점문의</a></span>
                </div>
                <div class="header-mid">
                    <a href="/">
                        <img src="/resources/img/common/logo.png">
                    </a>
                </div>
                <c:choose>
					<c:when test="${empty sessionScope.m}">
		                <div class="header-right">
		                    <ul>
		                        <li><a href="/loginFrm.do">로그인</a></li>
		                        <li><a href="/joinStep.do">회원가입</a></li>
		                        <li><a href="/loginFrm.do">주문내역</a></li>
		                        <li><a href="/donateMain.do">기부하기</a></li>
		                    </ul>
		                </div>
					</c:when>
					<c:when test="${not empty sessionScope.m }">
						<!-- 관리자 -->
		                <c:if test="${sessionScope.m.memberGrade eq 0 }">
							<div class="header-right">
			                    <ul>
			                        <li><a href="/adminMain.do">마이페이지</a></li>
			                        <c:choose>
			                        	<c:when test="${sessionScope.m.kakao == 1}">
			                        		<li><a href="/logout.do">로그아웃</a></li>
				                        </c:when>
				                        <c:when test="${sessionScope.m.kakao == 2 }">
				                        	<li><a style="cursor: pointer;" id="klogout">로그아웃</a></li>
				                        </c:when>
				                        <c:otherwise>
				                        	<li><a style="cursor: pointer;" id="Nlogout">로그아웃</a></li>
				                        </c:otherwise>
			                        </c:choose>
			                        <li><a href="/memberOrderList.do?memberNo=${sessionScope.m.memberNo }&reqPage=1">주문내역</a></li>
			                        <li><a href="#">회원해택</a></li>
			                    </ul>
			                </div>
		                </c:if>
		                <!-- 일반회원 -->
		                <c:if test="${sessionScope.m.memberGrade eq 1 }">
							<div class="header-right">
			                    <ul>
			                        <li><a href="/memberMain.do?memberNo=${sessionScope.m.memberNo }">마이페이지</a></li>
			                        <c:choose>
			                        	<c:when test="${sessionScope.m.kakao == 1}">
			                        		<li><a href="/logout.do">로그아웃</a></li>
				                        </c:when>
				                        <c:when test="${sessionScope.m.kakao == 2 }">
				                        	<li><a style="cursor: pointer;" id="klogout">로그아웃</a></li>
				                        </c:when>
				                        <c:otherwise>
				                        	<li><a style="cursor: pointer;" id="Nlogout">로그아웃</a></li>
				                        </c:otherwise>
			                        </c:choose>
			                        <li><a href="/memberOrderList.do?memberNo=${sessionScope.m.memberNo }&reqPage=1">주문내역</a></li>
			                        <li><a href="#">회원해택</a></li>
			                    </ul>
			                </div>
		                </c:if>
		                <!-- 판매자 -->
		                <c:if test="${sessionScope.m.memberGrade eq 2 }">
							<div class="header-right">
			                    <ul>
			                        <li><a href="/ceoMain.do">마이페이지</a></li>
			                        <c:choose>
			                        	<c:when test="${sessionScope.m.kakao == 1}">
			                        		<li><a href="/logout.do">로그아웃</a></li>
				                        </c:when>
				                        <c:when test="${sessionScope.m.kakao == 2 }">
				                        	<li><a style="cursor: pointer;" id="klogout">로그아웃</a></li>
				                        </c:when>
				                        <c:otherwise>
				                        	<li><a style="cursor: pointer;" id="Nlogout">로그아웃</a></li>
				                        </c:otherwise>
			                        </c:choose>
			                        <li><a href="/memberOrderList.do?memberNo=${sessionScope.m.memberNo }&reqPage=1">주문내역</a></li>
			                        <li><a href="#">회원해택</a></li>
			                    </ul>
			                </div>
		                </c:if>
					</c:when>
				</c:choose>
            </div>
        </div>
    </header>   
    <!-- sticky같은 경우는 부모가 body여야지만 작동한다.-->
    <nav class="header-wrap2">
        <div class="header-bottom">
            <a href="/"><img src="/resources/img/common/logo2.png" class="header-img"></a>       
            <div class="header-navi deactive">
                <ul>
                    <li><a href="/brandIntro.do">브랜드스토리</a></li>
                    <li><a href="/allStoreList.do?reqPage=1">구입하기</a></li>
                    <li><a href="#">베스트세일</a></li>
                    <li><a href="/donateMain.do">기부하기</a></li>
                    <li><a href="/reviewList.do?reqPage=1">리 뷰</a></li>
                    <li><a href="/customerService.do">자주하는 질문</a></li>
                </ul>
            </div>
            <c:choose>
				<c:when test="${empty sessionScope.m }">
		            <div class="header-navi-login"><a href="/loginFrm.do">로그인</a></div>
				</c:when>
				<c:otherwise>
					<div class="header-navi-login"><a href="/loginFrm.do">마이페이지</a></div>		
				</c:otherwise>
			</c:choose>
        </div>
    </nav>
    <!-- 카카오톡 로그아웃 -->
	<div class="logmodal">
		<div class="logmodal-wrap">
			<div class="modal-title">
				<h2>REBREAD LOGOUT</h2>
				<span>X</span>
			</div>
			<div class="modal-content">
				<div id="log1">리브레드 로그아웃</div>
				<div id="log2">카카오톡 로그아웃</div>
			</div>
		</div>
	</div>
	<!-- 네이버로그아웃 -->
	<div class="Nlogmodal">
		<div class="Nlogmodal-wrap">
			<div class="Nmodal-title">
				<h2>REBREAD LOGOUT</h2>
				<span>X</span>
			</div>
			<div class="Nmodal-content">
				<div id="Nlog1">리브레드 로그아웃</div>
				<div id="Nlog2">네이버 로그아웃</div>
			</div>
		</div>
	</div>     

<script src="/resources/js/common/header.js"></script>
<script>
$("#klogout").on("click",function(){
	$(".logmodal").fadeIn(300);
	$(".logmodal-wrap").fadeIn(300);
});
$(".modal-title>span").on("click",function(){
	$(".logmodal").fadeOut(300);
	$(".logmodal-wrap").fadeOut(300);
});
$("#log1").on("click",function(){
	alert("'리브레드'에서 로그아웃 되었습니다.");
	location.href="/logout.do";
});
$("#log2").on("click",function(){
	alert("카카오톡계정에서 로그아웃되었습니다");
	location.href="/kakaologout.do";
});
$("#1logout").on("click",function(){
	alert("'리브레드'에서 로그아웃되었습니다.")
});



$("#Nlogout").on("click",function(){
	$(".Nlogmodal").fadeIn(300);
	$(".Nlogmodal-wrap").fadeIn(300);
});
$(".Nmodal-title>span").on("click",function(){
	$(".Nlogmodal").fadeOut(300);
	$(".Nlogmodal-wrap").fadeOut(300);
});
$("#Nlog1").on("click",function(){
	alert("'리브레드'에서 로그아웃 되었습니다.");
	location.href="/logout.do";
});
$("#Nlog2").on("click",function(){
	alert("네이버에서 로그아웃되었습니다");
	location.href="/removeNaver.do?token=${sessionScope.access_token}";
});
</script>

















