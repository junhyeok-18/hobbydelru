package kr.co.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.co.dao.DepartmentDAO;

@Service
public class DepartmentServiceImpl implements DepartmentService{
	@Inject
	private DepartmentDAO dao;
	
	//부서 조회
	@Override
	public List<Map<String, Object>> kn_department_select() throws Exception {
		// TODO Auto-generated method stub
		return dao.kn_department_select();
	}
}
