package kr.or.store.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.member.model.vo.Member;
import kr.or.order.model.vo.Order;
import kr.or.store.model.vo.Like;
import kr.or.store.model.vo.Store;
import kr.or.store.model.vo.StoreDetail;
import kr.or.store.model.vo.StoreListDetail;
import kr.or.store.model.vo.StoreStatus;

@Repository
public class StoreDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Store> selectAllStore() {
		List list = sqlSession.selectList("store.selectAllStore");
		return (ArrayList<Store>)list;
	}

	public StoreDetail selectOneStore(int storeNo) {
		StoreDetail sd = sqlSession.selectOne("store.selectOneStore",storeNo);
		return sd;
	}


	public StoreListDetail selectOneStoreDetail(int storeNo) {
		StoreListDetail sld = sqlSession.selectOne("store.selectOneStoreDetail",storeNo);
		return sld;
	}

	public int updateStoreDetail(Store s) {
		int result = sqlSession.update("store.updateStoreDetail", s);
		return result;
	}

	public ArrayList<Integer> selectAllStoreNo() {
		List list = sqlSession.selectList("store.selectAllStoreNo");
		return (ArrayList<Integer>)list;
	}

	public String selectOneStoreAccount(int storeNo) {
		String account = sqlSession.selectOne("store.selectOneStoreAccount", storeNo);
		return account;
	}

	public ArrayList<Store> selectStoreList(HashMap<String, Object> map) {
		List list = sqlSession.selectList("store.allStoreList",map);
		return (ArrayList<Store>) list;
	}

	public int selectStoreCount() {
		int totalCount = sqlSession.selectOne("store.totalCount");
		return totalCount;
	}

	public ArrayList<Store> selectMemberStore(Member member) {
		List list = sqlSession.selectList("store.selectMemberStore", member);
		return (ArrayList<Store>) list;
	}

	public int storeInsert(Store s) {
		int result = sqlSession.insert("store.insertStore",s);
		return result;
	}

	public Store selectOneStore1(Store store) {
		Store s = sqlSession.selectOne("store.selectOneStore1", store);
		return s;
	}

	public int updateStore(Store s) {
		int result = sqlSession.update("store.updateStore",s);
		return result;
	}

	public Store selectOneStore2(int storeNo) {
		return sqlSession.selectOne("store.selectOneStore2",storeNo);
	}

	public ArrayList<Store> searchStore(String storeName) {
		List list = sqlSession.selectList("store.searchStore", storeName);
		return (ArrayList<Store>)list;
	}

	public ArrayList<Order> selectAllOrder() {
		List list = sqlSession.selectList("order.selectAllOrder");
		return (ArrayList<Order>) list; 
	}

	public int salesInfoUpdate(Order o) {
		int result = sqlSession.update("store.salesInfoUpdate", o);
		return result;
	}

	public ArrayList<Order> selectWhereOrder(Order o) {
		List list = sqlSession.selectList("store.selectWhereOrder", o); 
		return (ArrayList<Order>) list;
	}

	public int countList() {
		return sqlSession.selectOne("store.countList");
	}
	public int countList(String storeName) {
		return sqlSession.selectOne("store.countList", storeName);
	}

	public ArrayList<Store> selectBreadList(HashMap<String, Object> map) {
		List list = sqlSession.selectList("store.allBreadList",map);
		return (ArrayList<Store>) list;
	}
	public int selectStoreCount(String breadName) {
		return sqlSession.selectOne("store.totalCount", breadName);
	}

	public int insertLike(HashMap<String, Object> map) {
		return sqlSession.insert("like.insertLike",map);
	}

	public Like selectLike(int storeNo, int memberNo) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("storeNo",storeNo);
		map.put("memberNo", memberNo);
		return sqlSession.selectOne("like.selectLike",map);
	}

	public int deleteLike(HashMap<String, Object> map) {
		return sqlSession.delete("like.deleteLike",map);
	}

	public Store selectOrderStore(int storeNo) {
		return sqlSession.selectOne("store.selectOrderStore",storeNo);
	}

	public ArrayList<StoreStatus> selectStoreStatus(HashMap<String, Object> map) {
		List list = sqlSession.selectList("store.selectStoreStatus",map);
		return (ArrayList<StoreStatus>) list;
	}
	public ArrayList<Store> chooseStoreList(HashMap<String, Object> map) {
		List list = sqlSession.selectList("store.chooseStoreList",map);
		return (ArrayList<Store>)list;
	}

	public int updateStoreInfo(Store s) {
		return sqlSession.update("store.updateStoreInfo", s);
	}
	

}

