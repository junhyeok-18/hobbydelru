package kr.co.dao;

import java.util.List;
import java.util.Map;

public interface PositionDAO {
	//직책 조회
	public List<Map<String, Object>> kn_position_select() throws Exception;
}
