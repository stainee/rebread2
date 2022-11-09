package kr.or.account.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Account {
	private int accountNo;
	private int storeNo;
	private int profit;
	private int accountPayment;
	private String accountDate;
	private String storeAccount;
	private String accountTranId;
}
