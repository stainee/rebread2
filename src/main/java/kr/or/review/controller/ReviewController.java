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
	
	/*
	@RequestMapping(value = "/reviewList.do")
	public String reviewList(Model model) {
		ArrayList<Review> list = service.reviewList();
		model.addAttribute("list",list);
		return "review/reviewList";
	}
	*/
	@RequestMapping(value = "/reviewList.do")
	public String reviewList(int reqPage, Model model) {
		HashMap<String, Object> pageMap = service.selectReviewList(reqPage);
		model.addAttribute("list",(ArrayList<Review>)pageMap.get("list"));
		model.addAttribute("pageNavi", (String)pageMap.get("pageNavi"));
		model.addAttribute("reqPage", (Integer)pageMap.get("reqPage"));
		model.addAttribute("numPerPage", (Integer)pageMap.get("numPerPage"));
		return "review/reviewList";
	}
	
}
