package kr.or.product.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.product.model.vo.Product;

@Repository
public class ProductDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insertProduct(Product p) {
		return sqlSession.insert("product.insertProduct",p);
	}
	
	public ArrayList<Product> selectLossList(int storeNo) {
		List lossList = sqlSession.selectList("product.selectLossList",storeNo);
		return (ArrayList<Product>)lossList ;
	}

	public ArrayList<Product> selectNomalList(int storeNo) {
		List nomalList = sqlSession.selectList("product.selectNomalList",storeNo);
		return (ArrayList<Product>)nomalList;
	}

	public ArrayList<Product> mainProductList() {
		List mainProductList = sqlSession.selectList("product.selectMainList");
		System.out.println(mainProductList);
		return (ArrayList<Product>)mainProductList;
	}
	
}
