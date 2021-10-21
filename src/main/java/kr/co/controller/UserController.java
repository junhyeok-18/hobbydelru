package kr.co.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tika.Tika;
import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.util.WebUtils;

import kr.co.service.DepartmentService;
import kr.co.service.FileService;
import kr.co.service.PositionService;
import kr.co.service.RankService;
import kr.co.service.UserService;
import kr.co.vo.PageMaker;
import kr.co.vo.SearchCriteria;
import kr.co.vo.UserVO;

@Controller
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Inject
	private UserService user_service;
	
	@Inject
	private FileService file_service;
	
	@Inject
	private DepartmentService department_service;
	
	@Inject
	private RankService rank_service;
	
	@Inject
	private PositionService position_service;
	
	@Inject
	private BCryptPasswordEncoder pwdEncoder;
	
	//사용자 메인 화면
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String User_Main(Model model, HttpSession session) throws Exception{
		logger.info("사용자 메인 화면");
		
		return "/user/main";
	}
	
	//사용자 메인 화면 홈 불러오기
	@RequestMapping(value = "home", method = RequestMethod.GET)
	public String User_Main_Home(Model model, HttpSession session) throws Exception{
		logger.info("사용자 메인 화면 홈 불러오기");
		
		return "/user/home";
	}

	//사용자 메인 화면 랭킹 불러오기
	@RequestMapping(value = "ranking", method = RequestMethod.GET)
	public String User_Main_Ranking(Model model, HttpSession session) throws Exception{
		logger.info("사용자 메인 화면 랭킹 불러오기");
		
		return "/user/ranking";
	}
	
	//사용자 메인 화면 하비델루 불러오기
	@RequestMapping(value = "hobbydelru", method = RequestMethod.GET)
	public String User_Main_Hobbydelru(Model model, HttpSession session) throws Exception{
		logger.info("사용자 메인 화면 하비델루 불러오기");
		
		return "/user/hobbydelru";
	}
	
	//사용자 메인 화면 요청 불러오기
	@RequestMapping(value = "productrequest", method = RequestMethod.GET)
	public String User_Main_Product_Request(Model model, HttpSession session) throws Exception{
		logger.info("사용자 메인 화면 요청 불러오기");
		
		return "/user/productrequest";
	}
	
	//사용자 메인 화면 내정보 불러오기
	@RequestMapping(value = "myinfo", method = RequestMethod.GET)
	public String User_Main_My_Info(Model model, HttpSession session) throws Exception{
		logger.info("사용자 메인 화면 내정보 불러오기");
		
		return "/user/myinfo";
	}
	
	//사용자 메인 화면 로그인 불러오기
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String User_Main_Login(Model model, HttpSession session) throws Exception{
		logger.info("사용자 메인 화면 로그인 불러오기");
		
		return "/user/login";
	}
	
	
	
	
	
	
	
	
	//일반사용자 로그인 액션
	@ResponseBody
	@RequestMapping(value = "/user/login_action", method = RequestMethod.POST)
	public String User_LoginAction(UserVO uservo, HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		logger.info("일반사용자 로그인 액션");

		//자동로그인 클릭 유무
		String auto_login_check = request.getParameter("auto_login");
		
		//로그인 성공 유무
		String login_check = "2";
		
		UserVO user_login = user_service.user_login(uservo);
		boolean pwdMatch = pwdEncoder.matches(uservo.getKn_pw(), user_login.getKn_pw());
		
		//로그인 성공
		if(user_login != null && pwdMatch ==  true) {
			login_check = "1";
			user_login.setKn_pw("");
			session.setMaxInactiveInterval(10*60); //초단위
			session.setAttribute("user", user_login);
			
			//자동로그인 클릭했을 시
			if("auto_login".equals(auto_login_check)) {
				//쿠키 체크 검사
				Cookie cookie = new Cookie("user_auto_login", session.getId());
				cookie.setPath("/");
				int amount = 60 * 60 * 24 * 7; //7일
				cookie.setMaxAge(amount); //기간을 일주일로 지정
				response.addCookie(cookie);
				
				Date user_session_limit = new Date(System.currentTimeMillis() + (1000 * amount));
				user_service.user_keep_login(user_login.getKn_code(), session.getId(), user_session_limit);
			} else {}
		} else {
			//로그인 실패
			login_check = "0";
		}
		
		return login_check;
	}
	
	//일반사용자 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String User_Logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("일반사용자 로그아웃");
		
		Object object = session.getAttribute("user");
	    if (object != null) {
	        UserVO uservo = (UserVO) object;
	        session.removeAttribute("user");
	        session.invalidate();
	        Cookie loginCookie = WebUtils.getCookie(request, "user_auto_login");
	        if (loginCookie != null) {
	            loginCookie.setPath("/");
	            loginCookie.setMaxAge(0);
	            response.addCookie(loginCookie);
	            user_service.user_keep_login(uservo.getKn_id(), "none", new Date());
	        }
	    }
		
		return "redirect:/";
	}
	
	//일반사용자 회원가입 화면
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String User_Join(Model model, HttpSession session) throws Exception{
		logger.info("일반사용자 회원가입 화면");
		
		List<Map<String, Object>> kn_department = department_service.kn_department_select();
		model.addAttribute("kn_department", kn_department);
		
		List<Map<String, Object>> kn_rank = rank_service.kn_rank_select();
		model.addAttribute("kn_rank", kn_rank);
		
		List<Map<String, Object>> kn_position = position_service.kn_position_select();
		model.addAttribute("kn_position", kn_position);
		
		return "/user/join";
	}
	
	//일반사용자 회원가입 액션
	@ResponseBody
	@RequestMapping(value = "/user/join_action", method = RequestMethod.POST)
	public String User_JoinAction(UserVO uservo) throws Exception {
		logger.info("일반사용자 회원가입 액션");
		
		String pwd = pwdEncoder.encode(uservo.getKn_pw());
		uservo.setKn_pw(pwd);
		
		user_service.user_join(uservo);
		
		return "1";
	}
	
	//일반사용자 메인
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String User_Main(UserVO uservo, Model model, HttpSession session, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
		logger.info("일반사용자 메인 화면");

		//kn_code를 얻기 위한 세션 받아오기
		Object object = session.getAttribute("user");
		uservo = (UserVO) object;
		
		scri.setKn_code(uservo.getKn_code());
		
		List<Map<String, Object>> user_kn_file_select = file_service.user_kn_file_select(scri);
		model.addAttribute("file", user_kn_file_select);		
		
		PageMaker pagemaker = new PageMaker();
		pagemaker.setCri(scri);
		pagemaker.setTotalCount(Integer.parseInt(file_service.user_kn_file_all_count(scri)));
		
		model.addAttribute("pageMaker", pagemaker);
		
		Date today = new Date();
		SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
		model.addAttribute("today", date.format(today));		
		
		return "/user/main";
	}
	
	//일반사용자 파일업로드 액션
	@ResponseBody
	@RequestMapping(value = "/user/upload_action", method = RequestMethod.POST)
	public String User_File_UploadAction(UserVO uservo, MultipartHttpServletRequest mpRequest, HttpSession session) throws Exception {
		logger.info("일반사용자 파일업로드 액션");
		
		//업로드 완료 유무
		String upload_check = "2";
		
		//kn_code를 얻기 위한 세션 받아오기
		Object object = session.getAttribute("user");
		uservo = (UserVO) object;
		
		String kn_code = uservo.getKn_code();
		
		//업로드 가능한 확장자 hwp/xls/xlsx/ppt/pptx/doc/docx/txt/jpg/jpeg/png
		final String[] PERMISSION_FILE_MIME_TYPE = {
		"application/x-hwp", "application/haansofthwp", "application/vnd.hancom.hwp",
		"application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
		"application/vnd.ms-powerpoint", "application/vnd.openxmlformats-officedocument.presentationml.presentation",
		"application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
		"text/txt", "text/plain", "image/jpg", "image/jpeg", "image/png", "audio/mpeg", "video/x-msvideo"};
		
		final String[] file_type = {"hwp", "xls", "xlsx", "ppt", "pptx", "doc", "docx", "txt", "jpg", "jpeg", "png"};
	
		InputStream inputstream = mpRequest.getFile("kn_file").getInputStream();
		String mimetype = new Tika().detect(inputstream);
		System.out.println("MIME TYPE : " + mimetype);
		
		String kn_org_file_name = mpRequest.getFile("kn_file").getOriginalFilename();
		String kn_file_extension = FilenameUtils.getExtension(kn_org_file_name);
		
		for(int i=0; i<file_type.length; i++) {
			if(file_type[i].equals(kn_file_extension)) {
				upload_check = "1";
				Map<String, Object> resultMap = file_service.kn_file_upload_check(kn_code, kn_org_file_name, kn_file_extension);
				
				//만약 로그인한 사용자, 당일, 파일명, 확장자가 같은 파일이 있다면 해당 파일코드를 이용하여 이력과 파일을 함께 삭제
				if(resultMap != null && !resultMap.isEmpty()) {
					String kn_file_code = String.valueOf(resultMap.get("kn_file_code"));
					String kn_org_file_name_map = (String) resultMap.get("kn_org_file_name");
					String kn_file_address = (String) resultMap.get("kn_file_address");
					
					// 삭제할 파일의 경로
					File file = new File(kn_file_address + "/" + kn_org_file_name_map);
					if(file.exists() == true){
						file.delete();
					}
					
					file_service.kn_file_delete(kn_file_code);
					file_service.kn_file_upload(kn_code, mpRequest);
				} else {
					file_service.kn_file_upload(kn_code, mpRequest);
				}
				
				break;
			} else {
				System.out.println("파일 확장자가 알맞지 않아서 실패");
			}
		}
		
		return upload_check;
	}
	
	//일반사용자 파일삭제 액션
	@ResponseBody
	@RequestMapping(value = "/user/delete_action", method = RequestMethod.POST)
	public String User_File_DeleteAction(HttpServletRequest request, Model model) throws Exception {
		logger.info("일반사용자 파일 삭제 액션");
		
		String delete_check = "2";
		
		String kn_file_code = request.getParameter("kn_file_code");
		String kn_reg_date = request.getParameter("kn_reg_date");
		
		Date today = new Date();
		SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
		model.addAttribute("today", date.format(today));		
		
		if(date.format(today).equals(kn_reg_date)) {
			delete_check = "1";
			Map<String, Object> resultMap = file_service.kn_file_down(kn_file_code);
			
			String kn_org_file_name_map = (String) resultMap.get("kn_org_file_name");
			String kn_file_address = (String) resultMap.get("kn_file_address");
			
			// 삭제할 파일의 경로
			File file = new File(kn_file_address + "/" + kn_org_file_name_map);
			if(file.exists() == true){
				file.delete();
			}
			
			file_service.kn_file_delete(kn_file_code);
		} else {
			delete_check = "0";
		}
		
		return delete_check;
	}
	
	//일반사용자 아이디 중복확인
	@ResponseBody
	@RequestMapping(value = "/user/id_check_action", method = RequestMethod.POST)
	public int User_ID_CheckAction(HttpServletRequest request) throws Exception {
		logger.info("일반사용자 아이디 중복확인 액션");
		
		System.out.println(request.getParameter("kn_id"));
		
		int result = user_service.user_id_check(request.getParameter("kn_id"));
		
		return result;
	}
}
