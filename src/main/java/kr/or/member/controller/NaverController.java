package kr.or.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;

import kr.or.member.model.service.MemberService;
import kr.or.member.model.vo.Member;
import kr.or.member.model.vo.NaverLoginBO;
@Controller
public class NaverController {
	//네이버로그인
			/* NaverLoginBO */
			@Autowired
			private NaverLoginBO naverLoginBO;
			private String apiResult = null;
			@Autowired
			private MemberService service;
			/*
			@Autowired
			private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
				this.naverLoginBO = naverLoginBO;
			}
			*/
			
			//로그인 첫 화면 요청 메소드
			@RequestMapping(value = "/loginFrm.do", method = { RequestMethod.GET, RequestMethod.POST })
			public String login(Model model, HttpSession session) {
				
				/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
				String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
				
				//네이버 
				model.addAttribute("url", naverAuthUrl);
		 
				return "member/loginFrm";
			}
			
		 
			//네이버 로그인 성공시 callback호출 메소드
			@RequestMapping(value = "/naver_callback.do", method = { RequestMethod.GET, RequestMethod.POST })
			public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException {
				
				System.out.println("여기는 callback");
				OAuth2AccessToken oauthToken;
		        oauthToken = naverLoginBO.getAccessToken(session, code, state);
		        
		        //1. 로그인 사용자 정보를 읽어온다.
				String apiResult = naverLoginBO.getUserProfile(oauthToken);  //String형식의 json데이터
				System.out.println("apiResult : " + apiResult);
				/** apiResult json 구조
				{"resultcode":"00",
				 "message":"success",
				 "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
				**/
				
				//2. String형식인 apiResult를 json형태로 바꿈
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(apiResult);
				JSONObject jsonObj = (JSONObject) obj;
				
				System.out.println("jsonObj = " + jsonObj);
				//3. 데이터 파싱 
				//Top레벨 단계 _response 파싱
				JSONObject response_obj = (JSONObject)jsonObj.get("response");
				String access_token = oauthToken.getAccessToken(); //토큰
				
				
				//response의 nickname값 파싱
				String memberId = (String)response_obj.get("id");
				String memberName = (String)response_obj.get("name");
				String memberMail = (String)response_obj.get("email");
				String memberPw = memberId;
				Member user = service.searchId(memberId);
				
				// 세션 생성
				session.setAttribute("result", response_obj);
				String str_result = access_token.replaceAll("\\\"","");
				session.setAttribute("access_token", str_result);
				System.out.println(session);
				
				Member m =new Member();
				if(user==null) {
	            	//신규회원가입인경우
	            	m.setMemberId(memberId);
	            	m.setMemberName(memberName);
	            	m.setMemberMail(memberMail);
	            	m.setMemberPw(memberPw);
	            	model.addAttribute("m", m);
	            	return "member/addPropilFrm2";
	            }else {
	            	//신규회원이 아닌경우
	            	session.setAttribute("m", user);
	            	return "redirect:/";
	            }
			}
			
			
		//네이버 로그아웃하기
		@GetMapping("/removeNaver.do") //token = access_token임
		public String remove(@RequestParam String token, HttpSession session, HttpServletRequest request, Model model ) {
				
			String apiUrl = "https://nid.naver.com/oauth2.0/token?grant_type=delete&client_id="+NaverLoginBO.CLIENT_ID+
			"&client_secret="+NaverLoginBO.CLIENT_SECRET+"&access_token="+token.replaceAll("'", "")+"&service_provider=NAVER";
				
				try {
					String res = requestToServer(apiUrl);
					model.addAttribute("res", res); //결과값 찍어주는용
					session.invalidate();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
					
				return "redirect:/";
			}
		private String requestToServer(String apiURL) throws IOException {
		    return requestToServer(apiURL, null);
		}
		
		private String requestToServer(String apiURL, String headerStr) throws IOException {
		    URL url = new URL(apiURL);
		    HttpURLConnection con = (HttpURLConnection)url.openConnection();
		    con.setRequestMethod("GET");
		    System.out.println("header Str: " + headerStr);
		    if(headerStr != null && !headerStr.equals("") ) {
		      con.setRequestProperty("Authorization", headerStr);
		    }
		    int responseCode = con.getResponseCode();
		    BufferedReader br;
		    System.out.println("responseCode="+responseCode);
		    if(responseCode == 200) { // 정상 호출
		      br = new BufferedReader(new InputStreamReader(con.getInputStream()));
		    } else {  // 에러 발생
		      br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
		    }
		    String inputLine;
		    StringBuffer res = new StringBuffer();
		    while ((inputLine = br.readLine()) != null) {
		      res.append(inputLine);
		    }
		    br.close();
		    if(responseCode==200) {
		    	String new_res=res.toString().replaceAll("&#39;", "");
				 return new_res; 
		    } else {
		      return null;
		    }
		}
}
