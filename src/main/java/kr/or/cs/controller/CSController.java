package kr.or.cs.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.cs.model.service.CSService;
import kr.or.cs.model.vo.CS;
import kr.or.cs.model.vo.CSList;

@Controller
public class CSController {
	@Autowired
	private CSService service;
	
	@ResponseBody
	@RequestMapping(value="/CScheckUpdate.do" ,produces = "application/json;charset=utf-8")
	public int CSCheckUpdate(int csNo, int csCheck) {
		int result = -1;
		if(csCheck == 0) {//완료해야하는 상황이면
			result = service.updateCheck(csNo, 1);
		}else if(csCheck == 1) {//취소해야하는 상황이면
			result = service.updateCheck(csNo, 0);
		}
		int check = service.selectOneCheck(csNo);
		return check;
	}
	
	@ResponseBody
	@RequestMapping(value="/insertCS.do", produces = "application/json;charset=utf-8")
	public void insertCS(CS cs) {
		int result = service.insertCS(cs);
	}
	
	@ResponseBody
	@RequestMapping(value="/csSearch.do", produces ="application/json;charset=utf-8")
	public String searchCS(String searchValue, String searchOption) {
		ArrayList<CSList> list = service.searchCS(searchValue, searchOption);
		return new Gson().toJson(list);
	}
	
}
