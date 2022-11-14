package kr.or.review.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.review.model.service.ReviewService;
import kr.or.review.model.vo.Review;

@Controller
public class ReviewController {
	@Autowired
	private ReviewService service;
	
	//리뷰리스트
	@RequestMapping(value = "/reviewList.do")
	public String reviewList(int reqPage, Model model) {
		HashMap<String, Object> pageMap = service.selectReviewList(reqPage);
		model.addAttribute("list",(ArrayList<Review>)pageMap.get("list"));
		model.addAttribute("pageNavi", (String)pageMap.get("pageNavi"));
		model.addAttribute("reqPage", (Integer)pageMap.get("reqPage"));
		model.addAttribute("numPerPage", (Integer)pageMap.get("numPerPage"));
		return "review/reviewList";
	}
	//리뷰조회
	@RequestMapping(value = "/selectOneReviewFrm.do")
	public String selectOneReviewFrm(int reviewNo, int storeNo ,Model model) {
		//조회수 증가
		int result = service.updateView(reviewNo);
		//리뷰테이블 받아오기
		Review r = service.selectOneReview(reviewNo);
		//리뷰넘버에 따른 스토어 이름받아오기
		String storeName = service.selectStoreName(storeNo);
		model.addAttribute("r",r);
		model.addAttribute("storeName", storeName);
		return "review/selectOneReview";
	} 
	//리뷰삭제
	@RequestMapping(value = "/deleteReview.do")
	public String deleteReview(int reviewNo) {
		int result = service.deleteReview(reviewNo);
		if(result>0) {
			return "redirect:/reviewList.do?reqPage=1";
		}else {
			return "redirect:/reviewList.do?reqPage=1";
		}
	}
	
}
