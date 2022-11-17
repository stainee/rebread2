package kr.or.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.member.model.dao.MemberDao;
import kr.or.member.model.vo.Member;
import kr.or.store.model.vo.StorePageData;
import kr.or.order.model.vo.Order;
import kr.or.order.model.vo.OrderPageData;
import kr.or.review.model.vo.Review;
import kr.or.review.model.vo.ReviewPageData;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import kr.or.product.model.vo.Product;

@Service
public class MemberService {
	
	@Autowired
	private MemberDao dao;

	public ArrayList<Member> selectAllMember() {
		return dao.selectAllMember();
	}

	public Member selectOneMember(int memberNo) {
		return dao.selectOneMember(memberNo);
	}
	
	@Transactional
	public int updateOneMember(Member m) {
		return dao.updateOneMember(m);
	}

	public int deleteOneMember(int memberNo) {
		return dao.deleteOneMember(memberNo);
	}

	public Member selectOneCeo(Member member) {
		return dao.selectOneCeo(member);
	}

	public Member updateCeo(Member m) {
		// TODO Auto-generated method stub
		int result = dao.updateCeo(m);
		if(result>0) {
			Member member = dao.selectOneCeo(m);
			return member;
		}else {
			return null;
		}
	}
	
	//로그인
	public Member loginMember(Member member) {
		Member m = dao.loginMember(member);
		return m;
	}
	//아이디체크
	public Member idCheck(Member m) {
		Member member = dao.idCheck(m);
		return member;
	}
	//회원가입
	public int insertMember(Member m) {
		return dao.insertMember(m);
	}

	
	//문자인증
	public void certifiedPhoneNumber(String userPhoneNumber, int randomNumber) {
		String api_key = "NCSYOLUKOEOQOVTE";	
		//구동시에만 아래의 api-key삭제 후 주석 풀어주시기 바랍니다. (20원씩 날라가요 ㅠㅠ)
		
		//String api_key = "";
	    String api_secret = "XS3HZOGLMQWOUMH1DIPLFUDIREUPD0VR";
	    Message coolsms = new Message(api_key, api_secret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", userPhoneNumber);    // 수신전화번호
	    params.put("from", "01041390974");  // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
	    params.put("type", "SMS");
	    params.put("text", "[리브레드] 인증번호는" + "["+randomNumber+"]" + "입니다."); // 문자 내용 입력
	    params.put("app_version", "test app 1.2"); // application name and version
	    
	    try {
	        JSONObject obj = (JSONObject) coolsms.send(params);
	        System.out.println(obj.toString());
	      } catch (CoolsmsException e) {
	        System.out.println(e.getMessage());
	        System.out.println(e.getCode());
	      }
	}
	
	public ArrayList<Member> searchId(Member m) {
		return dao.searchId(m);
	}

	public Member searchPw(Member m) {
		return dao.searchPw(m);
	}
	
	// 최근주문내역 페이징
	public OrderPageData selectOrderList(int reqPage,int memberNo) {
		// 1. 한 페이지당 보여줄 게시물 수
		int numPerPage = 5;
		// reqPage 1 -> 1~5, reqPage 2 -> 6~10
		int end = reqPage * numPerPage;
		int start = end - numPerPage + 1;
		// 계산한 start, end 이용해서 게시물 목록 조회
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("memberNo", memberNo);
		ArrayList<Order> list = dao.selectOrderList(map);
		// pageNavi 시작
		// 전체 페이지 수 계산필요 -> 전체 게시물 수 조회
		int totalCount = dao.selectOrderCount(memberNo);
		// 전체 페이지 수 계산
		int totalPage = 0;
		if(totalCount % numPerPage == 0) {
			totalPage = totalCount/numPerPage;
		}else {
			totalPage = totalCount/numPerPage+1;
		}
		
		// 페이지 네비 길이
		int pageNaviSize = 5;
		
		int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize + 1;
		if(reqPage>3) {
			pageNo = reqPage-2;
		}
		// pageNavi 생성 시작
		String pageNavi = "";
		
		// 이전버튼
		if(pageNo != 1) {
			pageNavi += "<a href='/memberOrderList.do?memberNo="+memberNo+"&reqPage="+(pageNo-1)+"'><</a>";
		}
		
		// 페이지 숫자 생성
		for(int i=0;i<pageNaviSize;i++) {
			if(pageNo == reqPage) {
				pageNavi += "<span>"+pageNo+"</span>";
			}else {
				pageNavi += "<a href='/memberOrderList.do?memberNo="+memberNo+"&reqPage="+pageNo+"'>"+pageNo+"</a>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		if(pageNo<=totalPage) {
			pageNavi += "<a href='/memberOrderList.do?memberNo="+memberNo+"&reqPage="+pageNo+"'>></a>";
		}
		OrderPageData opd = new OrderPageData(list, pageNavi, reqPage, numPerPage, memberNo, null, null);
		return opd;
	}

	public int updatePwMember(Member m) {
		return dao.updatePwMember(m);
	}

	public Member checkPwMember(Member m) {
		return dao.checkPwMember(m);
	}

	//카카오톡 존재하는 아이디 채크
	public Member searchId(String memberId) {
		Member m = dao.searchId(memberId);
		return m;
	}
	public int insertProfileMember(Member m) {
		return dao.insertProfileMember(m);
	}
	
	public int insertProfileNaver(Member m) {
		return dao.insertProfileNaver(m);
	}
	
	public ArrayList<Member> memberSearch(String searchValue, String searchOption) {
		Member m = new Member();
		if(searchOption.equals("memberId")) {
			m.setMemberId(searchValue);
		}else if(searchOption.equals("memberName")) {
			m.setMemberName(searchValue);
		}
		
		ArrayList<Member> list = dao.memberSearch(m);
		return list;
	}
	
	
	
	// 주문완료 후 memberMileage 가져오기
	public int selectMemberMileage(int memberNo) {
		return dao.selectMemberMileage(memberNo);
	}

	// 최근리뷰 페이징
	public ReviewPageData selectReviewList(int reqPage,String memberId) {
		// 1. 한 페이지당 보여줄 게시물 수
		int numPerPage = 5;
		// reqPage 1 -> 1~5, reqPage 2 -> 6~10
		int end = reqPage * numPerPage;
		int start = end - numPerPage + 1;
		// 계산한 start, end 이용해서 게시물 목록 조회
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("memberId", memberId);
		ArrayList<Review> list = dao.selectReviewList(map);
		// pageNavi 시작
		// 전체 페이지 수 계산필요 -> 전체 게시물 수 조회
		int totalCount = dao.selectReviewCount(memberId);
		// 전체 페이지 수 계산
		int totalPage = 0;
		if(totalCount % numPerPage == 0) {
			totalPage = totalCount/numPerPage;
		}else {
			totalPage = totalCount/numPerPage+1;
		}
		
		// 페이지 네비 길이
		int pageNaviSize = 5;
		
		int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize + 1;
		if(reqPage>3) {
			pageNo = reqPage-2;
		}
		// pageNavi 생성 시작
		String pageNavi = "";
		
		// 이전버튼
		if(pageNo != 1) {
			pageNavi += "<a href='/memberReviewList.do?reviewWriter="+memberId+"&reqPage="+(pageNo-1)+"'><</a>";
		}
		
		// 페이지 숫자 생성
		for(int i=0;i<pageNaviSize;i++) {
			if(pageNo == reqPage) {
				pageNavi += "<span>"+pageNo+"</span>";
			}else {
				pageNavi += "<a href='/memberReviewList.do?reviewWriter="+memberId+"&reqPage="+pageNo+"'>"+pageNo+"</a>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		if(pageNo<=totalPage) {
			pageNavi += "<a href='/memberReviewList.do?reviewWriter="+memberId+"&reqPage="+pageNo+"'>></a>";
		}
		ReviewPageData rpd = new ReviewPageData(list, pageNavi, reqPage, numPerPage, memberId);
		return rpd;
	}

	public int selectMemberMileage(String memberId) {
		return dao.selectMemberMileage(memberId);
	}

	public Review selectOneReview(int reviewNo) {
		return dao.selectOneReview(reviewNo);
	}

	public int memberDeleteReview(int reviewNo) {
		return dao.memberDeleteReview(reviewNo);
	}

	public String selectStoreName(int storeNo) {
		return dao.selectStoreName(storeNo);
	}

	public int updateToken(Member member) {
		return dao.updateToken(member);
	}
	
	public int selectOrderProduct2(int orderNo) {
		return dao.selectOrderProduct2(orderNo);
	}

	public Product selectOrderProduct3(int productNo) {
		return dao.selectOrderProduct3(productNo);
	}


	
	
	
}


























