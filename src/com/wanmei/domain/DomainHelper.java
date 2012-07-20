package com.wanmei.domain;

import java.util.LinkedHashMap;
import java.util.Map;

public class DomainHelper {
	
	public static final byte TYPE_HBM3 = 1;
	public static final byte TYPE_IBATIS3 = 2;
	

	public static final byte CHECK_TYPE_RADIO = 1;
	public static final byte CHECK_TYPE_CHECKBOX = 2;
	public static final byte CHECK_TYPE_NOCHECK = 3;
	
	public static String getStr(){
		return "test static";
	}
	
	public static Map<Byte,String> checkTypeMap = new LinkedHashMap<Byte,String>();
    static {
    	checkTypeMap.put(CHECK_TYPE_CHECKBOX, "多选");
    	checkTypeMap.put(CHECK_TYPE_RADIO, "单选");
    	checkTypeMap.put(CHECK_TYPE_NOCHECK, "没有选择框");
    }
	
	
}
