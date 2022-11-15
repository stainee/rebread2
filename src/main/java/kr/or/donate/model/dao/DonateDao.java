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

	public Donate selectOneDonate(int donateNo) {
		return sqlSession.selectOne("donate.selectOneDonate", donateNo);
	}
	
	public int donateMileage(Donate d) {
		return sqlSession.update("donate.donateMileage", d);
	}


	public void donateMileage2(HashMap<String, Object> map) {
		sqlSession.update("donate.donateMileage2", map);
	}

	public int deleteOneDonate(int donateNo) {
		return sqlSession.delete("donate.deleteOneDonate", donateNo);
	}

	public int updateOneDonate(Donate d) {
		return sqlSession.update("donate.updateOneDonate", d);
	}

	public int insertDonate(Donate d) {
		return sqlSession.insert("donate.insertDonate", d);
	}

}
