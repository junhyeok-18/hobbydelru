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
import org.apache.tika.io.FilenameUtils;
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

import kr.co.service.FileService;
import kr.co.service.UserService;
import kr.co.vo.PageMaker;
import kr.co.vo.SearchCriteria;
import kr.co.vo.UserVO;

@Controller
public class HelpController {
	
	private static final Logger logger = LoggerFactory.getLogger(HelpController.class);

	@Inject
	private UserService user_service;
	
	@Inject
	private FileService file_service;
	
	@Inject
	private BCryptPasswordEncoder pwdEncoder;
	
	//관리자 로그인 화면
	@RequestMapping(value = "/help", method = RequestMethod.GET)
	public String User_Login(Model model, HttpSession session) throws Exception{
		logger.info("관리자 로그인 화면");
		
		return "/help/login";
	}
	
	//관리자 로그인 액션
	@ResponseBody
	@RequestMapping(value = "/help/login_action", method = RequestMethod.POST)
	public String Help_LoginAction(UserVO uservo, HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		logger.info("관리자 로그인 액션");

		//자동로그인 클릭 유무
		String auto_login_check = request.getParameter("auto_login");
		
		//로그인 성공 유무
		String login_check = "2";
		
		UserVO user_login = user_service.help_login(uservo);
		boolean pwdMatch = pwdEncoder.matches(uservo.getKn_pw(), user_login.getKn_pw());
		
		//로그인 성공
		if(user_login != null && pwdMatch ==  true) {
			login_check = "1";
			user_login.setKn_pw("");
			session.setMaxInactiveInterval(10*60); //초단위
			session.setAttribute("help", user_login);
			
			//자동로그인 클릭했을 시
			if("auto_login".equals(auto_login_check)) {
				//쿠키 체크 검사
				Cookie cookie = new Cookie("help_auto_login", session.getId());
				cookie.setPath("/");
				int amount = 60 * 60 * 24 * 7; //7일
				cookie.setMaxAge(amount); //기간을 일주일로 지정
				response.addCookie(cookie);
				
				Date user_session_limit = new Date(System.currentTimeMillis() + (1000 * amount));
				user_service.user_keep_login(uservo.getKn_id(), session.getId(), user_session_limit);
			} else {}
		} else {
			//로그인 실패
			login_check = "0";
		}
		
		return login_check;
	}
	
	//관리자 로그아웃
	@RequestMapping(value = "/help/logout", method = RequestMethod.GET)
	public String Help_Logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("관리자 로그아웃");
		
		Object object = session.getAttribute("help");
	    if (object != null) {
	        UserVO uservo = (UserVO) object;
	        session.removeAttribute("help");
	        session.invalidate();
	        Cookie loginCookie = WebUtils.getCookie(request, "help_auto_login");
	        if (loginCookie != null) {
	            loginCookie.setPath("/");
	            loginCookie.setMaxAge(0);
	            response.addCookie(loginCookie);
	            user_service.user_keep_login(uservo.getKn_id(), "none", new Date());
	        }
	    }
		
		return "redirect:/";
	}
	
	//관리자 메인
	@RequestMapping(value = "/help/main", method = RequestMethod.GET)
	public String Help_Main(UserVO uservo, Model model, HttpSession session, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
		logger.info("관리자 메인 화면");

		//등록된 파일의 총 개수 조회
		model.addAttribute("kn_file_all_count", file_service.kn_file_all_count(scri));		
		
		//등록된 사용자 상세 정보 조회
		List<Map<String, Object>> kn_employee_select = user_service.kn_employee_select(scri);
		model.addAttribute("kn_employee_select", kn_employee_select);
		
		PageMaker pagemaker = new PageMaker();
		pagemaker.setCri(scri);
		pagemaker.setTotalCount(Integer.parseInt(user_service.kn_employee_all_count(scri)));
		
		model.addAttribute("pageMaker", pagemaker);
		
		return "/help/main";
	}
	
}
