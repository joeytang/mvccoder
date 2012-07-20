package com.wanmei.domain;

import java.util.LinkedHashMap;
import java.util.Map;

public class DaoHelper {

	public static final byte TYPE_HBM3 = 1;
	public static final byte TYPE_IBATIS3 = 2;
	public static Map<Byte,String> typeMap = new LinkedHashMap<Byte,String>();
    static {
    	typeMap.put(TYPE_HBM3, "Hibernate");
    	typeMap.put(TYPE_IBATIS3, "Ibatis3");
    }
	
}
