package kr.co.dao;

import java.util.List;
import java.util.Map;

public interface DepartmentDAO {
	//부서 조회
	public List<Map<String, Object>> kn_department_select() throws Exception;
}
