package kr.or.order.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.client.ResponseErrorHandler;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.member.model.vo.Member;
import kr.or.order.model.service.OrderService;
import kr.or.order.model.vo.Order;
import kr.or.order.model.vo.OrderProduct;
import kr.or.product.model.vo.Product;
import kr.or.store.model.vo.Store;

@Controller
public class OrderController {

	@Autowired
	private OrderService service;
	
	private final RestTemplate restTemplate = new RestTemplate();
	private final ObjectMapper objectMapper = new ObjectMapper();
	
	@PostConstruct
	private void init() {
		restTemplate.setErrorHandler(new ResponseErrorHandler() {
			
			@Override
			public boolean hasError(ClientHttpResponse response) throws IOException {
				return false;
			}
			
			@Override
			public void handleError(ClientHttpResponse response) throws IOException {
			}
		});
	}
	
	private final String SECRET_KEY = "test_sk_OEP59LybZ8BnDlRmYzQ86GYo7pRe";
	
	// ??????????????? ??????
	@RequestMapping("/order.do")
	public String order() {
		return "order/order";
	}
	
	// ????????????????????? ??????
	@RequestMapping("/orderDetail.do")
	public String orderDetail(int orderNo, int reqPage, Model model, HttpSession session) {
		Order o = service.selectOneOrder(orderNo);
		model.addAttribute("o",o);
		model.addAttribute("reqPage",reqPage);
		Store s = service.selectOrderStore(o.getStoreNo());
		model.addAttribute("s",s);

		// ?????? ?????? ????????????
		ArrayList<OrderProduct> list = new ArrayList<OrderProduct>();
		list = service.selectOrderProduct(orderNo);
		ArrayList<Product> pList = new ArrayList<Product>();
		for(int i=0;i<list.size();i++) {
			Product p = service.selectOrderProduct2(list.get(i).getProductNo());
			pList.add(p);
		}
		model.addAttribute("list",list);
		model.addAttribute("pList",pList);
		
		
		// memberMileage ?????????
		int memberMileage = service.selectMemberMileage(o.getMemberNo());
		session.setAttribute("memberMileage", memberMileage);
		return "order/orderDetail";
	}
	
	// ????????? ?????? DB??????
	@ResponseBody
	@RequestMapping("/insertOrder.do")
	public String insertOrder(Order o) {
		int result = service.insertOrder(o);
		return "1";
	}
	
	// ?????? api
	@RequestMapping("/orderCard.do")
	public String confirmOrder(@RequestParam String paymentKey, @RequestParam String orderId, @RequestParam int amount, Model model, @SessionAttribute Member m) throws Exception {
		
		// ????????? ????????? header
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization","Basic "+Base64.getEncoder().encodeToString((SECRET_KEY+":").getBytes()));
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		Map<String, String> payloadMap = new HashMap<>();
		payloadMap.put("orderId", orderId);
		payloadMap.put("amount", String.valueOf(amount));
		
		HttpEntity<String> request = new HttpEntity<>(objectMapper.writeValueAsString(payloadMap), headers);
		
		ResponseEntity<JsonNode> responseEntity = restTemplate.postForEntity("https://api.tosspayments.com/v1/payments/"+paymentKey, request, JsonNode.class);
		
		if(responseEntity.getStatusCode() == HttpStatus.OK) {
			JsonNode successNode = responseEntity.getBody();
			model.addAttribute("orderId",successNode.get("orderId").asText());
			
			// ?????? ??? paymentKey??? orders ???????????? ??????
			int orderNo = service.searchOrderNo();
			Order o = new Order();
			o.setOrderNo(orderNo);
			o.setPaymentKey(paymentKey);
			int result = service.updatePaymentKey(o);
			
			// ?????? ??? payment ???????????? ????????? insert
			Order order = service.selectOrderPrice(orderNo);
			
			o.setOrderPrice(order.getOrderPrice());
			o.setStoreNo(order.getStoreNo());
			int paymentResult = service.insertPayment(o);
			
			//token??????
			int memberNo = m.getMemberNo();
			int inToken = service.insertToken(memberNo);
			
			model.addAttribute("orderNo",o.getOrderNo());
			
			return "order/orderCardSuccess";
		}else {
			JsonNode failNode = responseEntity.getBody();
			model.addAttribute("message",failNode.get("message").asText());
			model.addAttribute("code",failNode.get("code").asText());
			
			return "order/orderFail";
		}
	}
	
