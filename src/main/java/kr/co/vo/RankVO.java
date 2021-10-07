package kr.co.vo;

import java.util.Date;

public class RankVO {
	private String kn_rank_code;
	private String kn_rank_name;
	private Date kn_reg_date;
	private Date kn_update_date;
	private Date kn_del_date;
	private String kn_activation;
	
	public String getKn_rank_code() {
		return kn_rank_code;
	}
	public void setKn_rank_code(String kn_rank_code) {
		this.kn_rank_code = kn_rank_code;
	}
	public String getKn_rank_name() {
		return kn_rank_name;
	}
	public void setKn_rank_name(String kn_rank_name) {
		this.kn_rank_name = kn_rank_name;
	}
	public Date getKn_reg_date() {
		return kn_reg_date;
	}
	public void setKn_reg_date(Date kn_reg_date) {
		this.kn_reg_date = kn_reg_date;
	}
	public Date getKn_update_date() {
		return kn_update_date;
	}
	public void setKn_update_date(Date kn_update_date) {
		this.kn_update_date = kn_update_date;
	}
	public Date getKn_del_date() {
		return kn_del_date;
	}
	public void setKn_del_date(Date kn_del_date) {
		this.kn_del_date = kn_del_date;
	}
	public String getKn_activation() {
		return kn_activation;
	}
	public void setKn_activation(String kn_activation) {
		this.kn_activation = kn_activation;
	}
	
}
