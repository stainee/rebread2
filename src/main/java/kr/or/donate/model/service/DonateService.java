package kr.or.donate.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.donate.model.dao.DonateDao;
import kr.or.donate.model.vo.Donate;
import kr.or.member.model.vo.Member;

@Service
public class DonateService {
	@Autowired
	private DonateDao dao;

	public ArrayList<Donate> selectAllDonate() {
		ArrayList<Donate> list = dao.selectAllDonate(); 
		return list;
	}

	public int donateMileage(Donate d, int donateVal, int memberMileage, int memberNo) {
		// sumMileage = 종전 마일리지 - 기부한 금액
		int sumMileage = memberMileage - donateVal;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("sumMileage", sumMileage);
		map.put("memberNo", memberNo);
		dao.donateMileage2(map);
		return dao.donateMileage(d);
	}

	public int selectOneDonate(Donate d) {
		return dao.selectOneDonate(d);
	}



}
