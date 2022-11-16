package kr.or.review.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.review.model.dao.ReviewDao;
import kr.or.review.model.vo.Review;

@Service
public class ReviewService {
	@Autowired
	private ReviewDao dao;

	public ArrayList<Review> reviewList() {
		return dao.reviewList();
	}

	
	
	
	public HashMap<String, Object> selectReviewList(int reqPage) {
		int numPerPage = 10;
		int end = reqPage * numPerPage;
	    int start = end-numPerPage+1;
	    
	    HashMap<String, Object> map = new HashMap<String, Object>();
	    map.put("start", start);
	    map.put("end", end);
	    ArrayList<Review> list = dao.selectReviewList(map);	    
		
	    int totalCount = dao.selectReviewCount();
	    int totalPage = 0;
	    if(totalCount%numPerPage == 0) {
	    	totalPage = totalCount/numPerPage;
	    }else {
	    	totalPage = totalCount/numPerPage + 1;
	    }
	    
	    int pageNaviSize = 5;
	    int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize+1;
	    
	    String pageNavi = "<ul>";
	    if(pageNo != 1) {
	    	pageNavi += "<li>";
	         pageNavi += "<a href='/reviewList.do?reqPage="+(pageNo-1)+"'>";
	         pageNavi += "<img src='/resources/img/review/prev-arrow.png'>";
	         pageNavi += "</a></li>";
	    }
	    
	    for(int i=0; i<pageNaviSize; i++) {
	         if(pageNo == reqPage) { 
	            pageNavi += "<li>";
	            pageNavi += "<a href='/reviewList.do?reqPage="+pageNo+"'>";
	            pageNavi += pageNo;
	            pageNavi += "</a></li>";
	         }else { 				
	            pageNavi += "<li>";
	            pageNavi += "<a href='/reviewList.do?reqPage="+pageNo+"'>";
	            pageNavi += pageNo;
	            pageNavi += "</a></li>";
	         }
	         pageNo++;
	         if(pageNo>totalPage) {
	            break;
	         }
	    }
	    if(pageNo<=totalPage) {
	         pageNavi += "<li>";
	         pageNavi += "<a href='/reviewList.do?reqPage="+pageNo+"'>"; // 이미 ++됐음
	         pageNavi += "<img src='/resources/img/review/next-arrow.png'>";
	         pageNavi += "</a></li>";
	     }
	    pageNavi += "</ul>";
	      HashMap<String, Object> pageMap = new HashMap<String, Object>();
	      pageMap.put("list", list);
	      pageMap.put("pageNavi", pageNavi);
	      pageMap.put("reqPage", reqPage);
	      pageMap.put("numPerPage", numPerPage);
	      return pageMap;
	}




	public Review selectOneReview(int reviewNo) {
		return dao.selectOneReview(reviewNo);
	}
	
	public String selectStoreName(int storeNo) {
		return dao.selectStoreName(storeNo);
	}
	public int deleteReview(int reviewNo) {
		return dao.deleteReview(reviewNo);
	}
	public int updateView(int reviewNo) {
		return dao.updateView(reviewNo);
	}

	public ArrayList<Review> selectStoreReview(int storeNo) {
		return dao.selectStoreReview(storeNo);
	}




	public int insertReview(Review r) {
		return dao.insertReview(r);
	}
}





























