package kr.co.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.co.dao.PositionDAO;

@Service
public class PositionServiceImpl implements PositionService{
	@Inject
	private PositionDAO dao;
	
	//직급 조회
	@Override
	public List<Map<String, Object>> kn_position_select() throws Exception {
		// TODO Auto-generated method stub
		return dao.kn_position_select();
	}
}
