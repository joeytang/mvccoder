package com.wanmei.domain;

import java.util.LinkedHashMap;
import java.util.Map;

public class FieldHelper {

	public static final byte TYPE_INT = 1;
	public static final byte TYPE_STRING = 2;
	public static final byte TYPE_LONG = 3;
	public static final byte TYPE_FLOAT = 4;
	public static final byte TYPE_DOUBLE = 5;
	public static final byte TYPE_DATE = 6;
	public static final byte TYPE_DATETIME = 7;
	public static final byte TYPE_TEXT = 8;
	public static final byte TYPE_CLOB = 9;
	public static final byte TYPE_BYTE = 10;
	public static final byte TYPE_BOOLEAN = 11;
	
	public static final byte TYPE_MANY2ONE = 12;
	public static final byte TYPE_ONE2MANY = 13;
	public static final byte TYPE_MANY2MANY = 14;
	
	public static final byte TYPE_FILE = 15;
	
	
	public static String getPrimaryType(byte type){
			switch(type){
			case FieldHelper.TYPE_INT:
				return "Integer";
			case FieldHelper.TYPE_STRING:
				return "String";
			case FieldHelper.TYPE_LONG:
				return "Long";
			case FieldHelper.TYPE_FLOAT:
				return "Float";
			case FieldHelper.TYPE_DOUBLE:
				return "Double";
			case FieldHelper.TYPE_BYTE:
				return "Byte";
			case FieldHelper.TYPE_TEXT:
				return "String";
			case FieldHelper.TYPE_CLOB:
				return "String";
			case FieldHelper.TYPE_BOOLEAN:
				return "Boolean";
			}
			return "String";
	}
	public static String getLowPrimaryType(byte type){
		switch(type){
		case FieldHelper.TYPE_INT:
			return "int";
		case FieldHelper.TYPE_STRING:
			return "String";
		case FieldHelper.TYPE_LONG:
			return "long";
		case FieldHelper.TYPE_FLOAT:
			return "float";
		case FieldHelper.TYPE_DOUBLE:
			return "double";
		case FieldHelper.TYPE_BYTE:
			return "byte";
		case FieldHelper.TYPE_TEXT:
			return "String";
		case FieldHelper.TYPE_CLOB:
			return "String";
		case FieldHelper.TYPE_BOOLEAN:
			return "boolean";
		}
		return "String";
	}
	public static String getDictValue(byte type){
		switch(type){
		case FieldHelper.TYPE_INT:
			return "1";
		case FieldHelper.TYPE_LONG:
			return "1";
		case FieldHelper.TYPE_FLOAT:
			return "1";
		case FieldHelper.TYPE_DOUBLE:
			return "1";
		case FieldHelper.TYPE_BYTE:
			return "1";
		case FieldHelper.TYPE_BOOLEAN:
			return "true";
		}
		return "\"test\"";
	}
	public static Map<Byte,String> typeMap = new LinkedHashMap<Byte,String>();
    static {
    	typeMap.put(TYPE_INT, "Integer");
    	typeMap.put(TYPE_STRING, "String");
    	typeMap.put(TYPE_LONG, "Long");
    	typeMap.put(TYPE_FLOAT, "Float");
    	typeMap.put(TYPE_DOUBLE, "Double");
    	typeMap.put(TYPE_BYTE, "Byte");
    	typeMap.put(TYPE_DATE, "日期类型");
    	typeMap.put(TYPE_DATETIME, "日期时间类型");
    	typeMap.put(TYPE_TEXT, "长String用于textarea");
    	typeMap.put(TYPE_CLOB, "大文本String用于富编辑器");
    	typeMap.put(TYPE_BOOLEAN, "Boolean");
    	typeMap.put(TYPE_MANY2ONE, "多对一");
    	typeMap.put(TYPE_ONE2MANY, "一对多");
    	typeMap.put(TYPE_MANY2MANY, "多对多");
    	typeMap.put(TYPE_FILE, "文件域");
    }
    
    public static final byte CATEGORY_COMM = 1;
    public static final byte CATEGORY_ID = 2;
    public static Map<Byte,String> categoryMap = new LinkedHashMap<Byte,String>();
    static {
    	categoryMap.put(CATEGORY_COMM, "普通列");
    	categoryMap.put(CATEGORY_ID, "主键列");
    }
	
    public static final byte MANY2ONETYPE_LIST = 1;
    public static final byte MANY2ONETYPE_SELECT = 2;
    public static Map<Byte,String> many2OneTypeMap = new LinkedHashMap<Byte,String>();
    static {
    	many2OneTypeMap.put(MANY2ONETYPE_LIST, "列表页");
    	many2OneTypeMap.put(MANY2ONETYPE_SELECT, "下拉列表框");
    }
    
    public static final byte RELATION_TYPE_NONE = 1;
    public static final byte RELATION_TYPE_SELF = 2;
    public static final byte RELATION_TYPE_OTHER = 3;
    public static Map<Byte,String> relationTypeMap = new LinkedHashMap<Byte,String>();
    static {
    	relationTypeMap.put(RELATION_TYPE_NONE, "不维护关系");
    	relationTypeMap.put(RELATION_TYPE_SELF, "本方维护关系");
    	relationTypeMap.put(RELATION_TYPE_OTHER, "对方维护关系");
    }
}
