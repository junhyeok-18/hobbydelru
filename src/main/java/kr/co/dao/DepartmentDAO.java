package kr.co.dao;

import java.util.List;
import java.util.Map;

public interface DepartmentDAO {
	//๋ถ์ ์กฐํ
	public List<Map<String, Object>> kn_department_select() throws Exception;
}
