package kr.co.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class DepartmentDAOImpl implements DepartmentDAO{
	@Inject
	private SqlSession sqlSession;
	
	//부서 조회
	@Override
	public List<Map<String, Object>> kn_department_select() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("DepartmentMapper.kn_department_select");
	}
}
