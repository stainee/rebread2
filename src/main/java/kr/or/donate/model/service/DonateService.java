package kr.or.donate.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.donate.model.dao.DonateDao;

@Service
public class DonateService {
	@Autowired
	private DonateDao dao;
}
