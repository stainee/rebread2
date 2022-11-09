package kr.or.payment.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Payment {
	private int paymentNo;
	private int orderNo;
	private int storeNo;
	private String paymentDate;
	private int price;
}
