package com.wanmei.domain;

import java.util.LinkedHashMap;
import java.util.Map;

public class ProjectHelper {

	public static final byte PRO_TYPE_COMMON = 1;
	public static final byte PRO_TYPE_MVN = 2;
	
	/**
	 * 项目生成代码的类型
	 */
	public static final byte CODE_TYPE_VIEW = 1; //前台代码
	public static final byte CODE_TYPE_BACK = 2;//后台代码
	public static final byte CODE_TYPE_ALL = 3;//前后台代码
	
	public static Map<Byte,String> proTypeMap = new LinkedHashMap<Byte,String>();
	static {
		proTypeMap.put(PRO_TYPE_COMMON, "普通动态web项目");
		proTypeMap.put(PRO_TYPE_MVN, "MAVEN项目");
	}
	public static Map<Byte,String> codeTypeMap = new LinkedHashMap<Byte,String>();
    static {
    	codeTypeMap.put(CODE_TYPE_VIEW, "前台代码");
    	codeTypeMap.put(CODE_TYPE_BACK, "后台代码");
    	codeTypeMap.put(CODE_TYPE_ALL, "前后台代码");
    }
}
