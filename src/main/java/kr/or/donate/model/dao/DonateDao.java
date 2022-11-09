package kr.or.donate.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DonateDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
}
