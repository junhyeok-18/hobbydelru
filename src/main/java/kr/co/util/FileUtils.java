package kr.co.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Calendar;
import java.text.DecimalFormat;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component("fileUtils")
public class FileUtils {
	public List<Map<String, Object>> parseInsertFileInfo(String kn_code, 
			MultipartHttpServletRequest mpRequest) throws Exception{
		
		/*
			Iterator은 데이터들의 집합체? 에서 컬렉션으로부터 정보를 얻어올 수 있는 인터페이스입니다.
			List나 배열은 순차적으로 데이터의 접근이 가능하지만, Map등의 클래스들은 순차적으로 접근할 수가 없습니다.
			Iterator을 이용하여 Map에 있는 데이터들을 while문을 이용하여 순차적으로 접근합니다.
		*/
		
		Iterator<String> iterator = mpRequest.getFileNames();
		
		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> listMap = null;
		
		// 파일이 저장될 위치
		String filepath = File.separator + "home" + File.separator + "knightnet_upload_file" + File.separator + kn_code;
		
		//업로드할 디렉토리 (날짜별 폴더 생성)
		String savepath = calcPath(filepath);
		
		//파일 경로 (기존의 업로드 경로 + 날짜별 경로), 파일명을 받아 파일 객체 생성
		//File file = new File(filePath + kn_code + "/" + savepath);
		
		while(iterator.hasNext()) {
			multipartFile = mpRequest.getFile(iterator.next());
			if(multipartFile.isEmpty() == false) {
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = FilenameUtils.getExtension(originalFileName);
				
				File file = new File(filepath + savepath, originalFileName);
				multipartFile.transferTo(file);
				listMap = new HashMap<String, Object>();
				listMap.put("kn_code", kn_code);
				listMap.put("kn_org_file_name", originalFileName);
				listMap.put("kn_file_extension", originalFileExtension);
				listMap.put("kn_file_size", multipartFile.getSize());
				listMap.put("kn_file_address", filepath + savepath);
				list.add(listMap);
			}
		}
		return list;
	}
	
	// 날짜별 디렉토리 추출
    private static String calcPath(String uploadPath) {
        Calendar cal = Calendar.getInstance();
        // File.separator : 디렉토리 구분자(\\)
        // 연도, ex) \\2017 
        String yearPath = File.separator + cal.get(Calendar.YEAR);
        // 월, ex) \\2017\\03
        String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
        // 날짜, ex) \\2017\\03\\01
        String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
        // 디렉토리 생성 메서드 호출
        makeDir(uploadPath, yearPath, monthPath, datePath);
        return datePath;
    }

    // 디렉토리 생성
    private static void makeDir(String uploadPath, String... paths) {
        // 디렉토리가 존재하면
        if (new File(paths[paths.length - 1]).exists()){
            return;
        }
        // 디렉토리가 존재하지 않으면
        for (String path : paths) {
            // 
            File dirPath = new File(uploadPath + path);
            // 디렉토리가 존재하지 않으면
            if (!dirPath.exists()) {
                dirPath.mkdirs(); //디렉토리 생성
            }
        }
    }    
}