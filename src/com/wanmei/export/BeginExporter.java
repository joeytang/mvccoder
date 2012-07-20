package com.wanmei.export;

import java.io.File;

import com.wanmei.domain.Project;
import com.wanmei.domain.ProjectHelper;
import com.wanmei.domain.SecurityHelper;
import com.wanmei.util.ClassUtil;
import com.wanmei.util.FileUtil;

public class BeginExporter extends AbstractExporter {

	private Project project;

	public BeginExporter(Project project) {
		this.project = project;
	}

	@Override
	public void configTasks() {
	}

	@Override
	public void doExecute() {
		String rootPath = "templates/project/";
		rootFilePath = rootFilePath + "project/";
		String JUNITBEANFACTORY = rootPath + "junit/JunitBeanFactory.ftl";
		String JUNITTEST = rootPath + "junit/JunitTest.ftl";
		String GENERALTLD_FTL = rootPath + "tld/general.ftl";

		String TOOL_COMMONLIST = rootPath + "tool/CommonList.ftl";
//		String TOOL_IMAGEORFILEUPLOADUTILS = rootPath
//				+ "tool/ImageOrFileUploadUtils.ftl";
		String TOOL_PAGES = rootPath + "tool/page/Pages.ftl";
		String TOOL_PAGESMODEL = rootPath + "tool/page/PagesModel.ftl";
		String TOOL_PAGESMODEL1 = rootPath + "tool/page/PagesModel1.ftl";
		String TOOL_PAGESMODEL2 = rootPath + "tool/page/PagesModel2.ftl";
		String TOOL_PAGESMODEL3 = rootPath + "tool/page/PagesModel3.ftl";
		String TOOL_PAGESMODEL4 = rootPath + "tool/page/PagesModel4.ftl";
		String TOOL_PAGESMODEL5 = rootPath + "tool/page/PagesModel5.ftl";
		String TOOL_PAGESMODEL6 = rootPath + "tool/page/PagesModel6.ftl";
		String TOOL_PAGESMODEL7 = rootPath + "tool/page/PagesModel7.ftl";
		String TOOL_PAGESMODEL8 = rootPath + "tool/page/PagesModel8.ftl";
		String TOOL_PAGESMODEL10 = rootPath + "tool/page/PagesModel10.ftl";
		String TOOL_PAGESMODEL11 = rootPath + "tool/page/PagesModel11.ftl";
		String TOOL_TAG_ACTIONMSG = rootPath + "tool/tag/ActionMessageTag.ftl";
		String TOOL_TAG_MAXLENGTHSTRING = rootPath + "tool/tag/MaxLengthString.ftl";
		String TOOL_EL_CUSTOMFUNCTIONS = rootPath + "tool/elfunc/CustomFunctions.ftl";

//		String TOOL_VALIDATEIMAGESERVICE = rootPath
//				+ "tool/ValidateImageService.ftl";
//		String TOOL_VALIDATEIMAGESERVICEIMP = rootPath
//				+ "tool/ValidateImageServiceImp.ftl";
		String TOOL_RANDIMGSERVLET = rootPath
				+ "tool/RandImgServlet.ftl";

		String UTIL_COOKIEUTILS = rootPath + "util/CookieUtils.ftl";
		String UTIL_BEANHELPER = rootPath + "util/BeanHelper.ftl";
		String UTIL_CONFIGUTIL = rootPath + "util/ConfigUtil.ftl";
		String UTIL_CONSTANTS = rootPath + "util/Constants.ftl";
		String UTIL_CONTENTUTILS = rootPath + "util/ContentUtils.ftl";
		String UTIL_DATETIMEUTIL = rootPath + "util/DateTimeUtil.ftl";
		String UTIL_FILEUTIL = rootPath + "util/FileUtil.ftl";
		String UTIL_IPUTILS = rootPath + "util/IpUtils.ftl";
		String UTIL_IPTONUMBER = rootPath + "util/IPToNumber.ftl";
		String UTIL_PROPERTIESUTIL = rootPath + "util/PropertiesUtil.ftl";
		String UTIL_RESOURCEUTIL = rootPath + "util/ResourceUtil.ftl";
		String UTIL_STRINGUTIL = rootPath + "util/StringUtil.ftl";
		String UTIL_RENDERUTILS = rootPath + "util/RenderUtils.ftl";
		String UTIL_VALIDATEUTILS = rootPath + "util/ValidateUtils.ftl";

		String WEB_APPLISTENER = rootPath + "web/AppListener.ftl";
		String WEB_DISABLEURLSESSIONFILTER = rootPath
				+ "web/DisableUrlSessionFilter.ftl";
		String WEB_PROXOOLKILLERSERVLET = rootPath
				+ "web/ProxoolKillerServlet.ftl";

		String LOG4JPROPERTIES = rootPath + "config/log4j-properties.ftl";

		String USERCONTEXT = rootPath + "support/UserContext.ftl";
		String SORTBEAN = rootPath + "support/SortBean.ftl";
		String MVCUPLOADSUPPORT = rootPath + "support/MvcUploadSupport.ftl";
		
//		String USER = rootPath+"domain/User.ftl";
		String USERHELPER = rootPath+"domain/UserHelper.ftl";
		
		String INDEXJSP = rootPath+"jsp/index.ftl";
		String LOGINJSP = rootPath+"jsp/login.ftl";

		if (project.getProType() == ProjectHelper.PRO_TYPE_MVN) {

		} else {

		}
		// copy file
		copySrcconfig();
		copyWeb();
		copyRes();
		// JunitTest
		fu.analysisTemplate(
				"templates",
				JUNITBEANFACTORY,
				project.getTestSrcPath() + File.separator
						+ ClassUtil.packageToPath("test") + File.separator
						+ FileUtil.getFileNameWithoutExt(JUNITBEANFACTORY)
						+ ".java", root);
		fu.analysisTemplate("templates", JUNITTEST, project.getTestSrcPath()
				+ File.separator + ClassUtil.packageToPath("test")
				+ File.separator + FileUtil.getFileNameWithoutExt(JUNITTEST)
				+ ".java", root);
		// 基本的标签
		fu.analysisTemplate(
				"templates",
				GENERALTLD_FTL,
				project.getWebPath() + File.separator + "WEB-INF"
						+ File.separator + "tld" + File.separator
						+ FileUtil.getFileNameWithoutExt(GENERALTLD_FTL)
						+ ".tld", root);
		// 普通标签对应的类
		fu.analysisTemplate(
				"templates",
				TOOL_COMMONLIST,
				project.getSrcPath()
						+ File.separator
						+ ClassUtil.packageToPath(project.getOrg()
								+ ".tool.paging") + File.separator
						+ FileUtil.getFileNameWithoutExt(TOOL_COMMONLIST)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				TOOL_PAGES,
				project.getSrcPath()
						+ File.separator
						+ ClassUtil.packageToPath(project.getOrg()
								+ ".tool.paging") + File.separator
						+ FileUtil.getFileNameWithoutExt(TOOL_PAGES) + ".java",
				root);
		fu.analysisTemplate(
				"templates",
				TOOL_PAGESMODEL,
				project.getSrcPath()
						+ File.separator
						+ ClassUtil.packageToPath(project.getOrg()
								+ ".tool.paging") + File.separator
						+ FileUtil.getFileNameWithoutExt(TOOL_PAGESMODEL)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				TOOL_PAGESMODEL1,
				project.getSrcPath()
						+ File.separator
						+ ClassUtil.packageToPath(project.getOrg()
								+ ".tool.paging") + File.separator
						+ FileUtil.getFileNameWithoutExt(TOOL_PAGESMODEL1)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				TOOL_PAGESMODEL2,
				project.getSrcPath()
						+ File.separator
						+ ClassUtil.packageToPath(project.getOrg()
								+ ".tool.paging") + File.separator
						+ FileUtil.getFileNameWithoutExt(TOOL_PAGESMODEL2)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				TOOL_PAGESMODEL3,
				project.getSrcPath()
						+ File.separator
						+ ClassUtil.packageToPath(project.getOrg()
								+ ".tool.paging") + File.separator
						+ FileUtil.getFileNameWithoutExt(TOOL_PAGESMODEL3)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				TOOL_PAGESMODEL4,
				project.getSrcPath()
						+ File.separator
						+ ClassUtil.packageToPath(project.getOrg()
								+ ".tool.paging") + File.separator
						+ FileUtil.getFileNameWithoutExt(TOOL_PAGESMODEL4)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				TOOL_PAGESMODEL5,
				project.getSrcPath()
						+ File.separator
						+ ClassUtil.packageToPath(project.getOrg()
								+ ".tool.paging") + File.separator
						+ FileUtil.getFileNameWithoutExt(TOOL_PAGESMODEL5)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				TOOL_PAGESMODEL6,
				project.getSrcPath()
						+ File.separator
						+ ClassUtil.packageToPath(project.getOrg()
								+ ".tool.paging") + File.separator
						+ FileUtil.getFileNameWithoutExt(TOOL_PAGESMODEL6)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				TOOL_PAGESMODEL7,
				project.getSrcPath()
						+ File.separator
						+ ClassUtil.packageToPath(project.getOrg()
								+ ".tool.paging") + File.separator
						+ FileUtil.getFileNameWithoutExt(TOOL_PAGESMODEL7)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				TOOL_PAGESMODEL8,
				project.getSrcPath()
				+ File.separator
				+ ClassUtil.packageToPath(project.getOrg()
						+ ".tool.paging") + File.separator
						+ FileUtil.getFileNameWithoutExt(TOOL_PAGESMODEL8)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				TOOL_PAGESMODEL10,
				project.getSrcPath()
				+ File.separator
				+ ClassUtil.packageToPath(project.getOrg()
						+ ".tool.paging") + File.separator
						+ FileUtil.getFileNameWithoutExt(TOOL_PAGESMODEL10)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				TOOL_PAGESMODEL11,
				project.getSrcPath()
						+ File.separator
						+ ClassUtil.packageToPath(project.getOrg()
								+ ".tool.paging") + File.separator
						+ FileUtil.getFileNameWithoutExt(TOOL_PAGESMODEL11)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				TOOL_TAG_ACTIONMSG,
				project.getSrcPath()
				+ File.separator
				+ ClassUtil.packageToPath(project.getOrg()
						+ ".tool.tag") + File.separator
						+ FileUtil.getFileNameWithoutExt(TOOL_TAG_ACTIONMSG)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				TOOL_TAG_MAXLENGTHSTRING,
				project.getSrcPath()
				+ File.separator
				+ ClassUtil.packageToPath(project.getOrg()
						+ ".tool.tag") + File.separator
						+ FileUtil.getFileNameWithoutExt(TOOL_TAG_MAXLENGTHSTRING)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				TOOL_EL_CUSTOMFUNCTIONS,
				project.getSrcPath()
						+ File.separator
						+ ClassUtil.packageToPath(project.getOrg()
								+ ".tool.elfunc") + File.separator
						+ FileUtil.getFileNameWithoutExt(TOOL_EL_CUSTOMFUNCTIONS)
						+ ".java", root);

		// 图片文件上传和验证码图片
//		fu.analysisTemplate(
//				"templates",
//				TOOL_IMAGEORFILEUPLOADUTILS,
//				project.getSrcPath()
//						+ File.separator
//						+ ClassUtil.packageToPath(project.getOrg()
//								+ ".tool.upload")
//						+ File.separator
//						+ FileUtil
//								.getFileNameWithoutExt(TOOL_IMAGEORFILEUPLOADUTILS)
//						+ ".java", root);
//		fu.analysisTemplate(
//				"templates",
//				TOOL_VALIDATEIMAGESERVICE,
//				project.getSrcPath()
//						+ File.separator
//						+ ClassUtil.packageToPath(project.getOrg()
//								+ ".tool.validateimg")
//						+ File.separator
//						+ FileUtil
//								.getFileNameWithoutExt(TOOL_VALIDATEIMAGESERVICE)
//						+ ".java", root);
//		fu.analysisTemplate(
//				"templates",
//				TOOL_VALIDATEIMAGESERVICEIMP,
//				project.getSrcPath()
//				+ File.separator
//				+ ClassUtil.packageToPath(project.getOrg()
//						+ ".tool.validateimg")
//						+ File.separator
//						+ FileUtil
//						.getFileNameWithoutExt(TOOL_VALIDATEIMAGESERVICEIMP)
//						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				TOOL_RANDIMGSERVLET,
				project.getSrcPath()
						+ File.separator
						+ ClassUtil.packageToPath(project.getOrg()
								+ ".tool.validateimg")
						+ File.separator
						+ FileUtil
								.getFileNameWithoutExt(TOOL_RANDIMGSERVLET)
						+ ".java", root);
		// utils
		fu.analysisTemplate(
				"templates",
				UTIL_BEANHELPER,
				project.getSrcPath() + File.separator
				+ ClassUtil.packageToPath(project.getOrg() + ".util")
				+ File.separator
				+ FileUtil.getFileNameWithoutExt(UTIL_BEANHELPER)
				+ ".java", root);
		fu.analysisTemplate(
				"templates",
				UTIL_COOKIEUTILS,
				project.getSrcPath() + File.separator
						+ ClassUtil.packageToPath(project.getOrg() + ".util")
						+ File.separator
						+ FileUtil.getFileNameWithoutExt(UTIL_COOKIEUTILS)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				UTIL_CONFIGUTIL,
				project.getSrcPath() + File.separator
						+ ClassUtil.packageToPath(project.getOrg() + ".util")
						+ File.separator
						+ FileUtil.getFileNameWithoutExt(UTIL_CONFIGUTIL)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				UTIL_CONSTANTS,
				project.getSrcPath() + File.separator
				+ ClassUtil.packageToPath(project.getOrg() + ".util")
				+ File.separator
				+ FileUtil.getFileNameWithoutExt(UTIL_CONSTANTS)
				+ ".java", root);
		fu.analysisTemplate(
				"templates",
				UTIL_CONTENTUTILS,
				project.getSrcPath() + File.separator
						+ ClassUtil.packageToPath(project.getOrg() + ".util")
						+ File.separator
						+ FileUtil.getFileNameWithoutExt(UTIL_CONTENTUTILS)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				UTIL_DATETIMEUTIL,
				project.getSrcPath() + File.separator
						+ ClassUtil.packageToPath(project.getOrg() + ".util")
						+ File.separator
						+ FileUtil.getFileNameWithoutExt(UTIL_DATETIMEUTIL)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				UTIL_FILEUTIL,
				project.getSrcPath() + File.separator
						+ ClassUtil.packageToPath(project.getOrg() + ".util")
						+ File.separator
						+ FileUtil.getFileNameWithoutExt(UTIL_FILEUTIL)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				UTIL_IPUTILS,
				project.getSrcPath() + File.separator
				+ ClassUtil.packageToPath(project.getOrg() + ".util")
				+ File.separator
				+ FileUtil.getFileNameWithoutExt(UTIL_IPUTILS)
				+ ".java", root);
		fu.analysisTemplate(
				"templates",
				UTIL_IPTONUMBER,
				project.getSrcPath() + File.separator
				+ ClassUtil.packageToPath(project.getOrg() + ".util")
				+ File.separator
				+ FileUtil.getFileNameWithoutExt(UTIL_IPTONUMBER)
				+ ".java", root);
		fu.analysisTemplate(
				"templates",
				UTIL_PROPERTIESUTIL,
				project.getSrcPath() + File.separator
						+ ClassUtil.packageToPath(project.getOrg() + ".util")
						+ File.separator
						+ FileUtil.getFileNameWithoutExt(UTIL_PROPERTIESUTIL)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				UTIL_RESOURCEUTIL,
				project.getSrcPath() + File.separator
						+ ClassUtil.packageToPath(project.getOrg() + ".util")
						+ File.separator
						+ FileUtil.getFileNameWithoutExt(UTIL_RESOURCEUTIL)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				UTIL_STRINGUTIL,
				project.getSrcPath() + File.separator
						+ ClassUtil.packageToPath(project.getOrg() + ".util")
						+ File.separator
						+ FileUtil.getFileNameWithoutExt(UTIL_STRINGUTIL)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				UTIL_RENDERUTILS,
				project.getSrcPath() + File.separator
				+ ClassUtil.packageToPath(project.getOrg() + ".util")
				+ File.separator
				+ FileUtil.getFileNameWithoutExt(UTIL_RENDERUTILS)
				+ ".java", root);
		fu.analysisTemplate(
				"templates",
				UTIL_VALIDATEUTILS,
				project.getSrcPath() + File.separator
						+ ClassUtil.packageToPath(project.getOrg() + ".util")
						+ File.separator
						+ FileUtil.getFileNameWithoutExt(UTIL_VALIDATEUTILS)
						+ ".java", root);
		// 系统需要的filter，listener
		fu.analysisTemplate(
				"templates",
				WEB_DISABLEURLSESSIONFILTER,
				project.getSrcPath()
				+ File.separator
				+ ClassUtil.packageToPath(project.getOrg()
						+ ".web.filter")
						+ File.separator
						+ FileUtil
						.getFileNameWithoutExt(WEB_DISABLEURLSESSIONFILTER)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				WEB_PROXOOLKILLERSERVLET,
				project.getSrcPath()
						+ File.separator
						+ ClassUtil.packageToPath(project.getOrg()
								+ ".web.servlet")
						+ File.separator
						+ FileUtil
								.getFileNameWithoutExt(WEB_PROXOOLKILLERSERVLET)
						+ ".java", root);
		fu.analysisTemplate(
				"templates",
				WEB_APPLISTENER,
				project.getSrcPath()
						+ File.separator
						+ ClassUtil.packageToPath(project.getOrg()
								+ ".web.listener") + File.separator
						+ FileUtil.getFileNameWithoutExt(WEB_APPLISTENER)
						+ ".java", root);

