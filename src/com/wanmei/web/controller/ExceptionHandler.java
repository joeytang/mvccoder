package com.wanmei.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.wanmei.util.RenderUtils;

@Service
public class ExceptionHandler implements HandlerExceptionResolver {
	@Override
	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {
		ex.printStackTrace();
		String statusTxt = RenderUtils.getStatusSystem().toString();
		RenderUtils.renderHtml(response, statusTxt);
		return null;
	}   
  
}  
