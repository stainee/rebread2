package kr.or.donate.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.donate.model.service.DonateService;
import kr.or.donate.model.vo.Donate;
import kr.or.member.model.vo.Member;

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
	
	@RequestMapping(value = "/donateMileage.do")
	public String donateMileage(int memberMileage, HttpSession session, int donateSum) {
		int donateSumPlus = memberMileage + donateSum;
		int result = service.donateMileage(donateSumPlus);
		session.setAttribute("memberMileage", memberMileage);
		System.out.println(donateSumPlus);
		System.out.println(donateSum);
		System.out.println(memberMileage);
		return "redirect:/donateMain.do";
	}
	
	@RequestMapping(value = "/donateResult.do")
	public String donateResult() {
		return "/donate/donateResult";
	}
	
}
