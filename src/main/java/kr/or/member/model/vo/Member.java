package kr.or.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Member {
	private int memberNo;
	private String memberId;
	private String memberPw;
	private String memberName;
	private String memberAddr;
	private String memberPhone;
	private String memberMail;
	private int memberGrade;
	private int memberMileage;
	private int kakao;
	private int token;
}
