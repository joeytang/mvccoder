package com.wanmei.domain;

import java.util.LinkedHashMap;
import java.util.Map;

public class ControllerHelper {

	public static final byte TYPE_LIST = 1;
	public static final byte TYPE_INPUT = 2;
	public static final byte TYPE_SAVE = 3;
	public static final byte TYPE_REMOVE = 4;
	public static Map<Byte,String> typeMap = new LinkedHashMap<Byte,String>();
    static {
    	typeMap.put(TYPE_LIST, "列表");
    	typeMap.put(TYPE_INPUT, "添加修改");
    	typeMap.put(TYPE_SAVE, "保存");
    	typeMap.put(TYPE_REMOVE, "删除");
    }
}
