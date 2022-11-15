package kr.or.order.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderProduct {
	private int orderProductNo;
	private int orderNo;
	private int productNo;
	private int orderProductQuan;
	
}
