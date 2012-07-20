package com.wanmei.util;

import java.io.IOException;
import java.util.Collection;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.PropertyFilter;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * 实现获取Request/Response/Session与绕过jsp/freemaker直接输出文本的简化函数.
 */
public class RenderUtils {
	/**
	 * Logger for this class
	 */
	private static final Log logger = LogFactory.getLog(RenderUtils.class);

	//header 常量定义
	private static final String ENCODING_PREFIX = "encoding";
	private static final String NOCACHE_PREFIX = "no-cache";
	private static final String ENCODING_DEFAULT = "UTF-8";
	private static final boolean NOCACHE_DEFAULT = true;
	
	
	public static final String STATUS_200 = "200";//ok
	public static final String STATUS_400 = "400";//错误请求
	public static final String STATUS_401 = "401";//请求未被授权
	public static final String STATUS_403 = "403";//请求被拒绝
	public static final String STATUS_404 = "404";//请求页面未找到
	public static final String STATUS_405 = "405";//请求method不被允许
	public static final String STATUS_500 = "500";//系统错误
	/**
	 * 自定义的status从600开始
	 */
	public static final String STATUS_600 = "600"; //参数传递不合法
	public static final String STATUS_601 = "601"; //未登录

	// 取得Request/Response/Session的简化函数 //

	// 绕过jsp/freemaker直接输出文本的函数 //

