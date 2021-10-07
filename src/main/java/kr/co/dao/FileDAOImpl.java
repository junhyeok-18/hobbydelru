package kr.co.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.vo.FileVO;
import kr.co.vo.SearchCriteria;

@Repository
public class FileDAOImpl implements FileDAO{
	@Inject
	private SqlSession sqlSession;
	
	//일반사용자 파일 조회
	@Override
	public List<Map<String, Object>> user_kn_file_select(SearchCriteria scri) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FileMapper.user_kn_file_select", scri);
	}

	//일반사용자 파일 총 개수 조회
	@Override
	public String user_kn_file_all_count(SearchCriteria scri) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FileMapper.user_kn_file_all_count", scri);
	}
	
	//관리사용자 파일 조회
	@Override
	public List<FileVO> admin_kn_file_select(SearchCriteria scri) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FileMapper.admin_kn_file_select", scri);
	}
	
	//파일 총 개수 조회
	@Override
	public String kn_file_all_count(SearchCriteria scri) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FileMapper.kn_file_all_count", scri);
	}
	
	//파일 업로드 전 로그인한 사용자 사번, 업로드 당일, 같은 파일명이 있는지 확인
	@Override
	public Map<String, Object> kn_file_upload_check(Map<String, Object> map)
			throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FileMapper.kn_file_upload_check", map);
	}
	
	//파일 업로드
	@Override
	public void kn_file_upload(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("FileMapper.kn_file_upload", map);
	}
	
	//파일 다운
	@Override
	public Map<String, Object> kn_file_down(String kn_file_code) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FileMapper.kn_file_down", kn_file_code);
	}

	//파일 삭제
	@Override
	public void kn_file_delete(String kn_file_code) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("FileMapper.kn_file_delete", kn_file_code);
	}
	
	
}
