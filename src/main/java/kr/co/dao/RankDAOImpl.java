package kr.co.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class RankDAOImpl implements RankDAO{
	@Inject
	private SqlSession sqlSession;
	
	//직급 조회
	@Override
	public List<Map<String, Object>> kn_rank_select() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("RankMapper.kn_rank_select");
	}
}
