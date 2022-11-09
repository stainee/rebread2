package kr.or.account.model.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;

import kr.or.account.model.dao.AccountDao;
import kr.or.account.model.vo.Account;
import kr.or.payment.model.dao.PaymentDao;
import kr.or.store.model.dao.StoreDao;

@Service
public class AccountService {
	
	@Autowired
	private PaymentDao payDao;
	
	@Autowired
	private StoreDao storeDao;
	
	@Autowired
	private AccountDao accountDao;
	
	//테스트 코드
	//@Scheduled(fixedDelay=10000)
	//@Scheduled(cron ="0 0 0 10 * ?")
	@Transactional
	public void accountSchedule() {
		//<상점번호, 총매출>을 담는 HashMap 가져오기
		HashMap<Integer, Integer> salesByStore = payDao.selectSalesByStore();
		//총 정산 된 계좌 개수
		int result = 0;
		//각 매출을 정산 내역에 저장한다
		for(Integer key: salesByStore.keySet()) {
			//총 매출
			//account에 들어갈 값 정리
			int sales = salesByStore.get(key); 
			int storeNo = key;
			int accountPayment = (int)Math.round(sales*0.95);
			String account = storeDao.selectOneStoreAccount(storeNo);
			
			Account a = new Account();
			a.setStoreNo(storeNo);
			a.setProfit(sales);
			a.setAccountPayment(accountPayment);
			a.setStoreAccount(account);
			/*  depositToSeller --> 실 테스트시 필요한 매개변수
			  	계좌번호 req_client_account_num
				은행번호 req_client_bank_code
				금액 tran_amt
				이름 req_client_name
			*/
			   	
			String tranDataTotranDtm = depositToSeller();
			String api_tran_id = tranDataTotranDtm.split(" ")[0];
			a.setAccountTranId(api_tran_id);
			result += accountDao.insertOneAccount(a);
		}
		//정산 되었는지 확인
		System.out.println("accountInsert :"+ result);
	}
	
	public String depositToSeller() {

		String connURL= "https://testapi.openbanking.or.kr/oauth/2.0/token";
		RestTemplate restTemplate = new RestTemplate();
		//헤더설정
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.set("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
		//바디 파라미터
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "client_credentials");
		params.add("client_id", "d8aebbf6-1479-493a-94e3-7c8ff81d7f89");
		params.add("client_secret","c57d90e6-8b43-4817-8f61-a5348e260bcf");
		params.add("scope","oob");
		//바디와 헤더 묶기
		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, httpHeaders);
		ResponseEntity<JsonNode> response = restTemplate.postForEntity(connURL, request, JsonNode.class);
		String accessToken = response.getBody().get("access_token").asText();
		String clientUseCode = response.getBody().get("client_use_code").asText();
		String tokenType = response.getBody().get("token_type").asText();
		String expiresIn = response.getBody().get("expires_in").asText();
		
		
		//계좌번호 사용하여 이체 요청
		String connURL2= "https://testapi.openbanking.or.kr/v2.0/transfer/deposit/acnt_num";
		RestTemplate restTemplate2 = new RestTemplate();
		//헤더설정
		HttpHeaders httpHeaders2 = new HttpHeaders();
		httpHeaders2.set("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
		httpHeaders2.set("Authorization", "Bearer " + accessToken);
		//바디 파라미터
		String requestJson = "{\"cntr_account_type\" : \"N\", ";
		requestJson += "\"cntr_account_num\" : \"11891000092000\", ";
		requestJson += "\"wd_pass_phrase\" : \"NONE\", ";
		requestJson += "\"wd_print_content\" : \"환불금액 \", ";
		requestJson += "\"name_check_option\" : \"off\", ";
		requestJson += "\"tran_dtime\" : \"" + getCurrentDateTime() + "\", ";
		requestJson += "\"req_cnt\" : \"1\", ";
		
		//req_list
		requestJson += "\"req_list\" : [{ ";
		requestJson += "\"tran_no\" : \"1\", ";
		requestJson += "\"bank_tran_id\" : \"M202202113U4BC342397\", ";
		requestJson += "\"bank_code_std\" : \"081\", ";
		requestJson += "\"account_num\" : \"11811111100000\",";
		requestJson += "\"account_holder_name\" : \"홍길동\", ";
		requestJson += "\"print_content\" : \"입금이체\", ";
		requestJson += "\"tran_amt\" : \"500\", ";
		requestJson += "\"req_client_name\" : \"홍길동\", ";
		requestJson += "\"req_client_bank_code\" : \"081\", ";
		requestJson += "\"req_client_account_num\" : \"11811111100000\", ";
		requestJson += "\"req_client_num\" : \"HONGGILDONG1234\", ";
		requestJson += "\"transfer_purpose\" : \"TR\" ";
		requestJson += "}]}";
		HttpEntity<String> entity = new HttpEntity<String>(requestJson, httpHeaders2);
//		//response
		ResponseEntity<JsonNode> response2 = restTemplate2.postForEntity(connURL2, entity, JsonNode.class);
		String apiTranId = response2.getBody().get("api_tran_id").asText();
		String apiTranDtm = response2.getBody().get("api_tran_dtm").asText();
		String rspCode = response2.getBody().get("rsp_code").asText();
		String rspMessage = response2.getBody().get("rsp_message").asText();
		
		return apiTranId+" "+apiTranDtm;
		
//		리팩토링 예정
		/*
		MultiValueMap<String,String> params2 = new LinkedMultiValueMap<>();
		params2.add("cntr_account_type", "N");
		params2.add("cntr_account_num", "11891000092000");
		params2.add("wd_pass_phrase","NONE");
		params2.add("wd_print_content","결제금액");
		params2.add("name_check_option", "off");
		params2.add("trans_dtime", getCurrentDateTime());
		params2.add("req_cnt", "1");
		//리스트 바디 파라미터
		MultiValueMap<String, MultiValueMap<String, String>> list = new LinkedMultiValueMap<>();
		MultiValueMap<String, String> listparam = new LinkedMultiValueMap<>();
		listparam.add("trans_no","1");
		listparam.add("bank_tran_id", "F123456789U4BC342397");
		listparam.add("bank_code_std", "081");
		listparam.add("account_num", "11811111100000");
		listparam.add("account_holder_name", "홍길동");
		listparam.add("print_content", "입금이체");
		listparam.add("tran_amt", "500");
		listparam.add("req_client_name","홍길동");
		listparam.add("req_client_bank_code", "081");
		listparam.add("req_client_account_cnum", "11811111100000");
		listparam.add("req_client_num","HONGGILDONG1234");
		listparam.add("trans_purpose", "TR");
		params2.add("req_list", listparam);
 */
		//바디와 헤더 묶기
//		System.out.println(params2);
//		HttpEntity<MultiValueMap<String, String>> request2 = new HttpEntity<>(params2, httpHeaders2);
		
		
	}
	
	public static String getCurrentDateTime() {
		Date today = new Date();
		Locale currentLocale = new Locale("KOREAN", "KOREA");
		String pattern = "yyyyMMddHHmmss"; 
		SimpleDateFormat formatter = new SimpleDateFormat(pattern,
				currentLocale);
		return formatter.format(today);
	}
	

	public ArrayList<Account> selectAccountList(int storeNo) {
		return accountDao.selectAccountList(storeNo);
	}
	

}
