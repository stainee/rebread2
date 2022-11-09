package kr.or.account.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.account.model.vo.Account;

@Repository
public class AccountDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insertOneAccount(Account a) {
		int result = sqlSession.insert("account.insertOneAccount",a);
		return result;
	}

	public ArrayList<Account> selectAccountList(int storeNo) {
		List list = sqlSession.selectList("account.selectAccountList", storeNo);
		return (ArrayList<Account>)list;
	}
	
}