	/**
	 * 直接输出内容的简便函数.

	 * eg.
	 * render("text/plain", "hello", "encoding:GBK");
	 * render("text/plain", "hello", "no-cache:false");
	 * render("text/plain", "hello", "encoding:GBK", "no-cache:false");
	 *
	 * @param headers 可变的header数组，目前接受的值为"encoding:"或"no-cache:",默认值分别为UTF-8和true.
	 */
	public static void render(HttpServletResponse response,final String contentType, final String content, final String... headers) {
		try {
			//分析headers参数
			String encoding = ENCODING_DEFAULT;
			boolean noCache = NOCACHE_DEFAULT;
			for (String header : headers) {
				String headerName = StringUtils.substringBefore(header, ":");
				String headerValue = StringUtils.substringAfter(header, ":");

				if (StringUtils.equalsIgnoreCase(headerName, ENCODING_PREFIX)) {
					encoding = headerValue;
				} else if (StringUtils.equalsIgnoreCase(headerName, NOCACHE_PREFIX)) {
					noCache = Boolean.parseBoolean(headerValue);
				} else
					throw new IllegalArgumentException(headerName + "不是一个合法的header类型");
			}
			//设置headers参数
			String fullContentType = contentType + ";charset=" + encoding;
			response.setContentType(fullContentType);
			if (noCache) {
				response.setHeader("Pragma", "No-cache");
				response.setHeader("Cache-Control", "no-cache");
				response.setDateHeader("Expires", 0);
			}

			response.getWriter().write(content);
			response.getWriter().flush();

		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}

	/**
	 * 直接输出文本.
	 */
	public static void renderText(HttpServletResponse response,final String text, final String... headers) {
		render(response,"text/plain", text, headers);
	}

	/**
	 * 直接输出Error文本.
	 */
	public static void renderError(HttpServletResponse response,final String text, final String... headers) {
		render(response,"text/plain", "{'error':'" + text + "'}", headers);
	}

	/**
	 * 直接输出HTML.
	 */
	public static void renderHtml(HttpServletResponse response,final String html, final String... headers) {
		render(response,"text/html", html, headers);
	}

	/**
	 * 直接输出XML.
	 */
	public static void renderXml(HttpServletResponse response,final String xml, final String... headers) {
		render(response,"text/xml", xml, headers);
	}

	/**
	 * 直接输出JSON.
	 *
	 * @param string json字符串.
	 */
	public static void renderJson(HttpServletResponse response,final String string, final String... headers) {
		render(response,"application/json", string, headers);
	}

	/**
	 * 直接输出JSON.
	 *
	 * @param map Map对象,将被转化为json字符串.
	 */
	@SuppressWarnings("rawtypes")
	public static void renderJson(HttpServletResponse response,final Map map, final String... headers) {
		String jsonString = JSONObject.fromObject(map).toString();
		renderJson(response,jsonString, headers);
	}

	/**
	 * 直接输出JSON.
	 *
	 * @param object Java对象,将被转化为json字符串.
	 */
	public static void renderJson(HttpServletResponse response,final Object object, final String... headers) {
		String jsonString = null;
		if (object instanceof Collection) {
			jsonString = JSONArray.fromObject(object).toString();
		} else {
			jsonString = JSONObject.fromObject(object).toString();
		}
		renderJson(response,jsonString, headers);
	}
	/**
	 * 将json对象包含在textarea中以html形式写出去。用于jquery.form的文件上传时返回json数据
	 * @param object
	 * @param headers
	 */
	public static void renderJsonInTextarea(HttpServletResponse response,final Object object, final String... headers) {
		String jsonString = null;
		if (object instanceof Collection) {
			jsonString = JSONArray.fromObject(object).toString();
		} else {
			jsonString = JSONObject.fromObject(object).toString();
		}
		renderHtml(response,"<textarea>" + jsonString + "</textarea>", headers);
	}

	/**
	 * 成功的json
	 * @return
	 */
	public static JSONObject getStatusOk() {
		JSONObject object = new JSONObject();
		object.put(KEY_STATUS, STATUS_200);
		return object;
	}
	/**
	 * 错误：错误请求
	 * @return
	 */
	public static JSONObject getStatusBadRequest() {
		JSONObject object = new JSONObject();
		object.put(KEY_STATUS, STATUS_400);
		return object;
	}
	/**
	 * 错误：请求未被授权
	 * @return
	 */
	public static JSONObject getStatusUnAuthourize() {
		JSONObject object = new JSONObject();
		object.put(KEY_STATUS, STATUS_401);
		return object;
	}
	/**
	 * 错误：请求被拒绝
	 * @return
	 */
	public static JSONObject getStatusForbiden() {
		JSONObject object = new JSONObject();
		object.put(KEY_STATUS, STATUS_403);
		return object;
	}
	/**
	 * 错误：请求页面未找到
	 * @return
	 */
	public static JSONObject getStatusNotFound() {
		JSONObject object = new JSONObject();
		object.put(KEY_STATUS, STATUS_404);
		return object;
	}
	/**
	 * 错误：请求method不被允许
	 * @return
	 */
	public static JSONObject getStatusMethodError() {
		JSONObject object = new JSONObject();
		object.put(KEY_STATUS, STATUS_405);
		return object;
	}
	/**
	 * 错误：系统错误
	 * @return
	 */
	public static JSONObject getStatusSystem() {
		JSONObject object = new JSONObject();
		object.put(KEY_STATUS, STATUS_500);
		return object;
	}
	/**
	 * 错误：参数传递不合法
	 * @return
	 */
	public static JSONObject getStatusValidParam() {
		JSONObject object = new JSONObject();
		object.put(KEY_STATUS, STATUS_600);
		return object;
	}
	/**
	 * 错误：未登录
	 * @return
	 */
	public static JSONObject getStatusUnlogin() {
		JSONObject object = new JSONObject();
		object.put(KEY_STATUS, STATUS_601);
		return object;
	}
	
	public static JSONObject getJsonObject(Object key,Object value) {
		JSONObject object = new JSONObject();
		object.put(key, value);
		return object;
	}
	/**
	 * 判断是否执行成功
	 * @param json
	 * @return
	 */
	public static boolean isSuccess(JSONObject json){
		String stus = json.getString(KEY_STATUS);
		if(stus != null && stus.trim().equals( STATUS_200)){
			return true;
		}
		return false;
	}
	/**
	 * 获得结果
	 * @param json
	 * @return
	 */
	public static String getResult(JSONObject json){
		return json.getString(KEY_RESULT);
	}
	/**
	 * 获得错误信息
	 * @param json
	 * @return
	 */
	public static String getError(JSONObject json){
		return json.getString(KEY_ERROR);
	}
	public static final String KEY_STATUS = "status";
	public static final String KEY_ERROR = "error";
	public static final String KEY_RESULT = "result";
	
	/**
	 * 只对对象给定的属性生成json对象
	 * @return
	 */
	public static JSON getJsonIncludePro(Object object,final String[] includePros) {
		JsonConfig c = new JsonConfig();
		c.setJsonPropertyFilter(new PropertyFilter() {
			@Override
			public boolean apply(Object arg0, String arg1, Object arg2) {
				if(null == includePros || includePros.length == 0){
					return false;
				}
				for(String pro:includePros){
					if(pro.equals(arg1)){
						return false;
					}
				}
				return true;
			}
		});
		if (object instanceof Collection) {
			return JSONArray.fromObject(object,c);
		} else {
			return JSONObject.fromObject(object,c);
		}
	}
	/**
	 * 排除对象给定的属性生成json对象
	 * @return
	 */
	public static JSON getJsonExcludePro(Object object,final String[] excludePros) {
		JsonConfig c = new JsonConfig();
		c.setExcludes(excludePros);
		if (object instanceof Collection) {
			return JSONArray.fromObject(object,c);
		} else {
			return JSONObject.fromObject(object,c);
		}
	}
	/**
	 * 使用点路径获得json值
	 * 如{a:{b:"xxx"}}获得b的值传入key为a.b
	 * @param json
	 * @param key
	 * @return
	 */
	public static Object get(JSONObject json,String key){
		String[] keys = key.split("\\.");
		if(null != keys){
			for(int i = 0;i<keys.length;i++){
				if(i != keys.length - 1 ){
					Object o = json.get(keys[i]);
					if(null != o){
						json = (JSONObject) o;
					}else{
						return null;
					}
				}else{
					return json.get(keys[i]);
				}
			}
		}
		return null;
	}
	
}
