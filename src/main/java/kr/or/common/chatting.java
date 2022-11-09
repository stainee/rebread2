package kr.or.common;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import oracle.net.aso.s;

public class chatting extends TextWebSocketHandler{
	//접속한 회원 세션을 저장하는 리스트
	private ArrayList<WebSocketSession> sessionList;
	//세션별로 아이디를 저장할 map
	private HashMap<WebSocketSession, String> memberList;
	
	public chatting() {
		super();
		sessionList = new ArrayList<WebSocketSession>();
		memberList = new HashMap<WebSocketSession, String>();	 
	}

	//클라이언트가 웹소켓에 최초로 접속했을 때 자동으로 수행되는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) {
		sessionList.add(session);
		System.out.println("클라이언트 접속");
		System.out.println(sessionList);
	}
	
	//클라이언트와 연결이 끊겼을때 자동으로 수행되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		System.out.println("클라이언트 접속 끊김 ");
	}
	
	//클라이언트가 웹소켓 서버로 메세지를 전송하면 수행되는 메소드
		@Override 
		protected void handleTextMessage(WebSocketSession session, TextMessage message)throws Exception{
			//문자열을 Json객체로 반환
			JsonParser parser = new JsonParser();
			//parser를 이용해서 문자열 -> json 변환
			JsonElement element = parser.parse(message.getPayload());
			//key : type 추출
			String type = element.getAsJsonObject().get("type").getAsString();
			//key : msg 
			String msg = element.getAsJsonObject().get("msg").getAsString();
			
			if(type.equals("enter")) {
				//최초 접속시 멤버목록에 추가
				memberList.put(session, msg);
				String enterMsg = enterMsg();
				sendServerMsg(enterMsg, session);
				String selectMsg = selectMsg();
				sendServerMsg(selectMsg, session);
				
			}else if(type.equals("chat")) {
				String sendMsg = "<div class='chat left'>"+msg+"</div>";
				TextMessage tm = new TextMessage(sendMsg);
				for(WebSocketSession s : sessionList) {
					if(!s.equals(session)) { //나 자신을 제외한 사람들에게 메세지 전송
						//클라이언트 전송용 객체 생성
						s.sendMessage(tm);
					}
				}
			}else if(type.equals("bot")) {
				//선택 depth 별 select를 나눈다
				int select = element.getAsJsonObject().get("select").getAsInt();
				String sendMsg = "";
				if(select == 1) {
					if(msg.equals("purchase")) {
						sendMsg = "<ul class='bot right selectList'>"
								+"<li><button id='product' onclick='selectOne(this,2);'>상품 교환/환불 문의</button></li>"
								+"<li><button id='purchaseList' onclick='selectOne(this,2);'>구매 내역</button></li>"
							+"</ul> </div>";

					}else if(msg.equals("sell")) {
						sendMsg = "<ul class='bot right selectList'>"
								+"<li><button id='seller' onclick='selectOne(this,2);'>판매자 등록 방법</button></li>"
								+"<li><button id='enroll' onclick='selectOne(this,2);'>물품 등록 방법</button></li>"
								+"<li><button id='orderCheck' onclick='selectOne(this,2);'>주문 확인 방법</button></li>"
							+"</ul> </div>";

					}else if(msg.equals("deliver")) {
						sendMsg = "<ul class='bot right selectList'>"
								+"<li><button id='deliverCheck' onclick='selectOne(this,2);'>배송 확인</button></li>"
								+"<li><button id='deliverTime' onclick='selectOne(this,2);'>배송 소요 시간</button></li>"
							+"</ul> </div>";

					}
					Thread.sleep(1000);
					sendServerMsg(sendMsg, session);
				}//1
				if(select == 2) {
					//구매 관련 문의
					if(msg.equals("product")) {
						sendMsg = "<div class='bot right'>"
								+ "<p>빵 특성상 환불 및 교환이 불가능합니다.<br>"
								+ "다만, 배송 시 빵에 이상이 있을 경우 <br>"
								+ "아래 추가 문의를 이용하여 환불이 가능합니다.</p></div>";
					}
					else if(msg.equals("purchaseList")) {
						sendMsg = "<div class='bot right'>"
								+"<p>상단 좌측 마이페이지 > <br>"
								+"마이페이지 내 좌측 최근 주문 내역 "
								+"에서 확인 가능합니다.</p></div>";
					}
					//판매 관련 문의
					else if(msg.equals("seller")) {
						sendMsg = "<div class='bot right'>"
								+"<p>회원 가입시 판매자로 가입하셔야합니다.<br>"
								+ "이후 상단 좌측 마이페이지 ><br>"
								+ "마이페이지내 가게정보 > 가게등록에서 가능합니다."
								+"</p></div>";
					}
					else if(msg.equals("enroll")) {
						sendMsg = "<div class='bot right'>"
								+"<p>현재 관리중인 가게 클릭 ><br>"
								+"상품 등록버튼 클릭 > 폼 작성 > 확인<br>"
								+"과정을 통해 상품을 등록하실 수 있습니다."
								+"</p></div>";
					}
					else if(msg.equals("orderCheck")) {
						sendMsg = "<div class='bot right'>"
								+"<p>판매자 마이페이지 <br>"
								+ "상품 판매 정보 클릭 후<br>"
								+ "상품 리스트 클릭시 주문 상세를 확인하실 수 있습니다."
								+"</p></div>";
					}
					else if(msg.equals("deliverCheck")) {
						sendMsg = "<div class='bot right'>"
								+"<p>마이페이지 ><br>"
								+ "최근 주문 내역 클릭 시<br>"
								+ "배송 세부 상태를 확인하실 수 있습니다."
								+"</p></div>";
					}
					else if(msg.equals("deliverTime")) {
						sendMsg = "<div class='bot right'>"
								+"<p>배송기간은 2일을 초과하지 않으며<br>"
								+ "배송기간 초과로 인한 식품 손상에 대해서는<br>"
								+ "추가문의를 이용 부탁드립니다"
								+"</p></div>";
					}
					Thread.sleep(1000);
					sendServerMsg(sendMsg, session);
					etcMsg(session);
				}
			}//bot
			
		}
		
		public String enterMsg() {
			String sendMsg = "<div class='bot right'>"
					+"<span>리브레드 채팅상담 입니다<br>"
					+"무엇을 도와드릴까요? </span>";
			return sendMsg;
		}
		public String selectMsg() {
			String sendMsg ="<ul class='bot right selectList'>"
			+"<li><button id='purchase' onclick='selectOne(this,1);'>구매문의</button></li>"
			+"<li><button id='sell' onclick='selectOne(this,1);'>판매문의</button></li>"
			+"<li><button id='deliver' onclick='selectOne(this,1);'>배송문의</button></li>"
		+"</ul> </div>";
			return sendMsg;
		}
		
		public void sendServerMsg(String msg, WebSocketSession session) throws IOException {
			TextMessage tm = new TextMessage(msg);
			session.sendMessage(tm);
		}
		
		public void etcMsg(WebSocketSession session) throws IOException {
			String etc = "<div class='bot right'>"
					+ "<p>추가문의가 있으실경우 아래 버튼을 누른 후 문의 내용을 입력하여 주세요</p>"
					+ "<button id='etc' onclick='inputAble();'>추가문의</button></div>";
			sendServerMsg(etc, session);
		}
}
