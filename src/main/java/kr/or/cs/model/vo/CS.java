package kr.or.cs.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CS {
	private int csNo;
	private int memberNo;
	private String csCategory;
	private String csContent;
	private int csCheck;
}
