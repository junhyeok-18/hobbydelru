package kr.co.vo;

import java.util.Date;

public class DepartmentVO {
	private String kn_department_code;
	private String kn_department_name;
	private Date kn_reg_date;
	private Date kn_update_date;
	private Date kn_del_date;
	private String kn_activation;
	
	public String getKn_department_code() {
		return kn_department_code;
	}
	public void setKn_department_code(String kn_department_code) {
		this.kn_department_code = kn_department_code;
	}
	public String getKn_department_name() {
		return kn_department_name;
	}
	public void setKn_department_name(String kn_department_name) {
		this.kn_department_name = kn_department_name;
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
