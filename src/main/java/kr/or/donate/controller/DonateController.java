package kr.or.donate.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import common.FileRename;
import kr.or.donate.model.service.DonateService;
import kr.or.donate.model.vo.Donate;
import kr.or.member.model.vo.Member;

@Controller
public class DonateController {
	@Autowired
	private DonateService service;
	@Autowired
	private FileRename fileRename;
	
	@RequestMapping(value="/donateMain.do")
	public String donateMain(Model model) {
		ArrayList<Donate> list = service.selectAllDonate();
		model.addAttribute("list", list);
		return "/donate/donateMain";
	}
	
	
	
	@RequestMapping(value = "/donateModify.do")
	public String donateModify(int donateNo, Model model) {
		Donate d = service.selectOneDonate(donateNo);
		model.addAttribute("d", d);
		return "/admin/donateModify";
	}
	
	@RequestMapping(value = "/donateInsertFrm.do")
	public String donateInsertFrm() {
		return "admin/donateInsertFrm";
	}
	
	@RequestMapping(value = "/donateInsert.do")
	public String donateInsert(Donate d, MultipartFile donateFile, HttpServletRequest request) {
		// 파일첨부 코드 시작
		if(!donateFile.isEmpty()) {
			String savePath = request.getSession().getServletContext().getRealPath("/resources/img/donate/");
				String filename = donateFile.getOriginalFilename();
				String filepath = fileRename.fileRename(savePath, filename);
				
				FileOutputStream fos;
				try {
					fos = new FileOutputStream(new File(savePath+filepath));
					BufferedOutputStream bos = new BufferedOutputStream(fos);
					byte[] bytes = donateFile.getBytes();
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
				d.setDonateImg(filepath);
			}
		
		int result = service.insertDonate(d);
		if(result>0) {
			System.out.println(d);
			System.out.println(result);
			return "/admin/donateInsertSuccess";
		}else {
			return "redirect:/";
		}
	}
	
	@RequestMapping(value = "/donateUpdate.do")
	public String donateUpdate(Donate d, MultipartFile upFile, HttpServletRequest request, String status, String oldImg) {
		//저장 경로
		String savePath = request.getSession().getServletContext().getRealPath("/resources/img/donate/");
				
		if(!upFile.isEmpty()) {
							
			String filename = upFile.getOriginalFilename();
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
			d.setDonateImg(filepath);
					
		}else if(oldImg != null && status.equals("stay")) {
			d.setDonateImg(oldImg);
		}		
		
		int result = service.updateOneDonate(d);
		System.out.println(d);
		System.out.println(result);
		if(result>0) {
			return "/admin/donateUpdateSuccess";
		}else {
			return "redirect:/";
		}
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/donateDelete.do", produces = "application/json;charset=utf-8")
	public void donateDelete(int donateNo) {
		int result = service.deleteOneDonate(donateNo);
	}
	
	@RequestMapping(value = "/donateMileage.do")
	public String donateMileage(Donate d, int donateVal, int donateSumVal, String donateContent, String donateOrgan, Model model, @SessionAttribute(required = false) Member m) { // @SessionAttribute(required = false) -> 로그인 안하면 접근 못하도록 막음
		int donateSumPlus = donateVal + donateSumVal;
		d.setDonateSumPlus(donateSumPlus);
		int result = service.donateMileage(d, donateVal, m.getMemberMileage(), m.getMemberNo());
		if(result>0) {			
			m.setMemberMileage(m.getMemberMileage()-donateVal);
		}
		model.addAttribute("donateVal", donateVal);
		model.addAttribute("donateContent", donateContent);
		model.addAttribute("donateOrgan", donateOrgan);
		return "/donate/donateResult";
	}
}
