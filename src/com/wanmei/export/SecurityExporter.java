package com.wanmei.export;

import java.io.File;

import com.wanmei.domain.Project;
import com.wanmei.domain.Security;
import com.wanmei.domain.SecurityHelper;
import com.wanmei.util.ClassUtil;
import com.wanmei.util.FileUtil;

public class SecurityExporter extends AbstractExporter {

	private Security security;
	public SecurityExporter( Security security){
		this.security = security;
	}
	@Override
	public void configTasks() {
		
	}
	@Override
	public void doExecute() {
		String rootPath = "templates/security/";
		rootFilePath = rootFilePath + "security/";
		String SECURITY_FTL =  rootPath+"spring-security.ftl";
		String SECURITY_SERVICE_SECURITYUSERSERVICE = rootPath+"SecurityUserService.ftl";
		String SECURITY_SERVICE_MYAUTHENTICATIONPROCESSINGFILTERENTRYPOINT = rootPath+"MyAuthenticationProcessingFilterEntryPoint.ftl";
		if(security.getType() == SecurityHelper.TYPE_COMPLEX){
			String SECURITY_SPRING_ABSTRACTDATABASEMETHODDEFINITIONSOURCE = rootPath+"AbstractDatabaseMethodDefinitionSource.ftl";
			String SECURITY_SPRING_DATABASEMETHODDEFINITIONSOURCE = rootPath+"DatabaseMethodDefinitionSource.ftl";
			String SECURITY_SPRING_SECURERESOURCEFILTERINVOCATIONDEFINITIONSOURCE = rootPath+"SecureResourceFilterInvocationDefinitionSource.ftl";
			String SECURITY_SERVICE_SECURITYCACHEMANAGER = rootPath+"SecurityCacheManager.ftl";
			fu.analysisTemplate("templates", SECURITY_SPRING_DATABASEMETHODDEFINITIONSOURCE,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.security") + File.separator + FileUtil.getFileNameWithoutExt(SECURITY_SPRING_DATABASEMETHODDEFINITIONSOURCE) + ".java", root);
			fu.analysisTemplate("templates", SECURITY_SPRING_ABSTRACTDATABASEMETHODDEFINITIONSOURCE,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.security") + File.separator + FileUtil.getFileNameWithoutExt(SECURITY_SPRING_ABSTRACTDATABASEMETHODDEFINITIONSOURCE) + ".java", root);
			fu.analysisTemplate("templates", SECURITY_SPRING_SECURERESOURCEFILTERINVOCATIONDEFINITIONSOURCE,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.security") + File.separator + FileUtil.getFileNameWithoutExt(SECURITY_SPRING_SECURERESOURCEFILTERINVOCATIONDEFINITIONSOURCE) + ".java", root);
//			用户角色权限cache管理
			fu.analysisTemplate("templates", SECURITY_SERVICE_SECURITYCACHEMANAGER,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.security") + File.separator + FileUtil.getFileNameWithoutExt(SECURITY_SERVICE_SECURITYCACHEMANAGER) + ".java", root);
//			角色权限菜单cache
			fu.analysisTemplate("templates", SECURITY_SERVICE_SECURITYCACHEMANAGER,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.security") + File.separator + FileUtil.getFileNameWithoutExt(SECURITY_SERVICE_SECURITYCACHEMANAGER) + ".java", root);
		
		}
		
//		spring security 配置
		fu.analysisTemplate("templates", SECURITY_FTL,
				getProject().getConfPath() + File.separator
				+  ClassUtil.packageToPath("spring")+ File.separator + FileUtil.getFileNameWithoutExt(SECURITY_FTL) + ".xml", root);

//		springsecurity 装载用户类
		fu.analysisTemplate("templates", SECURITY_SERVICE_SECURITYUSERSERVICE,
				getProject().getSrcPath() + File.separator
				+  ClassUtil.packageToPath(getProject().getOrg()+".common.security") + File.separator + FileUtil.getFileNameWithoutExt(SECURITY_SERVICE_SECURITYUSERSERVICE) + ".java", root);
//		springsecurity 切入点
		fu.analysisTemplate("templates", SECURITY_SERVICE_MYAUTHENTICATIONPROCESSINGFILTERENTRYPOINT,
				getProject().getSrcPath() + File.separator
				+  ClassUtil.packageToPath(getProject().getOrg()+".common.security") + File.separator + FileUtil.getFileNameWithoutExt(SECURITY_SERVICE_MYAUTHENTICATIONPROCESSINGFILTERENTRYPOINT) + ".java", root);
		}

	@Override
	public Project getProject() {
		return security.getProject();
	}
}
