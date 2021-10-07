package kr.co.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	private String LOGIN = null;
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    	//session 객체를 가져옴
		HttpSession session = request.getSession();
		
		String url = request.getRequestURI().toString();
		
		if("/user/login_action".equals(url)) {
			LOGIN = "user";
		} else if("/admin/login_action".equals(url)) {
			LOGIN = "admin";
		} else if("/help/login_action".equals(url)) {
			LOGIN = "help";
		} else {}
		
        Object uservo = session.getAttribute(LOGIN);

        if (uservo != null) {
        	logger.info("새로운 로그인 성공");
        	session.setAttribute(LOGIN, uservo);
            //response.sendRedirect("/main");
        }

    }

    //기존의 로그인 정보가 있을 시에 초기화
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	
        HttpSession session = request.getSession();
        
        String url = request.getRequestURI().toString();
		
		if("/user/login_action".equals(url)) {
			LOGIN = "user";
		} else if("/admin/login_action".equals(url)) {
			LOGIN = "admin";
		} else if("/help/login_action".equals(url)) {
			LOGIN = "help";
		} else {}
        
        // 기존의 로그인 정보 제거
        if (session.getAttribute(LOGIN) != null) {
        	logger.info("기존 로그인 데이터 삭제");
        	session.removeAttribute(LOGIN);
        }

        return true;
    }
}