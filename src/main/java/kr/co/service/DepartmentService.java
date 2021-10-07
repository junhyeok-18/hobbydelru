package kr.co.service;

import java.util.List;
import java.util.Map;

public interface DepartmentService {
	//부서 조회
	public List<Map<String, Object>> kn_department_select() throws Exception;
}
