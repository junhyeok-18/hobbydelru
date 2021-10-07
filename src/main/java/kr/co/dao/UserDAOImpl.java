package kr.co.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.vo.SearchCriteria;
import kr.co.vo.UserVO;;

@Repository
public class UserDAOImpl implements UserDAO{
	@Inject
	private SqlSession sqlSession;
	
	//일반사용자 로그인
	@Override
	public UserVO user_login(UserVO uservo) throws Exception {
		return sqlSession.selectOne("UserMapper.user_login", uservo);
	}
	
	//관리사용자 로그인
	@Override
	public UserVO admin_login(UserVO uservo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.admin_login", uservo);
	}

	//관리자 로그인
	@Override
	public UserVO help_login(UserVO uservo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.help_login", uservo);
	}
	
	//회원가입
	@Override
	public void user_join(UserVO uservo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("UserMapper.user_join", uservo);
	}
	
	//아이디 중복확인
	@Override
	public int user_id_check(String kn_id) throws Exception {
		// TODO Auto-generated method stub
		int result = sqlSession.selectOne("UserMapper.user_id_check", kn_id);
		return result;
	}
	
	//자동 로그인 (로그인된 경우 해당 세션ID와 유효시간을 사원 정보 테이블에 세팅한다.)
	@Override
	public void user_keep_login(String kn_code, String kn_session_key, Date kn_session_limit) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("kn_code", kn_code);
		map.put("kn_session_key", kn_session_key);
		map.put("kn_session_limit", kn_session_limit);
		
		sqlSession.update("UserMapper.user_keep_login", map);
	}
	
	//자동 로그인 (유효시간이 남아 있으면서 해당 세선션ID를 가지는 사원 정보를 꺼내오는 부분)
	@Override
	public UserVO user_session_key_check(String kn_session_key) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.user_session_key_check", kn_session_key);
	}

	//모든 유저 상제 정보 조회
	@Override
	public List<Map<String, Object>> kn_employee_select(SearchCriteria scri) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("UserMapper.kn_employee_select", scri);
	}
	
	//모든 유저 총 명수 조회
	@Override
	public String kn_employee_all_count(SearchCriteria scri) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.kn_employee_all_count", scri);
	}

}
