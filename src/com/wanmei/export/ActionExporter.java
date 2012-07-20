package com.wanmei.export;

import java.io.File;

import com.wanmei.domain.Action;
import com.wanmei.domain.ActionHelper;
import com.wanmei.domain.Domain;
import com.wanmei.domain.Project;
import com.wanmei.domain.SecurityHelper;
import com.wanmei.util.ClassUtil;
import com.wanmei.util.FileUtil;

public class ActionExporter extends AbstractExporter {

	private Action action;
	public ActionExporter( Action action){
		this.action = action;
	}
	@Override
	public void configTasks() {
		
	}
	@Override
	public void doExecute() {
		
		String rootPath = "templates/action/springmvc/";
		rootFilePath = rootFilePath + "action/springmvc/";
		if(action.getType() == ActionHelper.TYPE_STRUTS2){
			rootPath = "templates/action/struts2/";
			rootFilePath = rootFilePath + "action/struts2/";
			String TOOL_STRUTSPAGES = rootPath + "/tld/Pages.ftl";
			String TOOL_STRUTSPAGETAG = rootPath + "/tld/PageTag.ftl";
			String TOOL_SUBSTRING = rootPath + "/tld/SubString.ftl";
			String TOOL_SUBSTRINGTAG = rootPath + "/tld/SubStringTag.ftl";
			String CUSTOMSTRUTSTLD_FTL = rootPath + "/tld/custom-struts2.ftl";
			
			String UTIL_DATECONVERTER = rootPath + "/util/DateConverter.ftl";
			
			String XWORKCONVERSION = rootPath + "config/xwork-conversion.ftl";
			String STRUTS = rootPath + "config/struts.ftl";
			String STRUTS2BACK = rootPath + "config/struts2-back.ftl";
			String STRUTS2SECURITY = rootPath + "config/struts2-security.ftl";
			String STRUTS2VIEW = rootPath + "config/struts2-view.ftl";
			
			String WEB_ILLEGALFILTER = rootPath + "web/IllegalFilter.ftl";
			
//			struts标签
			fu.analysisTemplate("templates", TOOL_STRUTSPAGES,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".tool.tags.component") + File.separator + FileUtil.getFileNameWithoutExt(TOOL_STRUTSPAGES) + ".java", root);
			fu.analysisTemplate("templates", TOOL_STRUTSPAGETAG,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".tool.tags") + File.separator + FileUtil.getFileNameWithoutExt(TOOL_STRUTSPAGETAG) + ".java", root);
			
			fu.analysisTemplate("templates", TOOL_SUBSTRING,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".tool.tags.component") + File.separator + FileUtil.getFileNameWithoutExt(TOOL_SUBSTRING) + ".java", root);
			fu.analysisTemplate("templates", TOOL_SUBSTRINGTAG,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".tool.tags") + File.separator + FileUtil.getFileNameWithoutExt(TOOL_SUBSTRINGTAG) + ".java", root);
