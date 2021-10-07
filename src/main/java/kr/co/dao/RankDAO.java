package kr.co.dao;

import java.util.List;
import java.util.Map;

public interface RankDAO {
	//직급 조회
	public List<Map<String, Object>> kn_rank_select() throws Exception;
}
