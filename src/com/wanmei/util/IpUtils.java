package com.wanmei.util;

import javax.servlet.http.HttpServletRequest;

/**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * IP工具
 */
public abstract class IpUtils {

	/**
	 * 得到标准IP格式字符串
	 * 
	 * @param request
	 * @return
	 */
	public static String getIp(HttpServletRequest request){
		
		//return request.getRemoteAddr();
		return getRealIp(request);
	}
	
	/**
	 * 得到Long型 IP
	 * 
	 * @param request
	 * @return
	 */
	public static long getLongIp(HttpServletRequest request){
		
		return IPToNumber.ipToLong(IpUtils.getIp(request));
	}
	
	public static long getRealLongIp(HttpServletRequest request){
		
		return IPToNumber.ipToLong(IpUtils.getRealIp(request));
	}


    public static long getLongIp(String ip){

		return IPToNumber.ipToLong(ip);
	}

	/**
     * 取用户的真实ip地址
     * 可以避免因为网关造成
     *
     * @param request
     * @return ip
     */
    public static String getRealIp(HttpServletRequest request) {

        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        if (ip == null || ip.length() == 0)
            ip = "127.127.127.127";
        return ip;

    }
}
