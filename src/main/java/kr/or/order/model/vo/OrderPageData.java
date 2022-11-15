package kr.or.order.model.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderPageData {
	private ArrayList<Order> list;
	private String pageNavi;
	private int reqPage;
	private int numPerPage;
	private int memberNo;
	private String productImg;
	private String productName;
}
