package kr.or.store.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import kr.or.member.model.vo.Member;
import kr.or.order.model.vo.Order;
import kr.or.product.model.dao.ProductDao;
import kr.or.product.model.vo.Product;

import kr.or.store.model.dao.StoreDao;
import kr.or.store.model.vo.Store;
import kr.or.store.model.vo.StoreDetail;
import kr.or.store.model.vo.StoreListDetail;

import kr.or.store.model.vo.StorePageData;

@Service
public class StoreService {
	@Autowired
	private StoreDao dao;
	@Autowired 
	private ProductDao pdao;

	public ArrayList<Store> selectAllStore() {
		return dao.selectAllStore();
	}

	public StoreDetail selectOneStore(int storeNo) {
		return dao.selectOneStore(storeNo);
	}
	
	public StoreListDetail selectOneStoreDetail(int storeNo) {
		return dao.selectOneStoreDetail(storeNo);
	}
	
	public int updateStoreDetail(Store s) {
		return dao.updateStoreDetail(s);
	}
	
	//별점포함 가져오는 매장 상세페이지 
	public StoreDetail selectOneStore2(int storeNo) {
		Store s = dao.selectOneStore2(storeNo);
		ArrayList<Product> lossList = pdao.selectLossList(storeNo);
		ArrayList<Product> nomalList = pdao.selectNomalList(storeNo);
		StoreDetail sd = new StoreDetail();
		sd.setS(s);
		sd.setLossList(lossList);
		sd.setNomalList(nomalList);
		System.out.println(s);
		System.out.println(lossList);
		System.out.println(nomalList);
		return sd;
	}

	// 매장 전체페이지 리스트와 페이지 네비
	public StorePageData selectStoreList(int reqPage, String storeName) {
		int numPerPage = 12;
		int end = reqPage * numPerPage;
		int start = end - numPerPage + 1;

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("storeName", storeName);
		ArrayList<Store> list = dao.selectStoreList(map);

		int totalCount = dao.selectStoreCount();
		// 전체 페이지 수 계산
		int totalPage = 0;
		if (totalCount % numPerPage == 0) {
			totalPage = totalCount / numPerPage;
		} else {
			totalPage = totalCount / numPerPage + 1;
		}

		// 페이지 네비 길이
		int pageNaviSize = 5;
		int pageNo = 1;
		if (reqPage > 3) {
			pageNo = reqPage - 2;
		}
		// pageNavi생성 시작
		String pageNavi = "";
		// 이전버튼
		if (pageNo != 1) {
			pageNavi += "<a href='/purchaseList.do?reqPage=" + (pageNo - 1) + "'>[이전]</a>";
		}
		// 페이지 숫자 생성
		for (int i = 0; i < pageNaviSize; i++) {
			if (pageNo == reqPage) {
				pageNavi += "<span>" + pageNo + "</span>";
			} else {
				pageNavi += "<a href='/purchaseList.do?reqPage=" + pageNo + "'>" + pageNo + "</a>";
			}
			pageNo++;
			if (pageNo > totalPage) {
				break;
			}
		}
		// 다음 버튼
		if (pageNo <= totalPage) {
			pageNavi += "<a href='/purchaseList.do?reqPage=" + pageNo + "'>[다음]</a>";
		}
		StorePageData spd = new StorePageData(list, pageNavi, reqPage, numPerPage);
		return spd;
	}

	
	public ArrayList<Store> searchStore(String storeName) {
		return dao.searchStore(storeName);
	}
	public ArrayList<Store> selectMemberStore(Member member) {
		return dao.selectMemberStore(member);
	}

	public int insertStore(Store s) {
		int result = dao.storeInsert(s);
		return result;
	}

	public Store selectOneStore1(Store s) {
		return dao.selectOneStore1(s);
	}

	@Transactional
	public Store updateStore(Store s) {
		int result = dao.updateStore(s);
		if(result>0) {
			Store store = dao.selectOneStore1(s);
			return store;
		}else {
			return null;
		}
	}

	public ArrayList<Order> selectAllOrder() {
		ArrayList<Order> list = dao.selectAllOrder();
		return list;
	}

	public int salesInfoUpdate(Order o) {
		int result = dao.salesInfoUpdate(o);
		return result;
	}

	public ArrayList<Order> selectWhereOrder(Order o) {
		ArrayList<Order> list = dao.selectWhereOrder(o);
		return list;
	}
	
