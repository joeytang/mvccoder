package com.wanmei.tool.elfunc;

import org.springframework.util.ClassUtils;
import org.springframework.util.ReflectionUtils;
/**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * el表达式
 */
public class CustomFunctions {
	public static  Object getVar(String clazz,String var){
		try {
			Class<?> cls = ClassUtils.resolveClassName(clazz, ClassUtils.getDefaultClassLoader());
			return ReflectionUtils.findField(cls, var).get(clazz);
		} catch (IllegalArgumentException e) {
		} catch (IllegalAccessException e) {
		}
		return null;
	}
}
