package kr.or.product.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product {
	private int productNo;
	private int storeNo;
	private String productName;
	private String productContent;
	private int productPrice;
	private int productStock;
	private String productDate;
	private String productImg;
	private int productSale;
	private int productType;
	private int productCount;
}
