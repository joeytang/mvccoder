package com.wanmei.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * 操作cookie
 */
public class CookieUtils {
	/**
	 * 获取cookie
	 * 
	 * @param request
	 * @param name
	 * @return
	 */
	public static Cookie getCookie(HttpServletRequest request, String name){
		Cookie[] cookies = request.getCookies();
		if(null != cookies){
			for(Cookie cookie:cookies){
				if(cookie.getName().equals(name)){
					return cookie;
				}
			}
		}
		return null;
	}
	/**
	 * 获取cookie 的值
	 * 
	 * @param request
	 * @param name
	 * @return
	 */
	public static String getCookieValue(HttpServletRequest request, String name){
		Cookie cookie = getCookie(request,name);
		if(null != cookie){
			return cookie.getValue();
		}
		return null;
	}
	/**
	 * 保存 cookie
	 * @param response
	 * @param name cookie 名称
	 * @param value cookie 名称
	 */
	public static void saveCookie(HttpServletResponse response, String name, String value){
		saveCookie(response,name,value,null,null);
	}
	/**
	 * 保存 cookie
	 * @param response
	 * @param name cookie 名称
	 * @param value cookie 名称
	 * @param path cookie 路径，null不设置子路径
	 * @param maxage cookie 保存时间 ，null设置一星期
	 */
	public static void saveCookie(HttpServletResponse response, String name, String value,String path,Integer maxage){
		
		Cookie cookie = new Cookie(name, value);
		if(null != path){
			if(!path.startsWith("/")){
				path = "/" + path;
			}
			cookie.setPath(path);
		}
		if(null == maxage){
			maxage = 7*24*60*60;
		}
		cookie.setMaxAge(maxage);
		response.addCookie(cookie);
	}
}