package kr.co.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import kr.co.vo.SearchCriteria;
import kr.co.vo.UserVO;

public interface UserDAO {
	//일반사용자 로그인
	public UserVO user_login(UserVO uservo) throws Exception;
	
	//관리사용자 로그인
	public UserVO admin_login(UserVO uservo) throws Exception;

	//관리자 로그인
	public UserVO help_login(UserVO uservo) throws Exception;

	//회원가입
	public void user_join(UserVO uservo) throws Exception;
	
	//아이디 중복확인
	public int user_id_check(String kn_id) throws Exception;
	
	//자동 로그인 (로그인된 경우 해당 세션ID와 유효시간을 사원 정보 테이블에 세팅한다.)
	public void user_keep_login(String kn_code, String kn_session_key, Date kn_session_limit) throws Exception;
	
	//자동 로그인 (유효시간이 남아 있으면서 해당 세선션ID를 가지는 사원 정보를 꺼내오는 부분)
	public UserVO user_session_key_check(String kn_session_key) throws Exception;

	//모든 유저 상제 정보 조회
	public List<Map<String, Object>> kn_employee_select(SearchCriteria scri) throws Exception;
	
	//모든 유저 총 명수 조회
	public String kn_employee_all_count(SearchCriteria scri) throws Exception;
}
