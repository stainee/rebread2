package kr.or.review.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Review {
	private int reviewNo;
	private int reviewComment;
	private int storeNo;
	private String reviewWriter;
	private String reviewContent;
	private String reviewDate;
	private int Rating;
	private String reviewImg;
	private int reviewView;
}
