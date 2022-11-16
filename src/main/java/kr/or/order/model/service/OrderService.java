package kr.or.order.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Service;

import kr.or.order.model.dao.OrderDao;
import kr.or.order.model.vo.Order;
import kr.or.order.model.vo.OrderProduct;
import kr.or.product.model.vo.Product;

@Service
public class OrderService {
	@Autowired
	private OrderDao dao;

	// 결제 전 배송지 정보 DB 저장
	public int insertOrder(Order o) {
		int result = dao.insertOrder(o);
		// 주문 회원 마일리지 추가
		dao.orderMemberMileage(o);
		return result;
	}

	// paymentKey 저장 위해 orderNo 조회
	public int searchOrderNo() {
		int orderNo = dao.searchOrderNo();
		return orderNo;
	}

	// paymentKey DB 저장
	public int updatePaymentKey(Order o) {
		int result = dao.updatePaymentKey(o);
		return result;
	}

	public Order selectOneOrder(int orderNo) {
		Order o = dao.selectOneOrder(orderNo);
		return o;
	}

	public String selectPaymentKey(int orderNo) {
		String paymentKey = dao.selectPaymentKey(orderNo);
		return paymentKey;
	}

	public void updateOrderState(int orderNo) {
		// 주문 상태 업데이트
		dao.updateOrderState(orderNo);
		
		// 주문 취소 위해 적립예정인 마일리지 값 가져오기
		int orderMileage = dao.selectOrderMileage(orderNo);
		// 주문 취소 후 적립예정인 회원 마일리지 취소 위해 회원번호 받아옴 
		int memberNo = dao.selectOrderMember(orderNo);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memberNo", memberNo);
		map.put("orderMileage", orderMileage);
		// 주문 취소한 회원 마일리지 차감
		dao.cancelMemberMileage(map);
	}

	public int selectMemberMileage(int memberNo) {
		int memberMileage = dao.selectMemberMileage(memberNo);
		return memberMileage;
	}

	// payment에 넣을 price값 가져오기
	public int selectOrderPrice(int orderNo) {
		return dao.selectOrderPrice(orderNo);
	}

	public int insertPayment(Order o) {
		return dao.insertPayment(o);
	}

	public int insertOrderProduct(OrderProduct op) {
		return dao.insertOrderProduct(op);
	}

	public ArrayList<OrderProduct> selectOrderProduct(int orderNo) {
		return dao.selectOrderProduct(orderNo);
	}

	public Product selectOrderProduct2(int productNo) {
		return dao.selectOrderProduct2(productNo);
	}

	//insert 토큰
	public int insertToken(int memberNo) {
		return dao.insertToken(memberNo);
	}
	//del 토큰
	public int deleteToken(int memberNo) {
		return dao.deleteToken(memberNo);
	}

	
}
