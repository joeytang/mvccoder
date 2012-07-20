package com.wanmei.domain;

import java.util.LinkedHashMap;
import java.util.Map;

public class SecurityHelper {

	public static final byte TYPE_SIMPLE = 1;
	public static final byte TYPE_COMPLEX = 2;
	
	public static final byte ID_TYPE_INTEGER = 1;
	public static final byte ID_TYPE_LONG = 2;
	
	
	public static Map<Byte,String> typeMap = new LinkedHashMap<Byte,String>();
    static {
    	typeMap.put(TYPE_SIMPLE, "简单权限管理");
    	typeMap.put(TYPE_COMPLEX, "复杂权限管理");
    }
}
