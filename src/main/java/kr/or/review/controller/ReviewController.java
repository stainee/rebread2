package kr.or.review.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import common.FileRename;
import kr.or.review.model.service.ReviewService;
import kr.or.review.model.vo.Review;

@Controller
public class ReviewController {
	@Autowired
	private ReviewService service;
	@Autowired
	private FileRename fileRename;
	
	//리뷰리스트
	@RequestMapping(value = "/reviewList.do")
	public String reviewList(int reqPage, Model model) {
		HashMap<String, Object> pageMap = service.selectReviewList(reqPage);
		model.addAttribute("list",(ArrayList<Review>)pageMap.get("list"));
		model.addAttribute("pageNavi", (String)pageMap.get("pageNavi"));
		model.addAttribute("reqPage", (Integer)pageMap.get("reqPage"));
		model.addAttribute("numPerPage", (Integer)pageMap.get("numPerPage"));
		return "review/reviewList";
	}
	//리뷰조회
	@RequestMapping(value = "/selectOneReviewFrm.do")
	public String selectOneReviewFrm(int reviewNo, int storeNo ,Model model) {
		//조회수 증가
		int result = service.updateView(reviewNo);
		//리뷰테이블 받아오기
		Review r = service.selectOneReview(reviewNo);
		//리뷰넘버에 따른 스토어 이름받아오기
		String storeName = service.selectStoreName(storeNo);
		model.addAttribute("r",r);
		model.addAttribute("storeName", storeName);
		return "review/selectOneReview";
	} 
	//리뷰삭제
	@RequestMapping(value = "/deleteReview.do")
	public String deleteReview(int reviewNo) {
		int result = service.deleteReview(reviewNo);
		if(result>0) {
			return "redirect:/reviewList.do?reqPage=1";
		}else {
			return "redirect:/reviewList.do?reqPage=1";
		}
	}
	
	//가게 리뷰 불러오기& 리뷰를 등록할 수 있는 카운트 불러오기
	@ResponseBody
	@RequestMapping(value="/selectReview.do", produces = "application/json;charset=utf-8")
	public String selectReveiw(int storeNo, int memberNo) {
		ArrayList<Review> list = service.selectStoreReview(storeNo);
		int count = service.selectCountReview(storeNo,memberNo);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list",list);
		map.put("count",count);
		return new Gson().toJson(map);
	}
	
	//리뷰 작성
	@RequestMapping(value="/insertReview.do")
	public String insertReview(Review r,MultipartFile upFile,int memberNo,HttpServletRequest request) {
		//System.out.println(r.getReviewWriter());
		
		if(upFile != null) {
			//저장될 파일 경로 지정하기
			String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/review/");	
			String filename= upFile.getOriginalFilename();
			String filepath = fileRename.fileRename(savePath, filename);
				
			try {
				FileOutputStream fos = new FileOutputStream(new File(savePath+filepath));
				BufferedOutputStream bos = new BufferedOutputStream(fos);
				
				byte[] bytes = upFile.getBytes();
				bos.write(bytes);
				bos.close();
					
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			r.setReviewImg(filepath);
		}
		int result = service.insertReview(r);
		if(result>0) {
			return "redirect:/detailStore.do?storeNo="+r.getStoreNo()+"&memberNo="+memberNo;
		}else {
			return "redirect:/";
		}
	}
	//이벤트 페이지 이동
	@RequestMapping(value = "/eventFrm.do")
	public String eventFrm() {
		return "common/event";
	}
	//룰렛 이벤트로 이동
	@RequestMapping(value = "/rollet.do")
	public String rollet() {
		return "common/rollet";
	}
	
	//근데 ajax로 할걸 
	//매장 리뷰 삭제 후 기존의 가게 상세페이지로 이동
	@RequestMapping(value="deleteStoreReview.do")
	public String deleteStoreReview(int reviewNo, int memberNo, int storeNo) {
		int result = service.deleteReview(reviewNo);
		if(result>0) {
			return "redirect:/detailStore.do?storeNo="+storeNo+"&memberNo="+memberNo;
		}else {
			return "redirect:/detailStore.do?storeNo="+storeNo+"&memberNo="+memberNo;
		}
	}
}
