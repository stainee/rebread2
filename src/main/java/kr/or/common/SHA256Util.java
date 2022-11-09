package kr.or.common;

import java.security.MessageDigest;

import org.springframework.stereotype.Component;

//비밀번호 암호화
@Component
public class SHA256Util {
	public String encData(String data) throws Exception{
		MessageDigest mDigest = MessageDigest.getInstance("SHA-256");
		mDigest.update(data.getBytes());
		byte[] msgStr = mDigest.digest();
		StringBuffer sb = new StringBuffer();
		for(int i=0; i<msgStr.length; i++) {
			byte str = msgStr[i];
			String encText = Integer.toString((str & 0xff)+0x100, 16).substring(1);
			sb.append(encText);
		}
		return sb.toString();
	}
}
