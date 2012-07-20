package com.wanmei.web.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wanmei.support.UserContext;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 对需要登录的页面，进行拦截。
 * 如果没有登录，请求被拦截，并跳转到登录页面，否则请求可以通过
 * @author joeytang
 * Date: 2012-03-20 18:17
 */
@Service
public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		if (null == UserContext.getSessionUser(request)) {
			request.setAttribute("isLogin", false);
			RequestDispatcher rd = 
				request.getRequestDispatcher(request.getServletPath()+"/admin/message.jsp");
			rd.forward(request, response);
			return false;
		}
		
		return true;
	}
	
}
