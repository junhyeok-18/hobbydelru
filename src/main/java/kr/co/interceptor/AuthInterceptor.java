package kr.co.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	private String LOGIN = null;
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession httpSession = request.getSession();

        String url = request.getRequestURI().toString();
		
		if("/main".equals(url)) {
			LOGIN = "user";
		} else if("/admin/main".equals(url)) {
			LOGIN = "admin";
		} else if("/help/main".equals(url)) {
			LOGIN = "help";
		} else {}
        
        if (httpSession.getAttribute(LOGIN) == null) {
            logger.info("현재사용자는 로그인이 되어있지 않습니다.");
            response.sendRedirect("/");
            return false;
        }

        return true;
    }
}