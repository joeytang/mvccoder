package com.wanmei.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * User: joeytang
 * Date: 2012-03-20 18:17
 * 表单验证工具类
 */
public class ValidateUtils {

	/**
	 * 判断字符串长度
	 * 
	 * @param str
	 * @param mixLen
	 * @param maxLen
	 * @return
	 */
	public static boolean isStringLengthValidated(String str, int mixLen,
			int maxLen) {
		int len = str == null ? 0 : str.trim().length();
		if (len < mixLen || len > maxLen)
			return false;
		return true;
	}

	/**
	 * 验证是否合理的数字，整数位数小于intField,小数位数小于decField
	 * 
	 * @returns {Boolean}
	 */
	public static boolean isValidateDeci(Number num, int intField, int decField,
			long min, long max, boolean canNull) {
		if (intField < 1 || decField < 0) {
			return false;
		}
		if (num == null) {
			if (canNull) {
				return true;
			} else {
				return false;
			}
		}
		String numStr = num + "";
		Pattern p = Pattern.compile("^(\\d{1," + intField + "})(\\.)?(\\d{0,"
				+ decField + "})$");
		Matcher m = p.matcher(numStr);
		if (!m.matches()) {
			return false;
		}
		if (num.intValue() < min
				|| (numStr.indexOf(".") == -1 ? num.intValue() > max : num
						.intValue() + 1 > max)) {
			return false;
		}
		return true;
	}

	/**
	 * 验证email
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isEmail(String str) {
		Pattern p = Pattern
				.compile("^([a-zA-Z0-9]+[_|\\_|\\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\\_|\\.]?)*[a-zA-Z0-9]+\\.[a-zA-Z]{2,3}$", Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(str);
		return m.matches();
	}

	/**
	 * 验证Url
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isUrl(String str) {
		String strRegex = "(" // 开始
		// +"(" // “协议：//主机” 开始
				+ "(((https|http|ftp|rtsp|mms)://)" // 以http等协议+ip/域名开头
				+ "(([0-9]{1,3}\\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184
				+ "|" // 允许IP和DOMAIN（域名）
				+ "([0-9a-z_!~*'()-]+\\.)*" // 域名- www.
				+ "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\." // 二级域名
				+ "[a-z]{2,6}))" // first level domain- .com or .museum
				// + "|" // 或者
				// + "((www[0-9a-z_!~*'()-]*\\.)+" // 域名- www.
				// + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\." // 二级域名
				// + "[a-z]{2,6})" // first level domain- .com or .museum
				// + ")" // “协议：//主机” 结束
				+ "(:[0-9]+)?" // 端口- :80 ,至少一个数字
				+ "(/[0-9a-z_!~*'().;?:@&=+$,%#-]*)*" // 地址后面跟着路径如www.baicu.com/aaa/bbb/
														// 这里匹配/aaa /bbb
				+ "(\\?([a-zA-Z0-9\\._'\\s])+=[0-9a-z_!~*'().;:@+$,%#-]*" // 后面可以跟?开始的变量串有问号就必须至少有一个变量?a=
				+ "(((&)|(&amp;))([a-zA-Z0-9\\._'\\s])+=[0-9a-z_!~*'().;:@+$,%#-]*)*" // 后面的变量以&开头，并且可以0到多个
				+ ")?" // 地址后面的问号带的变量串结束。最多只能有一串?跟的变量
				+ "/?"// 可以/结束
				+ ")";// 结束
		Pattern p = Pattern.compile(strRegex, Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(str);
		return m.matches();
	}
}
