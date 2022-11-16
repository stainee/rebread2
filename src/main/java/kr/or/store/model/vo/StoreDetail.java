package kr.or.store.model.vo;

import java.util.ArrayList;

import kr.or.product.model.vo.Product;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class StoreDetail {
	private Store s;
	private ArrayList<Product> lossList;
	private ArrayList<Product> nomalList;
	private Like l;
}
	