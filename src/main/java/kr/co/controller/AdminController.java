package kr.co.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.net.URLEncoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
import org.apache.tika.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.util.WebUtils;

import kr.co.service.DepartmentService;
import kr.co.service.FileService;
import kr.co.service.PositionService;
import kr.co.service.RankService;
import kr.co.service.UserService;
import kr.co.vo.Criteria;
import kr.co.vo.PageMaker;
import kr.co.vo.SearchCriteria;
import kr.co.vo.UserVO;

@Controller
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

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
	
	//관리사용자 로그인 화면
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String Admin_Login(Model model, HttpSession session) throws Exception{
		logger.info("관리사용자 로그인 화면");
		
		return "/admin/login";
	}
	
	//관리사용자 로그인 액션
	@ResponseBody
	@RequestMapping(value = "/admin/login_action", method = RequestMethod.POST)
	public String Admin_LoginAction(UserVO uservo, HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		logger.info("관리사용자 로그인 액션");

		//자동로그인 클릭 유무
		String auto_login_check = request.getParameter("auto_login");
		
		//로그인 성공 유무
		String login_check = "2";
		
		UserVO user_login = user_service.admin_login(uservo);
		boolean pwdMatch = pwdEncoder.matches(uservo.getKn_pw(), user_login.getKn_pw());
		
		//로그인 성공
		if(user_login != null && pwdMatch ==  true) {
			login_check = "1";
			user_login.setKn_pw("");
			session.setMaxInactiveInterval(10*60); //초단위
			session.setAttribute("admin", user_login);
			
			//자동로그인 클릭했을 시
			if("auto_login".equals(auto_login_check)) {
				//쿠키 체크 검사
				Cookie cookie = new Cookie("admin_auto_login", session.getId());
				cookie.setPath("/admin");
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
	
	//관리사용자 로그아웃
	@RequestMapping(value = "/admin/logout", method = RequestMethod.GET)
	public String Admin_Logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("관리사용자 로그아웃");
		
		Object object = session.getAttribute("admin");
	    if (object != null) {
	        UserVO uservo = (UserVO) object;
	        session.removeAttribute("admin");
	        session.invalidate();
	        Cookie loginCookie = WebUtils.getCookie(request, "admin_auto_login");
	        if (loginCookie != null) {
	            loginCookie.setPath("/");
	            loginCookie.setMaxAge(0);
	            response.addCookie(loginCookie);
	            user_service.user_keep_login(uservo.getKn_code(), "none", new Date());
	        }
	    }
		
		return "redirect:/";
	}
	
	//관리사용자 메인
	@RequestMapping(value = "/admin/main", method = RequestMethod.GET)
	public String Admin_Main(UserVO uservo, Model model, HttpSession session, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
		logger.info("관리사용자 메인 화면");
		
		model.addAttribute("admin_kn_file_select", file_service.admin_kn_file_select(scri));
		
		PageMaker pagemaker = new PageMaker();
		pagemaker.setCri(scri);
		pagemaker.setTotalCount(Integer.parseInt(file_service.kn_file_all_count(scri)));
		
		model.addAttribute("pageMaker", pagemaker);
		
		List<Map<String, Object>> kn_department = department_service.kn_department_select();
		model.addAttribute("kn_department", kn_department);
		
		List<Map<String, Object>> kn_rank = rank_service.kn_rank_select();
		model.addAttribute("kn_rank", kn_rank);
		
		List<Map<String, Object>> kn_position = position_service.kn_position_select();
		model.addAttribute("kn_position", kn_position);
		
		return "/admin/main";
	}
	
	//관리사용자 파일다운로드
	@RequestMapping(value="/admin/file_down_action")
	public void fileDown(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("관리사용자 파일다운 액션");
		
		String kn_file_code = request.getParameter("kn_file_code");
		
		Map<String, Object> resultMap = file_service.kn_file_down(kn_file_code);
		String kn_org_file_name = (String) resultMap.get("kn_org_file_name");
		String kn_file_address = (String) resultMap.get("kn_file_address");
		
		//파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환한다.
		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File(kn_file_address + "/" + kn_org_file_name));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		kn_org_file_name = URLEncoder.encode(kn_org_file_name, "UTF-8");
		kn_org_file_name = kn_org_file_name.replaceAll("\\+", "%20");
		response.setHeader("Content-Disposition",  "attachment; fileName=\"" + kn_org_file_name + "\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
	
}
