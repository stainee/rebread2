package kr.or.store.model.vo;

import java.util.ArrayList;

import kr.or.product.model.vo.Product;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class StoreListDetail {
	private int storeNo;
	private int memberNo;
	private String memberName;
	private String storeName;
	private String storeContent;
	private String storeAddr;
	private String storeRegistNum;
	private String storeAccount;
	private String openTime;
	private String closeTime;
	private String storePhone;
	private String storeImg;
}