	@RequestMapping("/fail.do")
	public String failOrder(@RequestParam String message, @RequestParam String code, Model model) {
		model.addAttribute("message",message);
		model.addAttribute("code",code);
		return "order/orderFail";
	}
	
	// ?????? ?????? api
	@RequestMapping("/orderCancel.do")
	public String orderCancel(int orderNo, int reqPage, Model model, HttpSession session, @SessionAttribute Member m) throws Exception {
		String paymentKey = service.selectPaymentKey(orderNo);
		String cancelReason = "????????????";
		
		String authorizations = "Basic " + Base64.getEncoder().encodeToString((SECRET_KEY+":").getBytes());
		
		URL url = new URL("https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel");
		
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		
		connection.setRequestProperty("Authorization", authorizations);
		// content-type : ?????? ???????????? ???????????? ?????? ??????????????? ?????? ??????
		connection.setRequestProperty("Content-Type", "application/json");
		connection.setRequestMethod("POST");
		connection.setDoOutput(true);
		
		JSONObject obj = new JSONObject();
		obj.put("cancelReason", cancelReason);
		
		OutputStream outputStream = connection.getOutputStream();
		outputStream.write(obj.toString().getBytes("UTF-8"));
		
		int code = connection.getResponseCode();
		boolean isSuccess = code == 200 ? true : false;
		InputStream responseStream = isSuccess? connection.getInputStream(): connection.getErrorStream();
		Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
		responseStream.close();
		if(isSuccess) {
			// ????????? ???????????? ????????????, ?????? ???????????? ??????
			service.updateOrderState(orderNo);
			
			Order o = service.selectOneOrder(orderNo);
			model.addAttribute("o",o);
			model.addAttribute("reqPage",reqPage);
			
			// memberMileage ?????????
			int memberMileage = service.selectMemberMileage(o.getMemberNo());
			session.setAttribute("memberMileage", memberMileage);
			
			// ??????????????? token ??????
			int memberNo = m.getMemberNo();
			int delToken = service.deleteToken(memberNo);
			
			return "redirect:/orderDetail.do?orderNo="+orderNo+"&reqPage="+reqPage;
		}
		else {
			return "redirect:/";
		}
	}
	
	// ??????????????? api
	@RequestMapping("/orderAccount.do")
	public String confirmAccountOrder(@RequestParam String paymentKey, @RequestParam String orderId, @RequestParam int amount, Model model, @SessionAttribute Member m) throws Exception {
		HttpHeaders headers = new HttpHeaders();
		
		headers.set("Authorization","Basic "+Base64.getEncoder().encodeToString((SECRET_KEY+":").getBytes()));
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		Map<String, String> payloadMap = new HashMap<>();
		payloadMap.put("orderId", orderId);
		payloadMap.put("amount", String.valueOf(amount));
		
		HttpEntity<String> request = new HttpEntity<>(objectMapper.writeValueAsString(payloadMap), headers);
		
		ResponseEntity<JsonNode> responseEntity = restTemplate.postForEntity("https://api.tosspayments.com/v1/payments/"+paymentKey, request, JsonNode.class);
		
		if(responseEntity.getStatusCode() == HttpStatus.OK) {
			JsonNode successNode = responseEntity.getBody();
			model.addAttribute("orderId",successNode.get("orderId").asText());
			
			// ??????????????????
			model.addAttribute("accountNumber",successNode.get("virtualAccount").get("accountNumber").asText());
			model.addAttribute("bank",successNode.get("virtualAccount").get("bank").asText());
			model.addAttribute("totalAmount",successNode.get("totalAmount"));
			
			// ?????? ??? paymentKey??? DB??? ??????
			int orderNo = service.searchOrderNo();
			Order o = new Order();
			o.setOrderNo(orderNo);
			o.setPaymentKey(paymentKey);
			int result = service.updatePaymentKey(o);
			
			model.addAttribute("orderNo",o.getOrderNo());
			
			//token??????
			int memberNo = m.getMemberNo();
			int inToken = service.insertToken(memberNo);
			
			return "order/orderAccountSuccess";
		}else {
			
			return "order/orderFail";
		}
	}
	
	// order_product ???????????? ?????? ??????
	@ResponseBody
	@RequestMapping(value="/insertOrderProduct.do", produces = "application/json;charset=utf-8")
	public void insertOrderProduct(OrderProduct op) {
		int orderNo = service.searchOrderNo();
		op.setOrderNo(orderNo);
		int result = service.insertOrderProduct(op);
	}
}
