package kr.or.store.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import common.FileRename;
import kr.or.member.model.vo.Member;
import kr.or.order.model.vo.Order;
import kr.or.store.model.service.StoreService;
import kr.or.store.model.vo.Store;
import kr.or.store.model.vo.StoreDetail;
import kr.or.store.model.vo.StorePageData;
import kr.or.product.model.vo.Product;

@Controller
public class StoreController {

	@Autowired
	private StoreService sservice;
	@Autowired
	private FileRename fileRename;
	
	@ResponseBody
	@RequestMapping(value="/storeUpdate.do", produces = "application/json;charset=utf-8")
	public void storeUpdate(Store s) {
		int result = sservice.updateStoreDetail(s);
	}
	

	// ceoStoreInfo 이동 (가게 정보)
	@RequestMapping(value="/ceoStoreInfo.do")
	public String ceoStoreInfo(Model model, HttpSession session){	
		Member member = (Member)session.getAttribute("m");
//		System.out.println(member.getMemberNo());
		ArrayList<Store> list = sservice.selectMemberStore(member);
		model.addAttribute("list",list);
		return "store/ceoStoreInfo";
	}
	
	@RequestMapping(value = "/storeInsert.do")
	public String storeInsert(Store s, MultipartFile storeFile, HttpServletRequest request) {
		if(storeFile != null) {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/img/store/");
				String filename = storeFile.getOriginalFilename();
				String filepath = fileRename.fileRename(savePath, filename);
				
				FileOutputStream fos;
				try {
					fos = new FileOutputStream(new File(savePath+filepath));
					BufferedOutputStream bos = new BufferedOutputStream(fos);
					byte[] bytes = storeFile.getBytes();
					bos.write(bytes);
					bos.close();
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				// 파일 업로드 끝(파일 1개 업로드)
				s.setStoreImg(filepath);
			}
		int result = sservice.insertStore(s);
		System.out.println(s);
		
		return "redirect:/ceoStoreInfo.do";
	}
	
	// 가게 정보 수정창으로 이동
	@RequestMapping(value = "/storeInfoUpdate.do")
	public String storeInfoUpdate(Store s, Model model) {
		Store store = sservice.selectOneStore1(s);
		model.addAttribute("s",store);
		return "store/storeInfoUpdate";
	}
	
	@RequestMapping(value = "/storeInfoUpdateSuccess.do")
	public String storeInfoUpdateSuccess(Store s) {
		Store store = sservice.updateStore(s);
		return "redirect:/ceoStoreInfo.do";
	}
	
	
	// ceoStoreSalesInfo 이동 (판매 정보 관리)
	@RequestMapping(value="/ceoStoreSalesInfo.do")
	public String ceoStoreSalesInfo(Model model) {
		ArrayList<Order> list = sservice.selectAllOrder();
		model.addAttribute("list", list);
		return "/store/ceoStoreSalesInfo";
	}
	
	// 선택한 배송 상태에 따라 정보 출력
	@RequestMapping(value = "/salesInfoSelect.do")
	public String salesInfoSelect(Order o, Model model) {
		ArrayList<Order> list = sservice.selectWhereOrder(o);
		model.addAttribute("list", list);
		return "/store/ceoStoreSalesInfo";
	}
	
	// 상품 배송 상태 변경
	@RequestMapping(value = "/salesInfoUpdate.do")
	public String salesInfoUpdate(Order o) {
		int result = sservice.salesInfoUpdate(o);
		if(result>0) {
			o.setOrderNo(o.getOrderNo());
			o.setOrderState(o.getOrderState());
		}
		return "redirect:/ceoStoreSalesInfo.do";
	}
	// 매장 리스트 출력
	@RequestMapping(value="/allStoreList.do")
	public String allStoreList(int reqPage,Model model,String storeName) {
		StorePageData spd = sservice.selectStoreList(reqPage,storeName);
		//System.out.println(spd);
		model.addAttribute("list",spd.getList());
		model.addAttribute("pageNavi",spd.getPageNavi());
		model.addAttribute("reqPage",spd.getReqPage());
		model.addAttribute("numPerPage", spd.getNumPerPage());
		model.addAttribute("storeName",storeName);
		return "store/storeList";
	}
	//매장 상세페이지
	@RequestMapping(value="/detailStore.do")
	public String detailStore(int storeNo,int memberNo, Model model) {
		//Store s = sservice.selectOneStore2(storeNo);
		//System.out.println(s);
		//model.addAttribute("s",s);
		StoreDetail sd = sservice.selectOneStore2(storeNo,memberNo);
		//System.out.println(sd);
		model.addAttribute("sd",sd);
		return "store/detailStore";
	}
	@ResponseBody 
	@RequestMapping(value="/storeSearch.do", produces = "application/json;charset=utf-8")
	public String storeSearch(String storeName) {
		ArrayList<Store> list = sservice.searchStore(storeName);
		return new Gson().toJson(list);
	}
	
	
	//스토어리스트
	@RequestMapping(value = "/purchaseList.do")
	public String purchaseList(int reqPage,Model model,String storeName) {
		StorePageData spd = sservice.selectStoreList(reqPage,storeName);
		//스토어 검색안된 count
		int count = sservice.countList();
		//스토어 검색됐을때 count
		int countName = sservice.countList(storeName);
		model.addAttribute("list",spd.getList());
		model.addAttribute("pageNavi",spd.getPageNavi());
		model.addAttribute("reqPage",spd.getReqPage());
		model.addAttribute("numPerPage", spd.getNumPerPage());
		model.addAttribute("storeName",storeName);
		model.addAttribute("count", count);
		model.addAttribute("countName", countName);
		return "store/purchaseList";
	}
	//빵이름으로 검색시
	@RequestMapping(value = "/searchBread.do")
	public String searchBread(int reqPage,Model model,String breadName) {
		if(breadName == "") {
			return "redirect:/";
		}
		StorePageData spd = sservice.selectBeadList(reqPage,breadName);
		System.out.println(spd);
		//스토어 검색안된 count
		int count = sservice.countList2(breadName);
		//스토어 검색됐을때 count
		int countName = sservice.countList(breadName);
		model.addAttribute("list",spd.getList());
		model.addAttribute("pageNavi",spd.getPageNavi());
		model.addAttribute("reqPage",spd.getReqPage());
		model.addAttribute("numPerPage", spd.getNumPerPage());
		model.addAttribute("breadName",breadName);
		model.addAttribute("count", count);
		model.addAttribute("countName", countName);
		return "store/searchList";
	}
	
	
	//장바구니 데이터 결제페이지로 이동
	@RequestMapping(value="/orderFrm.do")
	public String orderFrm(int storeNo,int memberNo, String deliveryType,int[] pNo, String[] pName,String[] pContent,
			int[] pStock, int[] pPrice, String[] pImg, Model model) {
		
		//System.out.println(pNo[0]);	
		ArrayList<Product> list = new ArrayList<Product>();
		for(int i=0;i<pName.length;i++) {
			Product p = new Product();
			p.setProductNo(pNo[i]);
			p.setProductName(pName[i]);
			p.setProductContent(pContent[i]);
			p.setProductStock(pStock[i]);
			p.setProductPrice(pPrice[i]);
			p.setProductImg(pImg[i]);
			list.add(p);
		}
		Store s = sservice.selectOrderStore(storeNo);
		model.addAttribute("s",s);
		model.addAttribute("list",list);
		model.addAttribute("storeNo",storeNo);
		model.addAttribute("memberNo",memberNo);
		model.addAttribute("type",deliveryType);
		return "order/order";
	}
	
	@ResponseBody
	@RequestMapping(value="/insertLike.do", produces = "application/json;charset=utf-8")
	public String insertLike(int storeNo, int memberNo) {
		int result = sservice.insertLike(storeNo, memberNo);
		if(result> 0) {
			return "1";
		}else {
			return "0";
		}
	}
	@ResponseBody
	@RequestMapping(value="/deleteLike.do", produces = "application/json;charset=utf-8")
	public String deleteLike(int storeNo, int memberNo) {
		int result = sservice.deleteLike(storeNo,memberNo);
		if(result>0) {
			return "1";
		}else {
			return "0";
		}
	}
	
	@RequestMapping(value="/chooseStoreList.do")
	public String chooseStoreList(int reqPage, int chooseNum,Model model) {
		StorePageData spd = sservice.chooseStoreList(reqPage,chooseNum);
		//스토어 검색안된 count
		int count = sservice.countList();
		//스토어 검색됐을때 count
		//int countName = sservice.countList(storeName);
		model.addAttribute("list",spd.getList());
		model.addAttribute("pageNavi",spd.getPageNavi());
		model.addAttribute("reqPage",spd.getReqPage());
		model.addAttribute("numPerPage", spd.getNumPerPage());
		//model.addAttribute("storeName",storeName);
		model.addAttribute("count", count);
		//model.addAttribute("countName", countName);
		return "store/purchaseList";
	}
}

