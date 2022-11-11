package kr.or.donate.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.donate.model.dao.DonateDao;
import kr.or.donate.model.vo.Donate;

@Service
public class DonateService {
	@Autowired
	private DonateDao dao;

	public ArrayList<Donate> selectAllDonate() {
		ArrayList<Donate> list = dao.selectAllDonate(); 
		return list;
	}
}
