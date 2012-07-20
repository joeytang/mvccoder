package com.wanmei.util;

import java.io.File;

public class ClassUtil {
	public static String[] DOMAINNAMES = {".domain",".base"};
	public static String getClassName(String name){
		if(null == name){
			return null;
		}
		if(name.indexOf(".") < -1){
			return name;
		}
		return name.substring(name.lastIndexOf(".")+1);
	}
	
	public static String getClassPackage(String name){
		if(null == name || name.indexOf(".") < 0){
			return null;
		}
		name = name.substring(0,name.lastIndexOf("."));
		for(String s:DOMAINNAMES){
			if(name.endsWith(s)){
				name = name.replace(s, "");
			}
		}
		return name;
	}
	
	public static String getDomainClassRealPackage(String name){
		if(null == name || name.indexOf(".") < 0){
			return null;
		}
		name = name.substring(0,name.lastIndexOf("."));
		return name;
	}
	
	public static String classToPath(String name){
		if(null == name){
			return null;
		}
		if(getClassPackage(name) == null){
			return File.separator;
		}
		return File.separator+getClassPackage(name).replace(".", File.separator);
	}
	
	public static String packageToPath(String name){
		if(null == name){
			return null;
		}
		return File.separator+name.replace(".", File.separator);
	}
}
