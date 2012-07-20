package com.wanmei.util;


import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;

/**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * 国际化处理工具类
 */

public class ResourceUtil {
	private static Locale locale = null;
	private static ResourceBundle bundle = null;

	public static String getResString(HttpServletRequest request,String key) {
		Locale cLocale = request.getLocale();
		if(locale == null || bundle == null || !locale.getDisplayName().equals(cLocale.getDisplayName())) {
			locale = cLocale;
			bundle = ResourceBundle.getBundle("res.globalMessages", locale);
		}
		return bundle.getString(key);
	}
}
