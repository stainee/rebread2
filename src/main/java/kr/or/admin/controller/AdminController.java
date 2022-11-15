package kr.or.admin.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.account.model.service.AccountService;
import kr.or.account.model.vo.Account;
import kr.or.cs.model.service.CSService;
import kr.or.cs.model.vo.CSDetail;
import kr.or.cs.model.vo.CSList;
import kr.or.donate.model.service.DonateService;
import kr.or.donate.model.vo.Donate;
import kr.or.member.model.service.MemberService;
import kr.or.member.model.vo.Member;
import kr.or.store.model.service.StoreService;
import kr.or.store.model.vo.Store;
import kr.or.store.model.vo.StoreDetail;
import kr.or.store.model.vo.StoreListDetail;

@Controller
public class AdminController {
	
	@Autowired
	private MemberService memberService;
	@Autowired
	private StoreService storeService;
	@Autowired
	private CSService csService;
	@Autowired
	private AccountService accountService;
	@Autowired
	private DonateService donateService;
	
	@RequestMapping(value="/adminMain.do")
	public String adminMain(){
		return "/admin/adminMain";
	}
	
	@RequestMapping(value="/memberList.do")
	public String memberList(Model model) {
		ArrayList<Member> list = memberService.selectAllMember();
		model.addAttribute("list", list);
		return "/admin/memberList";
	}
	
	@RequestMapping(value="/storeList.do")
	public String sellerList(Model model) {
		ArrayList<Store> list = storeService.selectAllStore();
		model.addAttribute("list",list);
		return "/admin/storeList";
	}
	
	@RequestMapping(value="/csList.do")
	public String csList(Model model) {
		ArrayList<CSList> list = csService.selectAllCS();
		model.addAttribute("list",list);
		return "/admin/csList";
	}
	
	@RequestMapping(value="/donateList.do")
	public String donateList(Model model) {
		ArrayList<Donate> list = donateService.selectAllDonate();
		model.addAttribute("list",list);
		return "/admin/donateList";
	}
	

	@RequestMapping(value="/memberDetail.do")
	public String memberDetail(int memberNo,Model model) {
		Member m = memberService.selectOneMember(memberNo);
		model.addAttribute("m",m);
		return "/admin/memberDetail";
	}
	
	@RequestMapping(value="/CSDetail.do")
	public String csDetail(int csNo, Model model) {
		CSDetail cs = csService.selectOneCS(csNo);
		model.addAttribute("cs", cs);
		return "/admin/csDetail";
	}
	
	@RequestMapping(value="/storeDetail.do")
	public String storeDetail(int storeNo, Model model) {
		StoreDetail sd = storeService.selectOneStore(storeNo);
		model.addAttribute("sd", sd);
		return "/admin/storeDetail";
	}
	
	@RequestMapping(value="/storeListDetail.do")
	public String storeListDetail(int storeNo, Model model) {
		StoreListDetail sld = storeService.selectOneStoreDetail(storeNo);
		model.addAttribute("sd", sld);
		return "/admin/storeDetail";
	}
	
	@RequestMapping(value="/storeAccount.do")
	public String storeAccount(int storeNo, Model model) {
		ArrayList<Account> list = accountService.selectAccountList(storeNo);
		model.addAttribute("list", list);
		return "/admin/storeAccount";
	}
	
	@RequestMapping(value = "/donateDetail.do")
	public String donateDetail() {
		return "/admin/donateDetail";
	}
	
	@RequestMapping(value="/testCallAPI.do")
	public void testCall() {
		accountService.depositToSeller();
	}
}