//			struts 生成日期转换
			fu.analysisTemplate("templates", UTIL_DATECONVERTER,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.controller") + File.separator + FileUtil.getFileNameWithoutExt(UTIL_DATECONVERTER) + ".java", root);
//			struts相关标签
			fu.analysisTemplate("templates", CUSTOMSTRUTSTLD_FTL, getProject().getWebPath()
					+ File.separator
					+ "WEB-INF"
					+ File.separator
					+ "tld"
					+ File.separator
					+ FileUtil.getFileNameWithoutExt(CUSTOMSTRUTSTLD_FTL)
					+ ".tld", root);
//			struts action配置文件
			fu.analysisTemplate("templates", XWORKCONVERSION,
					getProject().getSrcPath() + File.separator + FileUtil.getFileNameWithoutExt(XWORKCONVERSION) + ".properties", root);
			fu.analysisTemplate("templates", STRUTS,
					getProject().getSrcPath() + File.separator + FileUtil.getFileNameWithoutExt(STRUTS) + ".xml", root);
			
			fu.analysisTemplate("templates", STRUTS2BACK,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath("conf.struts") + File.separator + FileUtil.getFileNameWithoutExt(STRUTS2BACK) + ".xml", root);
			fu.analysisTemplate("templates", STRUTS2VIEW,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath("conf.struts") + File.separator + FileUtil.getFileNameWithoutExt(STRUTS2VIEW) + ".xml", root);
			fu.analysisTemplate("templates", STRUTS2SECURITY,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath("conf.struts") + File.separator + FileUtil.getFileNameWithoutExt(STRUTS2SECURITY) + ".xml", root);
//			struts请求参数合法性检验
			fu.analysisTemplate(
					"templates",
					WEB_ILLEGALFILTER,
					getProject().getSrcPath()
							+ File.separator
							+ ClassUtil.packageToPath(getProject().getOrg()
									+ ".web.filter") + File.separator
							+ FileUtil.getFileNameWithoutExt(WEB_ILLEGALFILTER)
							+ ".java", root);
			
		}else{
			String SPRINGMVC = rootPath + "config/spring-mvc.ftl";
			String WEB_MYDATECONVERTER = rootPath + "action/MyDateConverter.ftl";
			String WEB_MVCCONTROLLERTEMPLATE = rootPath + "action/MvcControllerTemplate.ftl";
			String WEB_MVCCONTROLLERSUPPORT = rootPath + "action/MvcControllerSupport.ftl";
			fu.analysisTemplate("templates", SPRINGMVC,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath("config.spring") + File.separator + FileUtil.getFileNameWithoutExt(SPRINGMVC) + ".xml", root);
			fu.analysisTemplate("templates", WEB_MYDATECONVERTER,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.controller") + File.separator + FileUtil.getFileNameWithoutExt(WEB_MYDATECONVERTER) + ".java", root);
			fu.analysisTemplate("templates", WEB_MVCCONTROLLERTEMPLATE,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.controller") + File.separator + FileUtil.getFileNameWithoutExt(WEB_MVCCONTROLLERTEMPLATE) + ".java", root);
			fu.analysisTemplate("templates", WEB_MVCCONTROLLERSUPPORT,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.controller") + File.separator + FileUtil.getFileNameWithoutExt(WEB_MVCCONTROLLERSUPPORT) + ".java", root);
			String JSP_USER_MAIN = rootPath + "jsp/jsp-main-back-user.ftl";
			Domain uDomain = new Domain();
			root.put("domain", uDomain);
		}
		copySrcconfig();
		copyWeb();
		
		
		String LOGININTERCEPTOR = rootPath + "intercept/LoginInterceptor.ftl";
		
		String WEB_ACTIONSUPPORT = rootPath + "action/ActionSupport.ftl";
//		String WEB_ACTIONTEMPLATE = rootPath + "action/ActionTemplate.ftl";
		
//		String WEB_USERACTION = rootPath + "action/UserAction.ftl";
		String WEB_DICTACTION = rootPath + "action/DictController.ftl";
		String WEB_EXCEPTIONHANDLER = rootPath + "action/ExceptionHandler.ftl";
//		String JSP_MAIN_USER = rootPath+"action/jsp-main-user.ftl";
//		String JSP_LIST_USER = rootPath+"action/jsp-list-user.ftl";
//		String JSP_INPUT_USER = rootPath+"action/jsp-input-user.ftl";
		
		String WEB_FTL = rootPath + "web/web.ftl";
		
//		登陆拦截
		fu.analysisTemplate("templates", LOGININTERCEPTOR,
				getProject().getSrcPath() + File.separator
				+  ClassUtil.packageToPath(getProject().getOrg()+".web.interceptor") + File.separator + FileUtil.getFileNameWithoutExt(LOGININTERCEPTOR) + ".java", root);
		
		//action基类
		fu.analysisTemplate("templates", WEB_ACTIONSUPPORT,
				getProject().getSrcPath() + File.separator
				+  ClassUtil.packageToPath(getProject().getOrg()+".common.controller") + File.separator + FileUtil.getFileNameWithoutExt(WEB_ACTIONSUPPORT) + ".java", root);
//		fu.analysisTemplate("templates", WEB_ACTIONTEMPLATE,
//				getProject().getSrcPath() + File.separator
//				+  ClassUtil.packageToPath(getProject().getOrg()+".common.controller") + File.separator + FileUtil.getFileNameWithoutExt(WEB_ACTIONTEMPLATE) + ".java", root);
//		用户 action
//		fu.analysisTemplate("templates", WEB_USERACTION,
//				getProject().getSrcPath() + File.separator
//				+  ClassUtil.packageToPath(getProject().getOrg()+".web.controller") + File.separator + FileUtil.getFileNameWithoutExt(WEB_USERACTION) + ".java", root);
//		字典 action
		fu.analysisTemplate("templates", WEB_DICTACTION,
				getProject().getSrcPath() + File.separator
				+  ClassUtil.packageToPath(getProject().getOrg()+".web.controller") + File.separator + FileUtil.getFileNameWithoutExt(WEB_DICTACTION) + ".java", root);
//		spring mvc异常处理
		fu.analysisTemplate("templates", WEB_EXCEPTIONHANDLER,
				getProject().getSrcPath() + File.separator
				+  ClassUtil.packageToPath(getProject().getOrg()+".web.controller") + File.separator + FileUtil.getFileNameWithoutExt(WEB_EXCEPTIONHANDLER) + ".java", root);
//		用户jsp
//		fu.analysisTemplate("templates", JSP_MAIN_USER, getProject().getWebPath()
//				+ File.separator
//				+ "WEB-INF"
//				+ File.separator
//				+ "jsp"
//				+ File.separator
//				+ "user"
//				+ File.separator
//				+ "main.jsp", root);
//		fu.analysisTemplate("templates", JSP_LIST_USER, getProject().getWebPath()
//				+ File.separator
//				+ "WEB-INF"
//				+ File.separator
//				+ "jsp"
//				+ File.separator
//				+ "user"
//				+ File.separator
//				+ "list.jsp", root);
//		fu.analysisTemplate("templates", JSP_INPUT_USER, getProject().getWebPath()
//				+ File.separator
//				+ "WEB-INF"
//				+ File.separator
//				+ "jsp"
//				+ File.separator
//				+ "user"
//				+ File.separator
//				+ "input.jsp", root);
		
//		spring mvc对应web.xml
		fu.analysisTemplate("templates", WEB_FTL,
				getProject().getWebPath() + File.separator
				+ ClassUtil.packageToPath("WEB-INF")+ File.separator + FileUtil.getFileNameWithoutExt(WEB_FTL) + ".xml", root);
		if(getProject().getSecurity().getType() == SecurityHelper.TYPE_COMPLEX){
			String WEB_MENUACTION = rootPath + "action/MenuController.ftl";
			String WEB_RESOURCEACTION = rootPath + "action/ResourceController.ftl";
			String WEB_ROLEACTION = rootPath + "action/RoleController.ftl";
//			角色权限菜单action
			fu.analysisTemplate("templates", WEB_MENUACTION,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".web.controller") + File.separator + FileUtil.getFileNameWithoutExt(WEB_MENUACTION) + ".java", root);
			fu.analysisTemplate("templates", WEB_RESOURCEACTION,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".web.controller") + File.separator + FileUtil.getFileNameWithoutExt(WEB_RESOURCEACTION) + ".java", root);
			fu.analysisTemplate("templates", WEB_ROLEACTION,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".web.controller") + File.separator + FileUtil.getFileNameWithoutExt(WEB_ROLEACTION) + ".java", root);
		}
	}
	@Override
	public Project getProject() {
		return action.getProject();
	}
	
}
