package kr.or.review.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.review.model.vo.Review;

@Repository
public class ReviewDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Review> reviewList() {
		List list =  sqlSession.selectList("review.selectreviewList");
		return (ArrayList<Review>)list;
	}
	
	//리뷰리스트조회
	public ArrayList<Review> selectReviewList(HashMap<String, Object> map) {
		List list = sqlSession.selectList("review.ReviewList", map);
		return (ArrayList<Review>)list;
	}

	public int selectReviewCount() {
		int totalCount = sqlSession.selectOne("review.totalCount");
		return totalCount;
	}

	public Review selectOneReview(int reviewNo) {
		Review r = sqlSession.selectOne("review.selectOneReview", reviewNo);
		return r;
	}

	public String selectStoreName(int storeNo) {
		String storeName = sqlSession.selectOne("review.selectStoreName", storeNo);
		return storeName;
	}

	public int deleteReview(int reviewNo) {
		int result = sqlSession.delete("review.deleteReview", reviewNo);
		return result;
	}

	public int updateView(int reviewNo) {
		int result = sqlSession.update("review.updateView", reviewNo);
		return result;
	}
}
