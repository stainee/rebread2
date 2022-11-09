<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="/resources/css/common/default.css">
<link rel="stylesheet" href="/resources/css/store/StoreList.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<div class="page-content">
            <div class="mid-title">
                <h3>BAKERY</h3>
            </div>
            <div class="mid-wrap">
                <div class="search">
                    <div>
                        <form action="/#">
                            <input type="text" name="storeName" placeholder="매장검색">
                            <button type="submit" class="btn bc2">검색</button>
                        </form>
                    </div>
                    <div class="lineUp">
                        <a href="#" class="btn bc3">리뷰순</a>
                        <a href="#" class="btn bc3">별점순</a>
                        <a href="#" class="btn bc3">할인순</a>
                    </div>
                </div>
                <div class="storeWrap">
				<c:forEach items="${list }" var="s">
					<div class="wrap2">
						<div class="storeBox">
							<div class="store-img">
								<img src="/resources/upload/store/${s.storeImg }">
							</div>
							<div class="store-info">
								<a href="/detailStore.do?storeNo=${s.storeNo}">
								<div class="store-name">${s.storeName}</div>
								<div class="store-star">
									<span id="star">★ ${s.rating}</span> <span>리뷰 3,800</span>
								</div>
								<div class="store-time">
									<span>운영시간 ${s.openTime} ~ ${s.closeTime }</span>
								</div>
								</a>
							</div>
							<div class="store-discount">70%</div>
						</div>
					</div>
				</c:forEach>

				</div>
	            <div id="pageNavi">${pageNavi }</div>
            </div>
        </div>  
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/> 
</body>
</html>