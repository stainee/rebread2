package kr.or.cs.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CSDetail {
	private int csNo;
	private String memberId;
	private String memberName;
	private String memberPhone;
	private String memberMail;
	private String memberAddr;
	private String memberGrade;
	private String memberMileage;
	private String csCategory;
	private String csContent;

}
