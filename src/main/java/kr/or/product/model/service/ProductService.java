package kr.or.product.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.product.model.dao.ProductDao;
import kr.or.product.model.vo.Product;

@Service
public class ProductService {
	@Autowired
	private ProductDao dao;

	public int insertProduct(Product p) {
		return dao.insertProduct(p);
	}

	public ArrayList<Product> mainProductList() {
		return dao.mainProductList();
	}
}
