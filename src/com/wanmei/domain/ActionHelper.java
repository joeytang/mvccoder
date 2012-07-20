package com.wanmei.domain;

import java.util.LinkedHashMap;
import java.util.Map;

public class ActionHelper {

	public static final byte TYPE_SPRINGMVC3 = 1;
	public static final byte TYPE_STRUTS2 = 2;
	public static Map<Byte,String> typeMap = new LinkedHashMap<Byte,String>();
    static {
    	typeMap.put(TYPE_SPRINGMVC3, "Spring MVC");
    	typeMap.put(TYPE_STRUTS2, "Struts2");
    }
}
