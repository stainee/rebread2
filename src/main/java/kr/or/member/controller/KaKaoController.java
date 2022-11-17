package kr.or.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.member.model.service.KakaoService;
import kr.or.member.model.service.MemberService;
import kr.or.member.model.vo.Member;

@Controller
public class KaKaoController {
	
	@Autowired
	private KakaoService kakaoService;
	@Autowired
	private MemberService memberService;
	
	//카카오톡 로그인	
    @RequestMapping(value="/kakao_login.do")
    public String kakaoLogin() {
        StringBuffer loginUrl = new StringBuffer();
        loginUrl.append("https://kauth.kakao.com/oauth/authorize?client_id=");
        loginUrl.append("e584f1ee2e73e2ce140d7006c3f82405"); 
        loginUrl.append("&redirect_uri=");
        loginUrl.append("http://192.168.10.64/kakao_callback.do"); 
        loginUrl.append("&response_type=code");
        return "redirect:"+loginUrl.toString();
    }
    
    //카카오톡 토큰받아오기
    @RequestMapping(value = "/kakao_callback.do", method = RequestMethod.GET)
    public String redirectkakao(@RequestParam String code, HttpSession session, Model model) throws IOException {
            
            //접속토큰 get
            String kakaoToken = kakaoService.getReturnAccessToken(code);
            //접속자 정보 get
            Map<String,Object> result = kakaoService.getUserInfo(kakaoToken);
            String memberId = (String)result.get("memberId");
            String memberName = (String)result.get("memberName");
            //String memberMail = (String)result.get("memberMail");
            String memberPw = memberId;
            Member user = memberService.searchId(memberId);
            
            Member m = new Member();
            if(user==null) {
            	//신규회원가입인경우
            	m.setMemberId(memberId);
            	m.setMemberName(memberName);
            	//m.setMemberMail(memberMail);
            	m.setMemberPw(memberPw);
            	 /*로그아웃 처리 시, 사용할 토큰 값*/
            	model.addAttribute("m", m);
            	return "member/addPropilFrm";
            }else {
            	//신규회원이 아닌경우
            	session.setAttribute("m", user);
            	 /*로그아웃 처리 시, 사용할 토큰 값*/
            	session.setAttribute("kakaoToken", kakaoToken);
            	return "redirect:/";
            }
           
    }
    //카카오톡 로그아웃하기
	@RequestMapping(value="/kakaologout.do")
	public String logout(HttpSession session) {
		kakaoService.logout((String)session.getAttribute("kakaoToken"));
		session.invalidate();
		return "redirect:/";
	}

}
























