package com.wanmei.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wanmei.domain.ActionHelper;
import com.wanmei.domain.ButtonHelper;
import com.wanmei.domain.ControllerHelper;
import com.wanmei.domain.DaoHelper;
import com.wanmei.domain.DbHelper;
import com.wanmei.domain.DomainHelper;
import com.wanmei.domain.FieldHelper;
import com.wanmei.domain.ProjectHelper;
import com.wanmei.domain.SecurityHelper;
import com.wanmei.domain.helper.UserHelper;
import com.wanmei.util.RenderUtils;
/**
 * @author joeytang
 * Date: 2011-11-21 10:42
 * Url映射action
 */
@Controller 
@RequestMapping("/dict")
public class DictController {

	/**
	 * 用户角色
	 * 
	 * @return
	 */
	@RequestMapping(value = "/userRole")
	public void userRole(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap)
			throws Exception{
		RenderUtils.renderJson(response, UserHelper.roleMap.entrySet());
	}
	/**
	 * 数据库配置类型
	 * 
	 * @return
	 */
	@RequestMapping(value = "/dbType")
	public void dbType(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap)
			throws Exception{
		RenderUtils.renderJson(response, DbHelper.typeMap.entrySet());
	}
	/**
	 * Action全局配置类型
	 * 
	 * @return
	 */
	@RequestMapping(value = "/actionType")
	public void actionType(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap)
			throws Exception{
		RenderUtils.renderJson(response, ActionHelper.typeMap.entrySet());
	}
	/**
	 * Dao全局配置类型
	 * 
	 * @return
	 */
	@RequestMapping(value = "/daoType")
	public void daoType(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap)
			throws Exception{
		RenderUtils.renderJson(response, DaoHelper.typeMap.entrySet());
	}
	/**
	 * SpringSecurity全局配置类型
	 * 
	 * @return
	 */
	@RequestMapping(value = "/securityType")
	public void securityType(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap)
			throws Exception{
		RenderUtils.renderJson(response, SecurityHelper.typeMap.entrySet());
	}
	/**
	 * 按钮类型
	 * 
	 * @return
	 */
	@RequestMapping(value = "/buttonType")
	public void buttonType(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap)
			throws Exception{
		RenderUtils.renderJson(response, ButtonHelper.typeMap.entrySet());
	}
	/**
	 * 项目项目类型
	 * 
	 * @return
	 */
	@RequestMapping(value = "/projectProType")
	public void projectProType(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap)
			throws Exception{
		RenderUtils.renderJson(response, ProjectHelper.proTypeMap.entrySet());
	}
	/**
	 * 项目代码类型
	 * 
	 * @return
	 */
	@RequestMapping(value = "/projectCodeType")
	public void projectCodeType(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap)
			throws Exception{
		RenderUtils.renderJson(response, ProjectHelper.codeTypeMap.entrySet());
	}
	/**
	 * 字段字段类型
	 * 
	 * @return
	 */
	@RequestMapping(value = "/fieldType")
	public void fieldType(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap)
			throws Exception{
		RenderUtils.renderJson(response, FieldHelper.typeMap.entrySet());
	}
	/**
	 * 字段字段类型
	 * 
	 * @return
	 */
	@RequestMapping(value = "/categoryType")
	public void categoryType(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap)
			throws Exception{
		RenderUtils.renderJson(response, FieldHelper.categoryMap.entrySet());
	}
	/**
	 * 字段字段类型
	 * 
	 * @return
	 */
	@RequestMapping(value = "/many2OneType")
	public void many2OneType(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap)
			throws Exception{
		RenderUtils.renderJson(response, FieldHelper.many2OneTypeMap.entrySet());
	}
	/**
	 * 字段字段类型
	 * 
	 * @return
	 */
	@RequestMapping(value = "/relationType")
	public void relationType(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap)
			throws Exception{
		RenderUtils.renderJson(response, FieldHelper.relationTypeMap.entrySet());
	}
	/**
	 * 自定义的Controller类型
	 * 
	 * @return
	 */
	@RequestMapping(value = "/controllerType")
	public void controllerType(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap)
			throws Exception{
		RenderUtils.renderJson(response, ControllerHelper.typeMap.entrySet());
	}
	/**
	 * 自定义的Domain checktype类型
	 * 
	 * @return
	 */
	@RequestMapping(value = "/domainCheckType")
	public void domainCheckType(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap)
			throws Exception{
		RenderUtils.renderJson(response, DomainHelper.checkTypeMap.entrySet());
	}
	
	
}
