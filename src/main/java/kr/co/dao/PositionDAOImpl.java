package kr.co.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class PositionDAOImpl implements PositionDAO{
	@Inject
	private SqlSession sqlSession;
	
	//직책 조회
	@Override
	public List<Map<String, Object>> kn_position_select() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("PositionMapper.kn_position_select");
	}
}
