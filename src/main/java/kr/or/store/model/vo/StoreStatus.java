package kr.or.store.model.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class StoreStatus {
	private int storeNo;
	private int memberNo;
	private String storeName;
	private String storeImg;
	private int today;
	private int month;
	private int years;
}