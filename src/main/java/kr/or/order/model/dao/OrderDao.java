package kr.or.order.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.order.model.vo.Order;
import kr.or.order.model.vo.OrderProduct;
import kr.or.product.model.vo.Product;
import kr.or.store.model.vo.Store;

@Repository
public class OrderDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int insertOrder(Order o) {
		int result = sqlSession.insert("order.insertOrder",o);
		return result;
	}
	
	// 주문 성공 마일리지
	public int orderMemberMileage(Order o) {
		return sqlSession.update("member.orderMemberMileage",o);
	}
	
	public int searchOrderNo() {
		int orderNo = sqlSession.selectOne("order.searchOrderNo");
		return orderNo;
	}

	public int updatePaymentKey(Order o) {
		int result = sqlSession.update("order.updatePaymentKey",o);
		return result;
	}

	public Order selectOneOrder(int orderNo) {
		return sqlSession.selectOne("order.selectOneOrder",orderNo);
	}

	// 주문 취소 위해 paymentKey값 찾아오기
	public String selectPaymentKey(int orderNo) {
		return sqlSession.selectOne("order.selectPaymentKey",orderNo);
	}
	
	// 주문 취소 후 주문상태 변경
	public void updateOrderState(int orderNo) {
		sqlSession.update("order.updateOrderState",orderNo);
	}
	
	// 주문 취소시 마일리지 롤백 위해 memberNo값 받아옴
	public int selectOrderMember(int orderNo) {
		return sqlSession.selectOne("order.selectOrderMember",orderNo);
	}
	
	// 주문 취소 마일리지
	public int selectOrderMileage(int orderNo) {
		return sqlSession.selectOne("order.selectOrderMileage",orderNo);
	}

	public void cancelMemberMileage(HashMap<String, Object> map) {
		sqlSession.update("member.cancelMemberMileage",map);
	}

	public int selectMemberMileage(int memberNo) {
		return sqlSession.selectOne("member.selectMemberMileage",memberNo);
	}

	public Order selectOrderPrice(int orderNo) {
		return sqlSession.selectOne("order.selectOrderPrice",orderNo);
	}

	public int insertPayment(Order o) {
		return sqlSession.insert("payment.insertPayment",o);
	}

	public int insertOrderProduct(OrderProduct op) {
		return sqlSession.insert("order.insertOrderProduct",op);
	}

	public ArrayList<OrderProduct> selectOrderProduct(int orderNo) {
		List list = sqlSession.selectList("order.selectOrderProduct",orderNo);
		return (ArrayList<OrderProduct>)list;
	}

	public Product selectOrderProduct2(int productNo) {
		return sqlSession.selectOne("product.selectOrderProduct2",productNo);
	}
	
	
	//토큰 insert
	public int insertToken(int memberNo) {
		return sqlSession.update("member.insertToken", memberNo);
	}
	//토큰 del
	public int deleteToken(int memberNo) {
		return sqlSession.update("member.deleteToken", memberNo);
	}

	public Store selectOrderStore(int storeNo) {
		return sqlSession.selectOne("store.selectOrderStore",storeNo);
	}

	

}
