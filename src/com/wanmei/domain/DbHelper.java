package com.wanmei.domain;

import java.util.LinkedHashMap;
import java.util.Map;

public class DbHelper {

	public static final byte TYPE_MYSQL = 1;
	public static final byte TYPE_ORACAL = 2;
	public static Map<Byte,String> typeMap = new LinkedHashMap<Byte,String>();
    static {
    	typeMap.put(TYPE_MYSQL, "MySql");
    	typeMap.put(TYPE_ORACAL, "ORACAL");
    }
}
