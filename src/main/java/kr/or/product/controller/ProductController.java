package kr.or.product.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

import javax.mail.Store;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.multipart.MultipartResolver;

import com.google.gson.Gson;

import common.FileRename;
import kr.or.product.model.service.ProductService;
import kr.or.product.model.vo.Product;
import kr.or.review.model.vo.Review;

@Controller
public class ProductController {
	@Autowired
	private ProductService service;
	@Autowired
	private FileRename fileRename;
	
	@RequestMapping(value="/insertProductFrm.do")
	public String insertProductFrm(Model model,String storeName,String storeAddr,int storeNo) {
		model.addAttribute("storeNo",storeNo);
		model.addAttribute("storeName",storeName);
		model.addAttribute("storeAddr",storeAddr);
		return "store/insertProductFrm";
	}
	
	@RequestMapping(value="/insertProduct.do")
	public String insertProduct(Product p, MultipartFile upFile, int memberNo, HttpServletRequest request) {
		//System.out.println(p);
		
		if(upFile != null) {
			
			//저장될 파일 경로 지정하기
			String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/product/");
			
			String filename= upFile.getOriginalFilename();
			String filepath = fileRename.fileRename(savePath, filename);
			
			try {
				FileOutputStream fos = new FileOutputStream(new File(savePath+filepath));
				BufferedOutputStream bos = new BufferedOutputStream(fos);
				
				byte[] bytes = upFile.getBytes();
				bos.write(bytes);
				bos.close();
				
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			p.setProductImg(filepath);
		}
		int result = service.insertProduct(p);
		if(result>0) {
			return "redirect:/detailStore.do?storeNo="+p.getStoreNo()+"&memberNo="+memberNo;

		}else {
			return "redirect:/";
		}
		
		
	}
	@RequestMapping(value="/updateProductFrm.do")
	public String updateProductFrm(Model model,String storeName,String storeAddr,int storeNo,int productNo ) {
		//Product p = service.selectOneProduct(Product);
//		System.out.println("스토어이름?"+storeName);
//		System.out.println("스토어주소?"+storeAddr);
//		System.out.println("스토어번호?"+storeNo);
//		System.out.println("제품번호?"+productNo);
		Product p = service.selectOneProduct(productNo);
		
		System.out.println(p);
		model.addAttribute("storeNo",storeNo);
		model.addAttribute("storeName",storeName);
		model.addAttribute("storeAddr",storeAddr);
		model.addAttribute("p",p);
		return "store/updateProductFrm";
	}
	
	@RequestMapping(value="/updateProduct.do")
	public String updateProduct(Product p,int memberNo,MultipartFile upFile, HttpServletRequest request, String status,String oldImg) {
		
		System.out.println("업데이트할 상품 번호 : "+p.getProductNo());
		//저장 경로
		String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/product/");
		
		if(!upFile.isEmpty()) {
					
			String filename= upFile.getOriginalFilename();
			String filepath = fileRename.fileRename(savePath, filename);
					
			try {
				FileOutputStream fos = new FileOutputStream(new File(savePath+filepath));
				BufferedOutputStream bos = new BufferedOutputStream(fos);
						
				byte[] bytes = upFile.getBytes();
				bos.write(bytes);
				bos.close();
						
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			p.setProductImg(filepath);
			
		}else if(oldImg != null && status.equals("stay")) {
			p.setProductImg(oldImg);
		}
		int result = service.updateProduct(p);
		
		if(result>0) {
			return "redirect:/detailStore.do?storeNo="+p.getStoreNo()+"&memberNo="+memberNo;
		}else {
			return "redirect:/allStoreList.do?reqPage=1";
		}

		
	}
	
	@RequestMapping(value="/deleteProduct.do")
	public String deleteProduct(int productNo,int storeNo,int memberNo) {
		int result = service.deleteProduct(productNo);
		if(result >0) {
			return "redirect:/detailStore.do?storeNo="+storeNo+"&memberNo="+memberNo;
		}else {
			return "redirect:/allStoreList.do?reqPage=1";
		}
	}
	
	//메인에서 불러오는 product리스트
	@RequestMapping(value = "/DoMain.do")
	public String mainDo(Model model) {
		ArrayList<Product> list = service.mainProductList();
		model.addAttribute("list", list);
		ArrayList<Review> reviewList = service.mainReviewList();
		model.addAttribute("reviewList", reviewList);
		return "common/main";
	}
	
	
}
