package kr.or.order.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Order {
	private int orderNo;
	private int memberNo;
	private int storeNo;
	private String orderState;
	private String orderDate;
	private int orderTotalQuan;
	private int orderPrice;
	private String orderName;
	private String orderAddr;
	private String orderPhone;
	private int orderMileage;
	private String paymentKey;
	private String storeName;
}
