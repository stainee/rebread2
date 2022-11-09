package kr.or.store.model.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StorePageData {
	private ArrayList<Store> list;
	private String pageNavi;
	private int reqPage;
	private int numPerPage;

}
