package kr.or.donate.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.donate.model.vo.Donate;

@Repository
public class DonateDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Donate> selectAllDonate() {
		List list = sqlSession.selectList("donate.selectAllDonate");
		return (ArrayList<Donate>) list;
	}

	public int selectOneDonate(Donate d) {
		return sqlSession.selectOne("donate.selectOneDonate", d);
	}
	
	public int donateMileage(Donate d) {
		return sqlSession.update("donate.donateMileage", d);
	}


	public void donateMileage2(HashMap<String, Object> map) {
		sqlSession.update("donate.donateMileage2", map);
	}

}
