package kr.or.donate.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.donate.model.service.DonateService;
import kr.or.donate.model.vo.Donate;

@Controller
public class DonateController {
	@Autowired
	private DonateService service;
	
	@RequestMapping(value="/donateMain.do")
	public String donateMain(Model model) {
		ArrayList<Donate> list = service.selectAllDonate();
		model.addAttribute("list", list);
		return "/donate/donateMain";
	}
	@RequestMapping(value = "/donateResult.do")
	public String donateResult() {
		return "/donate/donateResult";
	}
	
}
