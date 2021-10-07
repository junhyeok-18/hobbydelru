package kr.co.service;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.dao.FileDAO;
import kr.co.util.FileUtils;
import kr.co.vo.FileVO;
import kr.co.vo.SearchCriteria;

@Service
public class FileServiceImpl implements FileService{
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Inject
	private FileDAO dao;
	
	//일반사용자 파일 조회
	@Override
	public List<Map<String, Object>> user_kn_file_select(SearchCriteria scri) throws Exception {
		// TODO Auto-generated method stub
		return dao.user_kn_file_select(scri);
	}

	//일반사용자 파일 총 개수 조회
	@Override
	public String user_kn_file_all_count(SearchCriteria scri) throws Exception {
		// TODO Auto-generated method stub
		return dao.user_kn_file_all_count(scri);
	}
	
	//관리사용자 파일 조회
	@Override
	public List<FileVO> admin_kn_file_select(SearchCriteria scri) throws Exception {
		// TODO Auto-generated method stub
		return dao.admin_kn_file_select(scri);
	}
	
	//파일 총 개수 조회
	@Override
	public String kn_file_all_count(SearchCriteria scri) throws Exception {
		// TODO Auto-generated method stub
		return dao.kn_file_all_count(scri);
	}
	
	//파일 업로드 전 로그인한 사용자 사번, 업로드 당일, 같은 파일명이 있는지 확인
	@Override
	public Map<String, Object> kn_file_upload_check(String kn_code, String kn_org_file_name, String kn_file_extension)
			throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("kn_code", kn_code);
		map.put("kn_org_file_name", kn_org_file_name);
		map.put("kn_file_extension", kn_file_extension);
		
		return dao.kn_file_upload_check(map);
	}
	
	//파일 업로드
	@Override
	public void kn_file_upload(String kn_code, MultipartHttpServletRequest mpRequest) throws Exception {
		// TODO Auto-generated method stub
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(kn_code, mpRequest); 
		int size = list.size();
		for(int i=0; i<size; i++){ 
			dao.kn_file_upload(list.get(i));; 
		}
	}
	
	//파일 다운
	@Override
	public Map<String, Object> kn_file_down(String kn_file_code) throws Exception {
		// TODO Auto-generated method stub
		return dao.kn_file_down(kn_file_code);
	}

	//파일 삭제
	@Override
	public void kn_file_delete(String kn_file_code) throws Exception {
		// TODO Auto-generated method stub
		dao.kn_file_delete(kn_file_code);
	}


}
