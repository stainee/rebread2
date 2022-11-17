package kr.or.member.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.google.gson.Gson;

import kr.or.member.model.service.MemberService;
import kr.or.member.model.vo.Member;
import kr.or.order.model.vo.OrderPageData;
import kr.or.product.model.vo.Product;
import kr.or.review.model.vo.Review;
import kr.or.review.model.vo.ReviewPageData;
import kr.or.store.model.vo.Store;
import kr.or.store.model.vo.StorePageData;
import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class MemberController {

	@Autowired
	private MemberService service;
	
	@RequestMapping(value="/memberModify.do")
	public String memberModify(int memberNo,Model model) {
		Member m = service.selectOneMember(memberNo);
		model.addAttribute("m",m);
		return "/admin/memberModify";
	}
	
	@ResponseBody
	@RequestMapping(value="/memberUpdate.do", produces = "application/json;charset=utf-8")
	public void memberUpdate(Member m) {
		int result = service.updateOneMember(m);
	}
	
	
	//회원탈퇴
	@RequestMapping(value="/memberDelete.do")
	public String memberDelete(int memberNo, HttpSession session) {
		System.out.println(memberNo);
		int result = service.deleteOneMember(memberNo);
		if(result>0) {
			session.invalidate();
			return "redirect:/";
		}else {
			return "redirect:/";
		}
	}
	
	@RequestMapping(value="/brandIntro.do")
	public String brandIntro() {
		return "/member/brandIntro";
	}
	
	@RequestMapping(value="/customerService.do")
	public String customerService() {
		return "/member/customerService";
	}
	
	// memberMain(마이페이지) 이동
	@RequestMapping(value="/memberMain.do")
	public String memberMain(int memberNo, HttpSession session) {
		// memberMileage 구하기
		int memberMileage = service.selectMemberMileage(memberNo);
		session.setAttribute("memberMileage", memberMileage);
		return "member/memberMain";
	}
	
	// memberOrderList 이동
	@RequestMapping(value="/memberOrderList.do")
	public String memberOrderList(int reqPage, int memberNo, Model model, HttpSession session) {
		OrderPageData opd = service.selectOrderList(reqPage, memberNo);
		// 리스트가 존재할 때에 model에 저장
		if(!opd.getList().isEmpty()) {
			for(int i=0;i<opd.getList().size();i++) {
				System.out.println(opd.getList().get(i).getOrderNo());
				int productNo = service.selectOrderProduct2(opd.getList().get(i).getOrderNo());
				System.out.println(productNo);
				
				Product p = service.selectOrderProduct3(productNo);
				opd.setProductImg(p.getProductImg());
				opd.setProductName(p.getProductName());
				
				model.addAttribute("productImg",opd.getProductImg());
				model.addAttribute("productName",opd.getProductName());
			}
			model.addAttribute("list", opd.getList());
			model.addAttribute("pageNavi",opd.getPageNavi());
			model.addAttribute("reqPage",opd.getReqPage());
			model.addAttribute("numPerPage",opd.getNumPerPage());
			model.addAttribute("memberNo",opd.getMemberNo());
			
		}
		// memberMileage 구하기
		int memberMileage = service.selectMemberMileage(memberNo);
		session.setAttribute("memberMileage", memberMileage);
		return "member/memberOrderList";
	}
	
	// memberReviewList 이동
	@RequestMapping(value="/memberReviewList.do")
	public String memberReviewList(int reqPage, String reviewWriter, Model model, HttpSession session) {
		ReviewPageData rpd = service.selectReviewList(reqPage, reviewWriter);
		// 리스트가 존재할 때에 model에 저장
		if(!rpd.getList().isEmpty()) {
		model.addAttribute("list", rpd.getList());
		model.addAttribute("pageNavi", rpd.getPageNavi());
		model.addAttribute("reqPage", rpd.getReqPage());
		model.addAttribute("numPerPage", rpd.getNumPerPage());
		model.addAttribute("memberId", rpd.getMemberId());
		}
		// memberMileage 구하기
		int memberMileage = service.selectMemberMileage(reviewWriter);
		session.setAttribute("memberMileage", memberMileage);
		return "member/memberReviewList";
	}
	
	// memberReviewDetail 이동
	@RequestMapping(value="/memberReviewDetail.do")
	public String memberReviewDetail(int reviewNo, int reqPage, Model model, HttpSession session) {
		Review r = service.selectOneReview(reviewNo);
		String storeName = service.selectStoreName(r.getStoreNo());
		model.addAttribute("r",r);
		model.addAttribute("reqPage",reqPage);
		model.addAttribute("storeName", storeName);
		
		// memberMileage 구하기
		int memberMileage = service.selectMemberMileage(r.getReviewWriter());
		session.setAttribute("memberMileage", memberMileage);
		return "member/memberReviewDetail";
	}
	
	// memberDeleteReview 멤버리뷰삭제
	@RequestMapping(value="/memberDeleteReview.do")
	public String memberDeleteReview(int reviewNo,String reviewWriter, int reqPage, Model model) {
		Review r = service.selectOneReview(reviewNo);
		model.addAttribute("r",r);
		int result = service.memberDeleteReview(reviewNo);
		if(result>0) {
			return "redirect:/memberReviewList.do?reviewWriter="+reviewWriter+"&reqPage="+reqPage;
		}else {
			return "redirect:/";
		}
	}
	
	@RequestMapping(value="/chatting.do")
	public String chatting() {
		return "/member/csChat";
	}
	
	
	//joinStep이동f
	@RequestMapping(value = "/joinStep.do")
	public String joinStep() {
		return "/member/joinStep";
	};
	//joinFrm이동
	@RequestMapping(value = "/joinFrm.do")
	public String joinFrm() {
		return "member/joinFrm";
	}
	
	//login
	@RequestMapping(value = "/login.do")
	public String login(Member member, HttpSession session) {
		Member m = service.loginMember(member);
		if(m!=null) {
			session.setAttribute("m", m);
			session.setAttribute("errMsg", "");
			return "redirect:/";
		}else {
			session.setAttribute("errMsg", "아이디 또는 패스워드가 일치하지 않습니다.");
			return "member/loginFrm";
		}
	}
	//logout
	@RequestMapping(value = "/logout.do")
	public String logOut(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	//joinSuccess이동
	@RequestMapping(value = "joinSuccess")
	public String joinSuccess() {
		return "member/joinSuccess";
	}
	//중복된 아이디체크
	@ResponseBody
	@RequestMapping(value = "/idCheck.do")
	public String idCheck(Member m) {
		Member member = service.idCheck(m);
		if(member == null) {
			return "0";
		}else {
			return "1";
		}
	}
	//회원가입
	@RequestMapping(value = "/join.do")
	public String join(Member m ) {
		int result = service.insertMember(m);
		if(result >0) {
			return "member/loginFrm";
		}else {
			return "redirect:/";
		}
	}
	
	//전화번호 문자인증
	@RequestMapping(value = "/phoneCheck.do", method = RequestMethod.GET)
	@ResponseBody
	public String sendSMS(@RequestParam("phone") String userPhoneNumber) { 
		// 휴대폰 문자보내기
		int randomNumber = (int)((Math.random()* (9999 - 1000 + 1)) + 1000);
		//난수 생성
		service.certifiedPhoneNumber(userPhoneNumber,randomNumber);
		return Integer.toString(randomNumber);
	}
	//searchId이동
	@RequestMapping(value = "/searchId.do")
	public String searchIdFrm() {
		return "member/searchId";
	}
	//searchId1
	@RequestMapping(value = "/seachId1.do")
	public String searchId(Member m, Model model) {
		ArrayList<Member> list = service.searchId(m);
		if(list.isEmpty()) {
			return "member/searchId";
		}else {
			model.addAttribute("list",list);
			return "member/searchIdList";
		}
	}
	//searchPw이동
	@RequestMapping(value = "/searchPw.do")
	public String searchPwFrm() {
		return "member/searchPw";
	}
	//searchPw1
	@RequestMapping(value = "/searchPw1.do", method = RequestMethod.GET)
	public String searchPw(Member m, Model model) {
		Member member = service.searchPw(m);
		if(member == null) {
			return "member/searchPw";
		}else {
			model.addAttribute("m", member);
			return "member/searchPwList";
		}
	}
	//패스워드변경
	@ResponseBody
	@RequestMapping(value = "/changePw.do" , produces = "application/json;charset=utf-8")
	public String updatePw(Member m ) {
		int result = service.updatePwMember(m);
		System.out.println(result);
		if(result>0) {
			return "0";
		}else {
			return "1";
		}
	}
	//기존 패스워드와 동일 여부
	@ResponseBody
	@RequestMapping(value = "/checkPw.do", produces = "application/json;charset=utf-8")
	public String pwCheck(Member m) {
		Member member = service.checkPwMember(m);
		if(member == null) {
			//사용가능
			return "0";
		}else {
			//사용중임
			return "1";
		}
	}
	//카카오톡 회원가입 2단계
		@RequestMapping(value = "/addProfil.do")
		public String addProfile(Member m, HttpSession session) {
		int result = service.insertProfileMember(m);
		if(result > 0) {
			return "member/loginFrm";
		}else {
			return "redirect:/";
		}
	}
	//네이버 로그아웃 2단계
		@RequestMapping(value = "/addProfileNaver.do")
		public String addProfileNaver(Member m, HttpSession session) {
			int result = service.insertProfileNaver(m);
			if(result >0) {
				return "redirect:/loginFrm.do";
			}else {
				return "redirect:/";
			}
		}
	//카카오로그아웃 choose
	@RequestMapping(value = "/logoutChoose.do")
	public String logoutChoose() {
		return "member/logoutChoose";
	}
		
		
	@ResponseBody
	@RequestMapping(value="/memberSearch.do", produces = "application/json;charset=utf-8")
	public String memberSearch(String searchValue, String searchOption) {
		ArrayList<Member> list = service.memberSearch(searchValue, searchOption);
		return new Gson().toJson(list);
	}
		
		
	// ceoMain 이동 (판매자 정보)
	@RequestMapping(value="/ceoMain.do")
	public String ceoMain() {
		return "member/ceoMain";
	}
	// 판매자 정보 수정
	@RequestMapping(value = "/updateCeo.do")
	public String updateCeo(Member m, HttpSession session) {
		Member member = service.updateCeo(m);
		if(member != null) {
			session.setAttribute("m", member);
			return "member/ceoMain";
		}else {
			return "redirect:/";
		}
	}
	//관리자 정보 수정
	@RequestMapping(value = "/updateAdim.do")
	public String updateAdmin(Member m, HttpSession session) {
		Member member = service.updateCeo(m);
		if(member != null) {
			session.setAttribute("m", member);
			return "admin/adminMain";
		}else {
			return "redirect:/";
		}
	}
	//회원마이페이지 수정
	@RequestMapping(value = "/updateMembers.do")
	public String updateMembers(Member m, HttpSession session) {
		Member member = service.updateCeo(m);
		if(member != null) {
			session.setAttribute("m", member);
			return "member/memberMain";
		}else {
			return "redirect:/";
		}
	}
	
	//토큰수정 및 마일리지 추가
	@ResponseBody
	@RequestMapping(value = "/rolletEvent.do", produces = "application/json;charset=utf-8")
	public String updateMile(int token, String memberId, @SessionAttribute Member m) {
		Member member = new Member();
		member.setMemberMileage(token);
		member.setMemberId(memberId);
		System.out.println(member);
		int result = service.updateToken(member);
		if(result>0) {
			m.setToken(m.getToken()-1);
			m.setMemberMileage(m.getMemberMileage()+token);
			Gson gson = new Gson();
			String ms = gson.toJson(m);
			return ms;
		}else {
			return "redirect:/";
		}
	}
	
	
}

























