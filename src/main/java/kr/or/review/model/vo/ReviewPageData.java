package kr.or.review.model.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewPageData {
	private ArrayList<Review> list;
	private String pageNavi;
	private int reqPage;
	private int numPerPage;
	private String memberId;
}
