package kr.or.donate.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Donate {
	private int donateNo;
	private int memberNo;
	private int donateSum; // 현재까지 기부금액
	private int donateEnd; // 기부 목표금액
	private String donateOrgan;
	private String donateContent;
	private String donateImg;
	private int memberMileage;
	private int donateSumPlus;
	private int memberMileageSum;
}
