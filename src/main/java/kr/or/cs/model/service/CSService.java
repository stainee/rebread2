package kr.or.cs.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.cs.model.dao.CSDao;
import kr.or.cs.model.vo.CS;
import kr.or.cs.model.vo.CSDetail;
import kr.or.cs.model.vo.CSList;

@Service
public class CSService {
	
	@Autowired
	private CSDao dao;

	public ArrayList<CSList> selectAllCS() {
		return (ArrayList<CSList>)dao.selectAllCS();
	}

	@Transactional
	public int updateCheck(int csNo, int i) {
		// TODO Auto-generated method stub
		return dao.updateCheck(csNo, i);
	}

	public int selectOneCheck(int csNo) {
		// TODO Auto-generated method stub
		return dao.selectOneCheck(csNo);
	}

	public int insertCS(CS cs) {
		return dao.insertCS(cs);
	}

	public ArrayList<CSList> searchCS(String searchValue, String searchOption) {
		CSList cs = new CSList();
		if(searchOption.equals("memberId")) {
			cs.setMemberId(searchValue);
		}else if(searchOption.equals("memberName")) {
			cs.setMemberName(searchValue);
		}
		ArrayList<CSList> list = dao.searchCS(cs);
		return list;
	}

	public CSDetail selectOneCS(int csNo) {
		return dao.selectOneCS(csNo);
	}
}
