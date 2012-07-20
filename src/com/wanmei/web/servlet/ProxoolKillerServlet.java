package com.wanmei.web.servlet;

import javax.servlet.http.HttpServlet;

import org.logicalcobwebs.proxool.ProxoolFacade;

/**
 * User: joeytang
 * Date: 2012-03-20 18:17
 *  重启关闭proxool
 */
public class ProxoolKillerServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void destroy(){
		ProxoolFacade.shutdown();
	}
}