	//리스트 갯수 카운트
	public int countList() {
		return dao.countList();
	}
	//검색된 갯수 카운트
	public int countList(String storeName) {
		return dao.countList(storeName);
	}
	//bread검색
	public StorePageData selectBeadList(int reqPage, String breadName) {
		int numPerPage = 12;
		int end = reqPage * numPerPage;
		int start = end - numPerPage + 1;

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("breadName", breadName);
		ArrayList<Store> list = dao.selectBreadList(map);

		int totalCount = dao.selectStoreCount(breadName);
		// 전체 페이지 수 계산
		int totalPage = 0;
		if (totalCount % numPerPage == 0) {
			totalPage = totalCount / numPerPage;
		} else {
			totalPage = totalCount / numPerPage + 1;
		}
		// 페이지 네비 길이
		int pageNaviSize = 5;
		int pageNo = 1;
		if (reqPage > 3) {
			pageNo = reqPage - 2;
		}
		// pageNavi생성 시작
		String pageNavi = "";
		// 이전버튼
		if (pageNo != 1) {
			pageNavi += "<a href='/searchBread.do?reqPage=" + (pageNo - 1) + "'>[이전]</a>";
		}
		// 페이지 숫자 생성
		for (int i = 0; i < pageNaviSize; i++) {
			if (pageNo == reqPage) {
				pageNavi += "<span>" + pageNo + "</span>";
			} else {
				pageNavi += "<a href='/searchBread.do?reqPage=" + pageNo + "'>" + pageNo + "</a>";
			}
			pageNo++;
			if (pageNo > totalPage) {
				break;
			}
		}
		// 다음 버튼
		if (pageNo <= totalPage) {
			pageNavi += "<a href='/searchBread.do?reqPage=" + pageNo + "'>[다음]</a>";
		}
		StorePageData spd = new StorePageData(list, pageNavi, reqPage, numPerPage);
		return spd;
	}

	public int countList2(String breadName) {
		return dao.selectStoreCount(breadName);
	}

	public Store selectOrderStore(int storeNo) {
		return dao.selectOrderStore(storeNo);
	}



	
	
//	// 판매자 가게 정보 페이징 처리
//	public StorePageData selectStoreList(int reqPage) {
//		// 한 페이지 당 보여줄 게시물 수
//				int numPerPage = 3;
//				// reqPage 1 -> 1~3번 게시물, reqPage 2 -> 4~6번 게시물
//				int end = reqPage * numPerPage;
//				int start = end - numPerPage + 1;
//				// 계산한 start, end 이용해서 게시물 목록 조회
//				HashMap<String, Object> map = new HashMap<String, Object>();
//				map.put("start", start);
//				map.put("end", end);
//				ArrayList<Store> list = dao.selectStoreList(map);
//				// pageNavi 시작
//				// 전체 페이지 수 계산 필요 -> 전체 게시물 수
//				int totalCount = dao.selectStoreCount();
//				// 전체 페이지 수 계산
//				int totalPage = 0;
//				if(totalCount%numPerPage == 0) {
//					totalPage = totalCount/numPerPage;
//				}else {
//					totalPage = totalCount/numPerPage+1;
//				}
//				
//				// 페이지 네비 길이
//				int pageNaviSize = 5;
//				int pageNo = 1; 
//				// 5페이지면 3 4 5 6 7 페이지 출력
//				if(reqPage>3) { // 1, 2 이면 -값이 나오므로 3이상 인 경우만 되도록 계산
//					pageNo = reqPage - 2;
//				}
//				
//				// pageNavi 생성 시작
//				String pageNavi = "";
//				// 이전 버튼
//				if(pageNo != 1) {
//					pageNavi += "<a href='/storeInfoList.do?reqPage="+(pageNo-1)+"'>[이전]</a>";
//				}
//				// 페이지 숫자 생성
//				for(int i=0;i<pageNaviSize;i++) {
//					if(pageNo == reqPage) {
//						pageNavi += "<span>"+pageNo+"<span>";
//					}else {
//						pageNavi += "<a href='/storeInfoList.do?reqPage="+pageNo+"'>"+pageNo+"</a>";
//					}
//					pageNo++;
//					if(pageNo>totalPage) {
//						break;
//					}
//				}
//				if(pageNo<=totalPage) {
//					pageNavi += "<a href='/storeInfoList.do?reqPage="+pageNo+"'>[다음]</a>";
//				}
//				StorePageData spd = new StorePageData(list, pageNavi, reqPage, numPerPage);
//				
//				return spd;
//	}
}
