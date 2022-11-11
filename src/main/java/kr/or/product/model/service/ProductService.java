package kr.or.product.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.product.model.dao.ProductDao;
import kr.or.product.model.vo.Product;
import kr.or.review.model.vo.Review;

@Service
public class ProductService {
	@Autowired
	private ProductDao dao;

	public int insertProduct(Product p) {
		return dao.insertProduct(p);
	}
	
	public Product selectOneProduct(int productNo) {
		return dao.selectOneProduct(productNo);
	}
	
	public int updateProduct(Product p) {
		return dao.updateProduct(p);
	}
	
	public int deleteProduct(int productNo) {
		return dao.deleteProduct(productNo);
	}

	public ArrayList<Product> mainProductList() {
		return dao.mainProductList();
	}
	public ArrayList<Review> mainReviewList() {
		return dao.mainReviewList();
	}
}
