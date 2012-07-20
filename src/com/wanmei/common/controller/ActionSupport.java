package com.wanmei.common.controller;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.wanmei.tool.paging.CommonList;
 /**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * 模板action类
 *
 */
public abstract class ActionSupport<T extends Serializable> {
	/**
	 * 
	 */
	protected final Class<T> entityClass;
	protected String className;
	protected int pageNo = 1; // 当前页
	protected int size; // 总记录数
	protected int pageSize = 20;// 分页记录

	protected CommonList commonList;// 自定义分页对象
	
	protected transient Log logger ;
	@SuppressWarnings("unchecked")
	public ActionSupport() {
		this.entityClass = (Class<T>) ((ParameterizedType) getClass()
				.getGenericSuperclass()).getActualTypeArguments()[0];
		className = entityClass.getSimpleName();
		logger = LogFactory.getLog(entityClass);
	}
	
	/**
	 * 得到网站部署的根目录绝对路径
	 * 后面带有/
	 * @param request
	 * @return
	 */
	protected String getWebRoot(HttpServletRequest request){
		return request.getSession().getServletContext().getRealPath("/");
	}
}