		fu.analysisTemplate("templates", LOG4JPROPERTIES, project.getConfPath()
				+ File.separator + "log4j.properties", root);
		// UserContext
		fu.analysisTemplate(
				"templates",
				USERCONTEXT,
				project.getSrcPath()
				+ File.separator
				+ ClassUtil.packageToPath(project.getOrg() + ".support")
				+ File.separator
				+ FileUtil.getFileNameWithoutExt(USERCONTEXT) + ".java",
				root);
//		sortbean
		fu.analysisTemplate(
				"templates",
				SORTBEAN,
				project.getSrcPath()
				+ File.separator
				+ ClassUtil.packageToPath(project.getOrg() + ".support")
				+ File.separator
				+ FileUtil.getFileNameWithoutExt(SORTBEAN) + ".java",
				root);
//		MVCUPLOADSUPPORT
		fu.analysisTemplate(
				"templates",
				MVCUPLOADSUPPORT,
				project.getSrcPath()
						+ File.separator
						+ ClassUtil.packageToPath(project.getOrg() + ".support")
						+ File.separator
						+ FileUtil.getFileNameWithoutExt(MVCUPLOADSUPPORT) + ".java",
				root);
//		用户 domain
//		fu.analysisTemplate("templates", USER,
//				getProject().getSrcPath() + File.separator
//				+  ClassUtil.packageToPath(getProject().getOrg()+".domain") + File.separator + FileUtil.getFileNameWithoutExt(USER) + ".java", root);
//		indexjsp
		fu.analysisTemplate("templates", INDEXJSP,
				getProject().getWebPath() + File.separator + 
				"index.jsp", root);
//		
		fu.analysisTemplate("templates", LOGINJSP,
				getProject().getWebPath() + File.separator + 
				"login.jsp", root);
		//		用户 helper
		fu.analysisTemplate("templates", USERHELPER,
				getProject().getSrcPath() + File.separator
				+  ClassUtil.packageToPath(getProject().getOrg()+".domain.helper") + File.separator + FileUtil.getFileNameWithoutExt(USERHELPER) + ".java", root);
		if(getProject().getSecurity().getType() == SecurityHelper.TYPE_COMPLEX){
			String BASEAUTHORIZEDOMAIN = rootPath+"domain/BaseAuthorizeDomain.ftl";
			String DOMAINOWNERDETAILS = rootPath+"domain/DomainOwnerDetails.ftl";
			String MENUTREEROOT = rootPath+"domain/MenuTreeRoot.ftl";
			String RESOURCEDETAILS = rootPath+"domain/ResourceDetails.ftl";
			String TREEJSON = rootPath+"domain/TreeJson.ftl";
			String MENUCACHE = rootPath+"cache/MenuCache.ftl";
			String RESOURCECACHE = rootPath+"cache/ResourceCache.ftl";
			String ROLE = rootPath+"domain/Role.ftl";
			String RESOURCE = rootPath+"domain/Resource.ftl";
			String MENU = rootPath+"domain/Menu.ftl";
			String RESOURCEHELPER = rootPath+"domain/ResourceHelper.ftl";
			
//		角色权限菜单相关类
			fu.analysisTemplate("templates", BASEAUTHORIZEDOMAIN,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".domain") + File.separator + FileUtil.getFileNameWithoutExt(BASEAUTHORIZEDOMAIN) + ".java", root);
			fu.analysisTemplate("templates", DOMAINOWNERDETAILS,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".domain") + File.separator + FileUtil.getFileNameWithoutExt(DOMAINOWNERDETAILS) + ".java", root);
			fu.analysisTemplate("templates", MENUTREEROOT,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".domain") + File.separator + FileUtil.getFileNameWithoutExt(MENUTREEROOT) + ".java", root);
			fu.analysisTemplate("templates", RESOURCEDETAILS,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".domain") + File.separator + FileUtil.getFileNameWithoutExt(RESOURCEDETAILS) + ".java", root);
			fu.analysisTemplate("templates", TREEJSON,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".domain") + File.separator + FileUtil.getFileNameWithoutExt(TREEJSON) + ".java", root);
//		角色权限菜单domain
			fu.analysisTemplate("templates", ROLE,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".domain") + File.separator + FileUtil.getFileNameWithoutExt(ROLE) + ".java", root);
			fu.analysisTemplate("templates", RESOURCE,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".domain") + File.separator + FileUtil.getFileNameWithoutExt(RESOURCE) + ".java", root);
			fu.analysisTemplate("templates", MENU,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".domain") + File.separator + FileUtil.getFileNameWithoutExt(MENU) + ".java", root);
//		角色权限菜单helper
			fu.analysisTemplate("templates", RESOURCEHELPER,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".domain.helper") + File.separator + FileUtil.getFileNameWithoutExt(RESOURCEHELPER) + ".java", root);

//		用户角色权限cache
			fu.analysisTemplate("templates", MENUCACHE,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".cache") + File.separator + FileUtil.getFileNameWithoutExt(MENUCACHE) + ".java", root);
			fu.analysisTemplate("templates", RESOURCECACHE,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".cache") + File.separator + FileUtil.getFileNameWithoutExt(RESOURCECACHE) + ".java", root);
		}
	}

	@Override
	public Project getProject() {
		return project;
	}

}
