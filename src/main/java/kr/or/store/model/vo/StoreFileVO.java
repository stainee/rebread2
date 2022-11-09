package kr.or.store.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StoreFileVO {
	private int fileNo;
	private int StoreNo;
	private String filename;
	private String filepath;

}
