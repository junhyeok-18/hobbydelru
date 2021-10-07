package kr.co.vo;

import java.util.Date;

public class PositionVO {
	private String kn_position_code;
	private String kn_position_name;
	private Date kn_reg_date;
	private Date kn_update_date;
	private Date kn_del_date;
	private String kn_activation;
	
	public String getKn_position_code() {
		return kn_position_code;
	}
	public void setKn_position_code(String kn_position_code) {
		this.kn_position_code = kn_position_code;
	}
	public String getKn_position_name() {
		return kn_position_name;
	}
	public void setKn_position_name(String kn_position_name) {
		this.kn_position_name = kn_position_name;
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
