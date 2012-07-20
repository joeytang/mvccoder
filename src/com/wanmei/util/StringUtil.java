package com.wanmei.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.text.NumberFormat;

public class StringUtil {
	
	public static String trimPath(String str){
		if(str == null ){
			return null;
		}
		while(str.endsWith("\\")){
			str = str.substring(0,str.lastIndexOf("\\"));
		}
		while(str.endsWith("/")){
			str = str.substring(0,str.lastIndexOf("/"));
		}
		return str;
	} 
	/**
	 * 将字符串的第一个字母变成小写
	 * @param str
	 * @return
	 */
	public static String lowerFirstChar(String str){
		if(str == null ){
			return null;
		}
		str = str.trim();
		if(str.length() < 1){
			return null;
		}
		String first = str.substring(0,1);
		String rest = "";
		if(str.length() > 1){
			rest = str.substring(1);
		}
		return first.toLowerCase()+rest;
	}
	
	/**
	 * 将字符串的第一个字母变成大写
	 * @param str
	 * @return
	 */
	public static String upperFirstChar(String str){
		if(str == null ){
			return null;
		}
		str = str.trim();
		if(str.length() < 1){
			return null;
		}
		String first = str.substring(0,1);
		String rest = "";
		if(str.length() > 1){
			rest = str.substring(1);
		}
		return first.toUpperCase()+rest;
	}
	
	/**
	 * 计算字符串的长度，如：一个中文字符长度为2
	 * @param str 输入的字符串
	 * @return 返回字符串长度
	 */
	public static int getStringLength(String str){
		int leng = 0;
		try {
			 leng = (new   String(str.getBytes("gb2312"),"ISO-8859-1")).length();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return leng;
	}
	
	/**
	 * 用java的MD5进行对文本的加密
	 * @param s 要加密的明文
	 * @return 返回加密过后的密文
	 */
	public static String getCryptograph(String s) {
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'a', 'b', 'c', 'd', 'e', 'f' };
		try {
			byte[] strTemp = s.getBytes();
			MessageDigest mdTemp = MessageDigest.getInstance("MD5");
			mdTemp.update(strTemp);
			byte[] md = mdTemp.digest();
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				str[k++] = hexDigits[byte0 >>> 4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
			return new String(str);
		} catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * 对字符串进行过滤操作，如<script></script>的编码转化问题
	 * @param str 待过滤的字符串
	 * @return 过滤后的字符串
	 */
	public static String getFlterMode(String str){
		String tempStr = "";
		tempStr = str.replaceAll("<script", "&lt;script");
		tempStr = tempStr.replaceAll("</script", "&lt;/script");
		return tempStr;
	}
	
	public static String getPercent(double oneNum , double sum)
	{
		String resultStr = "";
		NumberFormat format = NumberFormat.getPercentInstance();
		format.setMinimumFractionDigits(2);
		double result = ((double)oneNum)/sum;
		resultStr = format.format(result);
		return resultStr;
	}
	
	/**
	 * 判断keyword是否为word的一个子串
	 * @param keyword 传入的子串
	 * @param word 一个完整字符串
	 * @return 是的话，返回true，否则返回false
	 */
	public static boolean isSomeOfWord(String keyword,String word){
		return word.matches(".*"+keyword+".*");
	}
	
	/**
	 * 将一个字符串转换成utf8格式的字符串
	 * @param s
	 * @return
	 */
	public static String toUtf8String(String s) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			if (c >= 0 && c <= 255) {
				sb.append(c);
			} else {
				byte[] b;
				try {
					b = Character.toString(c).getBytes("utf-8");
				} catch (Exception ex) {
					System.out.println(ex);
					b = new byte[0];
				}
				for (int j = 0; j < b.length; j++) {
					int k = b[j];
					if (k < 0)
						k += 256;
					sb.append("%" + Integer.toHexString(k).toUpperCase());
				}
			}
		}
		return sb.toString();
	}
	
	/**
	 * 截取一定长度的字符串，剩下的用...代替
	 * @param string 元字符串
	 * @param count 截取长度
	 * @return
	 */
	public static String toShortStr(String string,int count){
		String newString;
		if(string.length()<=count){
			return string;
		}
		else{
			newString=string.substring(0,count-4);
			newString=newString+"...";
			return newString;
		}		
	}
	
	public static boolean isBlank(String str){
		if(null == str){
			return true;
		}
		if(str.trim().length() == 0){
			return true;
		}
		return false;
	}
	
	public static boolean isNotBlank(String str){
		return !isBlank(str);
	}
	public static Boolean isTrue(String str){
		if(isBlank(str)){
			return null;
		}
		if(str.trim().equals("true")){
			return true;
		}
		return false;
	}
	public static String upcaseToUnderline(String str){
		if(isBlank(str)){
			return null;
		}
		str = lowerFirstChar(str);
		char[] chars = str.toCharArray();
		StringBuffer sBuf = new StringBuffer();
		for(char ch:chars){
			if(isUpperCaseChar(ch)){
				sBuf.append("_");
				sBuf.append((char) (ch + ('a' - 'A')));
			}else{
				sBuf.append(ch);
			}
			
		}
		return sBuf.toString();
	}
	public static String underlineToUpcase(String str){
		if(isBlank(str)){
			return null;
		}
		System.out.println(str);
		System.out.println(str.replaceAll("_([a-z])",   "$1"));
		str = str.replaceAll("(_)([a-z])", "$1".toUpperCase());
		
//		
//		char[] chars = str.toCharArray();
//		StringBuffer sBuf = new StringBuffer();
//		boolean is_ = false;
//		for(char ch:chars){
//			if(ch == '_'){
//				is_ = true;
//			}else if(is_ && isLowerCaseChar(ch)){
//				sBuf.append((char) (ch + ('A' - 'a')));
//				is_ = false;
//			}else if(is_ && isLowerCaseChar(ch)){
//				
//			}else{
//				sBuf.append(ch);
//			}
//		}
		return str;
	}
	
	public static boolean isUpperCaseChar(char ch){
		if(ch >= 'A' && ch <= 'Z'){
			return true;
		}
		return false;
	}
	public static boolean isLowerCaseChar(char ch){
		if(ch >= 'a' && ch <= 'z'){
			return true;
		}
		return false;
	}
	
	public static void main(String[] args) {
		System.out.println('A' - 'a');
		System.out.println('A'+0);
		System.out.println('Z'+0);
		System.out.println('a'+0);
		System.out.println('z'+0);
		System.out.println(upcaseToUnderline("A22_3bxdExddCinNN"));
		System.out.println(underlineToUpcase("A22_3bxd__xd_dCinNN"));
	}

}
