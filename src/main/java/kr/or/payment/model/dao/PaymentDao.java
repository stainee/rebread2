package kr.or.payment.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PaymentDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public HashMap<Integer,Integer> selectSalesByStore() {
		List<HashMap<String, Integer>> list = sqlSession.selectList("payment.selectSalesByStore");
		HashMap<Integer, Integer> mapList = new HashMap<Integer, Integer>();

		for(HashMap<String, Integer> map : list) {
			int storeNo = Integer.parseInt(String.valueOf(map.get("STORENO")));
			int sales =  Integer.parseInt(String.valueOf(map.get("SALES")));
			mapList.put(storeNo, sales);
		}
		return mapList;
	}
}
