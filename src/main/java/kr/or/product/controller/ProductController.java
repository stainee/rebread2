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
	public String insertProduct(Product p, MultipartFile upFile, HttpServletRequest request) {
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
			return "redirect:/allStoreList.do?reqPage=1";
			//return "redirect:/detailStore.do?storeNo= "+p.getStoreNo();
			//기존의 상세페이지로 이동시키고 싶은데 안됨..ㅠㅠ 이거는 다시 체크
		}else {
			return "redirect:/";
		}
		
		
	}
	/*
	@RequestMapping(value="/updateProductFrm.do")
	public String updateProductFrm(Model model,String storeName,String storeAddr,int storeNo, ) {
		Product p = service.selectOneProduct(Product);
		
		model.addAttribute("storeNo",storeNo);
		model.addAttribute("storeName",storeName);
		model.addAttribute("storeAddr",storeAddr);
		return "store/updateProductFrm";
	}
	*/
	
	//메인에서 불러오는 product리스트
	@ResponseBody
	@RequestMapping(value="/productList.do", produces = "application/json;charset=utf-8;")
	public String mainProductList(Model model) {
		ArrayList<Product> list = service.mainProductList();
		model.addAttribute("list",list);
		return "";
	}
	
	
}
