package kr.or.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.member.model.vo.Member;
import kr.or.order.model.vo.Order;
import kr.or.product.model.vo.Product;
import kr.or.review.model.vo.Review;

@Repository
public class MemberDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Member> selectAllMember() {
		List list = sqlSession.selectList("member.selectAllMember");
		return (ArrayList<Member>)list;
	}

	public Member selectOneMember(int memberNo) {
		Member m = sqlSession.selectOne("member.selectOneMember", memberNo);
		return m;
	}

	public int updateOneMember(Member m) {
		return sqlSession.update("member.updateOneMember", m); 
	}

	public int deleteOneMember(int memberNo) {
		return sqlSession.delete("member.deleteOneMember", memberNo);
	}

	public Member selectOneCeo(Member member) {
		Member m = sqlSession.selectOne("member.selectOneCeo",member);
		return m;
	}

	public int updateCeo(Member m) {
		int result = sqlSession.update("member.updateCeo",m);
		return result;
	}
	
	//로그인
	public Member loginMember(Member member) {
		Member m = sqlSession.selectOne("member.loginMember", member);
		return m;
	}
	public Member idCheck(Member m) {
		return sqlSession.selectOne("member.idCheck", m);
	}

	public int insertMember(Member m) {
		return sqlSession.insert("member.insertMember", m);
	}

	public ArrayList<Member> searchId(Member m) {
		List list = sqlSession.selectList("member.searchId", m);
		return (ArrayList<Member>)list;
	}

	public Member searchPw(Member m) {
		return sqlSession.selectOne("member.searchPw", m);
	}


	public ArrayList<Order> selectOrderList(HashMap<String, Object> map) {
		List list = sqlSession.selectList("order.selectOrderList", map);
		return (ArrayList<Order>)list;
	}

	public int selectOrderCount(int memberNo) {
		int totalCount = sqlSession.selectOne("order.totalCount", memberNo);
		return totalCount;
	}

	public int updatePwMember(Member m) {
		return sqlSession.update("member.updatePw",m);
	}

	public Member checkPwMember(Member m) {
		return sqlSession.selectOne("member.pwCheck", m);
	}

	public Member searchId(String memberId) {
		return sqlSession.selectOne("member.kakaoSearchId", memberId);
	}

	public int insertProfileMember(Member m) {
		return sqlSession.insert("member.addProfile", m);
	}
	
	public ArrayList<Member> memberSearch(Member m) {
		List list = sqlSession.selectList("member.memberSearch", m);
		ArrayList<Member> mList = (ArrayList<Member>)list;
		return mList;
	}
	
	public int insertProfileNaver(Member m) {
		return sqlSession.insert("member.addProfileNaver",m);
	}
	
	
	public int selectMemberMileage(int memberNo) {
		return sqlSession.selectOne("member.selectMemberMileage",memberNo);
	}

	public ArrayList<Review> selectReviewList(HashMap<String, Object> map) {
		List list = sqlSession.selectList("review.memberSelectReviewList", map);
		return (ArrayList<Review>)list;
	}

	public int selectReviewCount(String memberId) {
		int totalCount = sqlSession.selectOne("review.memberTotalCount", memberId);
		return totalCount;
	}

	public int selectMemberMileage(String memberId) {
		return sqlSession.selectOne("member.selectMemberIdMileage",memberId);
	}

	public Review selectOneReview(int reviewNo) {
		return sqlSession.selectOne("review.selectOneReview",reviewNo);
	}

	public int memberDeleteReview(int reviewNo) {
		return sqlSession.delete("review.deleteReview",reviewNo);
	}

	public String selectStoreName(int storeNo) {
		return sqlSession.selectOne("review.selectStoreName",storeNo);
	}

	public int selectOrderProduct2(int orderNo) {
		System.out.println("dao : "+orderNo);
		return sqlSession.selectOne("order.selectOrderProduct2",orderNo);
	}

	public Product selectOrderProduct3(int productNo) {
		return sqlSession.selectOne("product.selectOrderProduct2",productNo);
	}


}

