package com.wanmei.export;

import java.io.File;

import com.wanmei.domain.Dao;
import com.wanmei.domain.DaoHelper;
import com.wanmei.domain.Project;
import com.wanmei.domain.SecurityHelper;
import com.wanmei.util.ClassUtil;
import com.wanmei.util.FileUtil;

public class DaoExporter extends AbstractExporter {

	private Dao dao;
	public DaoExporter( Dao dao){
		this.dao = dao;
	}
	@Override
	public void configTasks() {
		
	}
	@Override
	public void doExecute() {
		String rootPath = "templates/dao/hbm3/";
		rootFilePath = rootFilePath + "dao/hbm3/";
		if(dao.getType() == DaoHelper.TYPE_IBATIS3){
			rootPath = "templates/dao/ibatis3/";
			rootFilePath = rootFilePath + "dao/ibatis3/";
		}else{
			if(getProject().getSecurity().getType() == SecurityHelper.TYPE_COMPLEX){
				String ROLE_HBM = rootPath+"config/role-hbm.ftl";
				String RESOURCE_HBM = rootPath+"config/resource-hbm.ftl";
				String MENU_HBM = rootPath+"config/menu-hbm.ftl";
//				用户角色权限相关hbm文件
				fu.analysisTemplate("templates", ROLE_HBM,
						getProject().getConfPath() + File.separator
						+  ClassUtil.packageToPath("hbm") + File.separator + FileUtil.getFileNameWithoutExt(ROLE_HBM) + ".xml", root);
				fu.analysisTemplate("templates", RESOURCE_HBM,
						getProject().getConfPath() + File.separator
						+  ClassUtil.packageToPath("hbm") + File.separator + FileUtil.getFileNameWithoutExt(RESOURCE_HBM) + ".xml", root);
				fu.analysisTemplate("templates", MENU_HBM,
						getProject().getConfPath() + File.separator
						+  ClassUtil.packageToPath("hbm") + File.separator + FileUtil.getFileNameWithoutExt(MENU_HBM) + ".xml", root);
			}
//			String USER_HBM = rootPath+"config/user-hbm.ftl";
			
			String DAO_CRITERIACOMMAND = rootPath+"criteria/CriteriaCommand.ftl";
			String DAO_COMPOSITEID = rootPath+"criteria/CompositeId.ftl";
			String DAO_ISNOTNULL = rootPath+"criteria/IsNotNull.ftl";
			String DAO_ISNULL = rootPath+"criteria/IsNull.ftl";
			String DAO_NOTQUERY = rootPath+"criteria/NotQuery.ftl";
			String DAO_HQLINBEAN = rootPath+"criteria/HqlInBean.ftl";
			
			
//			用户相关hbm文件
//			fu.analysisTemplate("templates", USER_HBM,
//					getProject().getConfPath() + File.separator
//					+  ClassUtil.packageToPath("hbm") + File.separator + FileUtil.getFileNameWithoutExt(USER_HBM) + ".xml", root);
//			hibernate对应dao查询需要变量的数据结构
			fu.analysisTemplate("templates", DAO_CRITERIACOMMAND,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.dao.criteria") + File.separator + FileUtil.getFileNameWithoutExt(DAO_CRITERIACOMMAND) + ".java", root);
			fu.analysisTemplate("templates", DAO_COMPOSITEID,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.dao.criteria") + File.separator + FileUtil.getFileNameWithoutExt(DAO_COMPOSITEID) + ".java", root);
			fu.analysisTemplate("templates", DAO_ISNOTNULL,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.dao.criteria") + File.separator + FileUtil.getFileNameWithoutExt(DAO_ISNOTNULL) + ".java", root);
			fu.analysisTemplate("templates", DAO_ISNULL,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.dao.criteria") + File.separator + FileUtil.getFileNameWithoutExt(DAO_ISNULL) + ".java", root);
			fu.analysisTemplate("templates", DAO_NOTQUERY,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.dao.criteria") + File.separator + FileUtil.getFileNameWithoutExt(DAO_NOTQUERY) + ".java", root);
			fu.analysisTemplate("templates", DAO_HQLINBEAN,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.dao.criteria") + File.separator + FileUtil.getFileNameWithoutExt(DAO_HQLINBEAN) + ".java", root);
		
		}
		
		
		String DAO_BASEDAO = rootPath+"dao/BaseDao.ftl";
		String DAO_USERDAO = rootPath+"dao/UserDao.ftl";
		String DAO_USERDAOIMPL = rootPath+"dao/impl/UserDaoImpl.ftl";
		
		String MANAGER_MANAGERBASE = rootPath+"service/BaseService.ftl";
		String MANAGER_MANAGERBASEIMPL = rootPath+"service/impl/BaseServiceImpl.ftl";
		String SECURITY_MANAGER_USERMANAGER = rootPath+"service/UserService.ftl";
		String SECURITY_MANAGER_USERMANAGERIMPL = rootPath+"service/impl/UserServiceImpl.ftl";
		
		String DATAACCESS_FTL = rootPath+"config/spring-dataAccess.ftl";
//		String CONFIG_FTL = "templates/dao/spring-configuration.ftl";
		String CONFIG_FTL = "templates/dao/spring-root.ftl";
		String QUARTZ_FTL = "templates/dao/spring-quartz.ftl";
		String SERVICE_FTL = "templates/dao/spring-service.ftl";
//		String SPRINGWEB_FTL = "templates/dao/spring-web.ftl";
		String SQLFILTER_FTL = "templates/dao/SqlFilter.ftl";
		String SQLSORT_FTL = "templates/dao/SqlSort.ftl";
		
		String DAO_BASEDAOIMPL = rootPath+"dao/impl/BaseDaoImpl.ftl";
		String SQLFILTERADAPTER_FTL = rootPath+"criteria/SqlFilterAdapter.ftl";
		String SQLSORTADAPTER_FTL = rootPath+"criteria/SqlSortAdapter.ftl";
		super.copySrcconfig();
		super.copyWeb();
		

//		spring中配置数据源
			fu.analysisTemplate("templates", DATAACCESS_FTL,
					getProject().getConfPath() + File.separator
					+  ClassUtil.packageToPath("spring")+ File.separator + FileUtil.getFileNameWithoutExt(DATAACCESS_FTL) + ".xml", root);
			fu.analysisTemplate("templates", CONFIG_FTL,
					getProject().getConfPath() + File.separator
					+  ClassUtil.packageToPath("spring")+ File.separator + FileUtil.getFileNameWithoutExt(CONFIG_FTL) + ".xml", root);
			fu.analysisTemplate("templates", QUARTZ_FTL,
					getProject().getConfPath() + File.separator
					+  ClassUtil.packageToPath("spring")+ File.separator + FileUtil.getFileNameWithoutExt(QUARTZ_FTL) + ".xml", root);
			fu.analysisTemplate("templates", SERVICE_FTL,
					getProject().getConfPath() + File.separator
					+  ClassUtil.packageToPath("spring") + File.separator  + FileUtil.getFileNameWithoutExt(SERVICE_FTL) + ".xml", root);
//			fu.analysisTemplate("templates", SPRINGWEB_FTL,
//					getProject().getWebPath() + File.separator
//					+ ClassUtil.packageToPath("WEB-INF.conf.spring")+ File.separator + FileUtil.getFileNameWithoutExt(SPRINGWEB_FTL) + ".xml", root);
			//			dao基类接口 
			fu.analysisTemplate("templates", DAO_BASEDAO,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.dao") + File.separator + FileUtil.getFileNameWithoutExt(DAO_BASEDAO) + ".java", root);
			fu.analysisTemplate("templates", DAO_BASEDAOIMPL,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.dao.impl") + File.separator + FileUtil.getFileNameWithoutExt(DAO_BASEDAOIMPL) + ".java", root);
//			dao查询过滤器
			fu.analysisTemplate("templates", SQLFILTER_FTL,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.dao") + File.separator + FileUtil.getFileNameWithoutExt(SQLFILTER_FTL) + ".java", root);
			fu.analysisTemplate("templates", SQLSORT_FTL,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.dao") + File.separator + FileUtil.getFileNameWithoutExt(SQLSORT_FTL) + ".java", root);
			//			用户相关dao实现
			fu.analysisTemplate("templates", DAO_USERDAO,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".dao") + File.separator + FileUtil.getFileNameWithoutExt(DAO_USERDAO) + ".java", root);
			fu.analysisTemplate("templates", DAO_USERDAOIMPL,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".dao.impl") + File.separator + FileUtil.getFileNameWithoutExt(DAO_USERDAOIMPL) + ".java", root);
			//			service基类接口 
			fu.analysisTemplate("templates", MANAGER_MANAGERBASE,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.service") + File.separator + FileUtil.getFileNameWithoutExt(MANAGER_MANAGERBASE) + ".java", root);
			fu.analysisTemplate("templates", MANAGER_MANAGERBASEIMPL,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.service.impl") + File.separator + FileUtil.getFileNameWithoutExt(MANAGER_MANAGERBASEIMPL) + ".java", root);
			//			用户相关service实现
			fu.analysisTemplate("templates", SECURITY_MANAGER_USERMANAGER,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".service") + File.separator + FileUtil.getFileNameWithoutExt(SECURITY_MANAGER_USERMANAGER) + ".java", root);
			fu.analysisTemplate("templates", SECURITY_MANAGER_USERMANAGERIMPL,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".service.impl") + File.separator + FileUtil.getFileNameWithoutExt(SECURITY_MANAGER_USERMANAGERIMPL) + ".java", root);
			//			sql查询过滤器的适配器
			fu.analysisTemplate("templates", SQLFILTERADAPTER_FTL,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.dao.criteria") + File.separator + FileUtil.getFileNameWithoutExt(SQLFILTERADAPTER_FTL) + ".java", root);
			fu.analysisTemplate("templates", SQLSORTADAPTER_FTL,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".common.dao.criteria") + File.separator + FileUtil.getFileNameWithoutExt(SQLSORTADAPTER_FTL) + ".java", root);

			if(getProject().getSecurity().getType() == SecurityHelper.TYPE_COMPLEX){
				String DAO_MENUDAO = rootPath+"dao/MenuDao.ftl";
				String DAO_RESOURCEDAO = rootPath+"dao/ResourceDao.ftl"; 
				String DAO_ROLEDAO = rootPath+"dao/RoleDao.ftl";
				String DAO_MENUDAOIMPL = rootPath+"dao/impl/MenuDaoImpl.ftl";
				String DAO_RESOURCEDAOIMPL = rootPath+"dao/impl/ResourceDaoImpl.ftl";
				String DAO_ROLEDAOIMPL = rootPath+"dao/impl/RoleDaoImpl.ftl";
				
				String SECURITY_MANAGER_MENUMANAGER = rootPath+"service/MenuService.ftl";
				String SECURITY_MANAGER_RESOURCEMANAGER = rootPath+"service/ResourceService.ftl";
				String SECURITY_MANAGER_ROLEMANAGER = rootPath+"service/RoleService.ftl";
				String SECURITY_MANAGER_MENUMANAGERIMPL = rootPath+"service/impl/MenuServiceImpl.ftl";
				String SECURITY_MANAGER_RESOURCEMANAGERIMPL = rootPath+"service/impl/ResourceServiceImpl.ftl";
				String SECURITY_MANAGER_ROLEMANAGERIMPL = rootPath+"service/impl/RoleServiceImpl.ftl";
//				角色权限菜单dao
				fu.analysisTemplate("templates", DAO_MENUDAO,
						getProject().getSrcPath() + File.separator
						+  ClassUtil.packageToPath(getProject().getOrg()+".dao") + File.separator + FileUtil.getFileNameWithoutExt(DAO_MENUDAO) + ".java", root);
				fu.analysisTemplate("templates", DAO_RESOURCEDAO,
						getProject().getSrcPath() + File.separator
						+  ClassUtil.packageToPath(getProject().getOrg()+".dao") + File.separator + FileUtil.getFileNameWithoutExt(DAO_RESOURCEDAO) + ".java", root);
				fu.analysisTemplate("templates", DAO_ROLEDAO,
						getProject().getSrcPath() + File.separator
						+  ClassUtil.packageToPath(getProject().getOrg()+".dao") + File.separator + FileUtil.getFileNameWithoutExt(DAO_ROLEDAO) + ".java", root);
				fu.analysisTemplate("templates", DAO_MENUDAOIMPL,
						getProject().getSrcPath() + File.separator
						+  ClassUtil.packageToPath(getProject().getOrg()+".dao.impl") + File.separator + FileUtil.getFileNameWithoutExt(DAO_MENUDAOIMPL) + ".java", root);
				fu.analysisTemplate("templates", DAO_RESOURCEDAOIMPL,
						getProject().getSrcPath() + File.separator
						+  ClassUtil.packageToPath(getProject().getOrg()+".dao.impl") + File.separator + FileUtil.getFileNameWithoutExt(DAO_RESOURCEDAOIMPL) + ".java", root);
				fu.analysisTemplate("templates", DAO_ROLEDAOIMPL,
						getProject().getSrcPath() + File.separator
						+  ClassUtil.packageToPath(getProject().getOrg()+".dao.impl") + File.separator + FileUtil.getFileNameWithoutExt(DAO_ROLEDAOIMPL) + ".java", root);
//				角色权限菜单service
				fu.analysisTemplate("templates", SECURITY_MANAGER_MENUMANAGER,
						getProject().getSrcPath() + File.separator
						+  ClassUtil.packageToPath(getProject().getOrg()+".service") + File.separator + FileUtil.getFileNameWithoutExt(SECURITY_MANAGER_MENUMANAGER) + ".java", root);
				fu.analysisTemplate("templates", SECURITY_MANAGER_RESOURCEMANAGER,
						getProject().getSrcPath() + File.separator
						+  ClassUtil.packageToPath(getProject().getOrg()+".service") + File.separator + FileUtil.getFileNameWithoutExt(SECURITY_MANAGER_RESOURCEMANAGER) + ".java", root);
				fu.analysisTemplate("templates", SECURITY_MANAGER_ROLEMANAGER,
						getProject().getSrcPath() + File.separator
						+  ClassUtil.packageToPath(getProject().getOrg()+".service") + File.separator + FileUtil.getFileNameWithoutExt(SECURITY_MANAGER_ROLEMANAGER) + ".java", root);
				fu.analysisTemplate("templates", SECURITY_MANAGER_MENUMANAGERIMPL,
						getProject().getSrcPath() + File.separator
						+  ClassUtil.packageToPath(getProject().getOrg()+".service.impl") + File.separator + FileUtil.getFileNameWithoutExt(SECURITY_MANAGER_MENUMANAGERIMPL) + ".java", root);
				fu.analysisTemplate("templates", SECURITY_MANAGER_RESOURCEMANAGERIMPL,
						getProject().getSrcPath() + File.separator
						+  ClassUtil.packageToPath(getProject().getOrg()+".service.impl") + File.separator + FileUtil.getFileNameWithoutExt(SECURITY_MANAGER_RESOURCEMANAGERIMPL) + ".java", root);
				fu.analysisTemplate("templates", SECURITY_MANAGER_ROLEMANAGERIMPL,
						getProject().getSrcPath() + File.separator
						+  ClassUtil.packageToPath(getProject().getOrg()+".service.impl") + File.separator + FileUtil.getFileNameWithoutExt(SECURITY_MANAGER_ROLEMANAGERIMPL) + ".java", root);
			}
			
	}

	@Override
	public Project getProject() {
		return dao.getProject();
	}
}
