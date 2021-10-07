package kr.co.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.vo.FileVO;
import kr.co.vo.SearchCriteria;


public interface FileService {
	//일반사용자 파일 조회
	public List<Map<String, Object>> user_kn_file_select(SearchCriteria scri) throws Exception;
	
	//일반사용자 파일 총 개수 조회
	public String user_kn_file_all_count(SearchCriteria scri) throws Exception;
	
	//관리사용자 파일 조회
	public List<FileVO> admin_kn_file_select(SearchCriteria scri) throws Exception;
	
	//파일 총 개수 조회
	public String kn_file_all_count(SearchCriteria scri) throws Exception;
	
	//파일 업로드 전 로그인한 사용자 사번, 업로드 당일, 같은 파일명이 있는지 확인
	public Map<String, Object> kn_file_upload_check(String kn_code, String kn_org_file_name, String kn_file_extension) throws Exception;
	
	//파일 업로드
	public void kn_file_upload(String kn_code, MultipartHttpServletRequest mpRequest) throws Exception;
	
	//파일 다운
	public Map<String, Object> kn_file_down(String kn_file_code) throws Exception;
	
	//파일 삭제
	public void kn_file_delete(String kn_file_code) throws Exception;
}
