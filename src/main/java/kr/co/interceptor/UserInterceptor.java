package kr.co.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import kr.co.service.UserService;
import kr.co.vo.UserVO;

public class UserInterceptor extends HandlerInterceptorAdapter {
	@Inject
	UserService user_service;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession httpSession = request.getSession();
		
		String url = request.getRequestURI().toString();
		
		if("/".equals(url)) {
			Cookie user_auto_login = WebUtils.getCookie(request, "user_auto_login");
	        if (user_auto_login != null) {
	            UserVO userVO = user_service.user_session_key_check(user_auto_login.getValue());
	            if (userVO != null) {
	                httpSession.setAttribute("user", userVO);
	                response.sendRedirect("/main");
	            }
	        }
		} else if("/admin".equals(url)) {
			Cookie admin_auto_login = WebUtils.getCookie(request, "admin_auto_login");
	        if (admin_auto_login != null) {
	            UserVO userVO = user_service.user_session_key_check(admin_auto_login.getValue());
	            if (userVO != null) {
	                httpSession.setAttribute("admin", userVO);
	                response.sendRedirect("/admin/main");
	            }
	        }
		} else if("/help".equals(url)) {
			Cookie help_auto_login = WebUtils.getCookie(request, "help_auto_login");
	        if (help_auto_login != null) {
	            UserVO userVO = user_service.user_session_key_check(help_auto_login.getValue());
	            if (userVO != null) {
	                httpSession.setAttribute("help", userVO);
	                response.sendRedirect("/help/main");
	            }
	        }
		} else {}
		
        
        return true;
	}
}