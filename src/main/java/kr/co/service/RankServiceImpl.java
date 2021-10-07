package kr.co.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.co.dao.RankDAO;

@Service
public class RankServiceImpl implements RankService{
	@Inject
	private RankDAO dao;
	
	//직급 조회
	@Override
	public List<Map<String, Object>> kn_rank_select() throws Exception {
		// TODO Auto-generated method stub
		return dao.kn_rank_select();
	}
}
