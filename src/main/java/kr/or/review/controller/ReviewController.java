package kr.or.review.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import kr.or.review.model.service.ReviewService;

@Controller
public class ReviewController {
	@Autowired
	private ReviewService service;
}
