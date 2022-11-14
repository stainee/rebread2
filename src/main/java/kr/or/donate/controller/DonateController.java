package kr.or.donate.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

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
	public String donateMileage(Donate d, int donateVal, int donateSumVal, Model model, @SessionAttribute(required = false) Member m) { // @SessionAttribute(required = false) -> 로그인 안하면 접근 못하도록 막음
		int donateSumPlus = donateVal + donateSumVal;
		d.setDonateSumPlus(donateSumPlus);
		
		int result = service.donateMileage(d, donateVal, m.getMemberMileage(), m.getMemberNo());
		if(result>0) {			
			m.setMemberMileage(m.getMemberMileage()-donateVal);
		}
		model.addAttribute("donateVal", donateVal);
		return "/donate/donateResult";
	}
	
}
