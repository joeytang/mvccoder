package com.wanmei.domain.helper;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * User: joeytang
 * Date: 2012-03-20 18:17
 */
public class UserHelper {
	/**
	 * 状态
	 */
	public final static byte STATUS_OK = 0;//用户正常
    public final static byte STATUS_DELETED = -1;//用户已被删除
    /**
     * 角色
     */
    public final static String ROLE_ADMIN = "ROLE_ADMIN";//管理员
    public final static String ROLE_USER = "ROLE_USER";//其他用户
    public static Map<String,String> roleMap = new LinkedHashMap<String,String>();
    static {
    	roleMap.put(ROLE_ADMIN, "管理员");
    	roleMap.put(ROLE_USER, "普通用户");
    }
}


