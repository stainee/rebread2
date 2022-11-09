package kr.or.donate.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.donate.model.service.DonateService;

@Controller
public class DonateController {
	@Autowired
	private DonateService service;
	
	@RequestMapping(value="/donateMain.do")
	public String donateMain() {
		return "/donate/donateMain";
	}
	@RequestMapping(value = "/donateResult.do")
	public String donateResult() {
		return "/donate/donateResult";
	}
	
}
