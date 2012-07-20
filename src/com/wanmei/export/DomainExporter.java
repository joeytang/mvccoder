package com.wanmei.export;

import java.io.File;

import com.wanmei.domain.DaoHelper;
import com.wanmei.domain.Domain;
import com.wanmei.domain.Field;
import com.wanmei.domain.Project;
import com.wanmei.domain.ProjectHelper;
import com.wanmei.util.BeanHelper;
import com.wanmei.util.ClassUtil;
import com.wanmei.util.StringUtil;

public class DomainExporter extends AbstractExporter {

	private Domain domain;
	public DomainExporter( Domain domain){
		this.domain = domain;
	}
	@Override
	public void configTasks() {
//		for(Field field:domain.getFields()){
//			tasks.addExport(new FieldExporter(field));
//		}
//		for(Controller controller:domain.getControllers()){
//			tasks.addExport(new ControllerExporter(controller));
//		}
	}
	@Override
	public void doExecute() {
		String rootPath = "templates/domain/";
		rootFilePath = rootFilePath + "domain/";
		String DOMAIN_FTL = rootPath+"domain.ftl";
		String DOMAIN_HELPER_FTL = rootPath+"domainHelper.ftl";
		String DAO_FTL = rootPath+"dao.ftl";
		String DAO_FTLIMPL = rootPath+"daoImpl.ftl";
		String MANAGER_FTL = rootPath+"service.ftl";
		String MANAGERIMPL_FTL = rootPath+"serviceImpl.ftl";
//		String ACTIONBACK_FTL = rootPath+"actionback.ftl";
//		String ACTIONVIEW_FTL = rootPath+"actionview.ftl";
		String CONTROLLERBACK_FTL = rootPath+"controllerBack.ftl";
		String CONTROLLERVIEW_FTL = rootPath+"controllerView.ftl";
		String JSP_INPUT_BACK_FTL = rootPath+"jsp-input-back.ftl";
		String JSP_LIST_BACK_FTL = rootPath+"jsp-list-back.ftl";
		String JSP_MAIN_BACK_FTL = rootPath+"jsp-main-back.ftl";
		String JSP_VIEW_BACK_FTL = rootPath+"jsp-view-back.ftl";
		
		String JSP_MANY2MANY_MAIN_BACK_FTL = rootPath+"jsp-many2many-main-back.ftl";
		String JSP_MANY2MANY_LIST_BACK_FTL = rootPath+"jsp-many2many-list-back.ftl";
		
		String JSP_INPUT_VIEW_FTL = rootPath+"jsp-input-view.ftl";
		String JSP_LIST_VIEW_FTL = rootPath+"jsp-list-view.ftl";
		String TEST_MANAGER_FTL = rootPath+"testService.ftl";
		
		root.put("domain", domain);
		
		if(domain.getIsComposeId() != null && domain.getIsComposeId()){
			fu.analysisTemplate("templates", DOMAIN_FTL,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".domain") + File.separator +  domain.getName()+".java", root);
			return ;
		}
		if(getProject().getDao().getType() == DaoHelper.TYPE_IBATIS3){
			
		}else{
			String HBM_FTL = rootPath+"hbm.ftl";
			fu.analysisTemplate("templates", HBM_FTL,
					getProject().getConfPath() + File.separator
					+  ClassUtil.packageToPath("hbm") + File.separator +  domain.getLowerFirstName()+"-hbm.xml", root);
		}
		
		fu.analysisTemplate("templates", DOMAIN_FTL,
				getProject().getSrcPath() + File.separator
				+  ClassUtil.packageToPath(getProject().getOrg()+".domain") + File.separator +  domain.getName()+".java", root);
		if(domain.getDictFields() != null && domain.getDictFields().size() > 0 && !domain.getIsUser()){
			fu.analysisTemplate("templates", DOMAIN_HELPER_FTL,
					getProject().getSrcPath() + File.separator
					+  ClassUtil.packageToPath(getProject().getOrg()+".domain.helper") + File.separator +  domain.getName()+"Helper.java", root);
		}
		fu.analysisTemplate("templates", DAO_FTL,
				getProject().getSrcPath() + File.separator
				+  ClassUtil.packageToPath(getProject().getOrg()+".dao") + File.separator +  domain.getName()+"Dao.java", root);
		fu.analysisTemplate("templates", DAO_FTLIMPL,
				getProject().getSrcPath() + File.separator
				+  ClassUtil.packageToPath(getProject().getOrg()+".dao.impl") + File.separator +  domain.getName()+"DaoImpl.java", root);
		fu.analysisTemplate("templates", MANAGER_FTL,
				getProject().getSrcPath() + File.separator
				+  ClassUtil.packageToPath(getProject().getOrg()+".service") + File.separator +  domain.getName()+"Service.java", root);
		fu.analysisTemplate("templates", MANAGERIMPL_FTL,
				getProject().getSrcPath() + File.separator
				+  ClassUtil.packageToPath(getProject().getOrg()+".service.impl") + File.separator + domain.getName()+"ServiceImpl.java", root);
		
		if(!domain.getIsMany2ManyKey()){//多对多的联合主键类
			switch(getProject().getCodeType()){
			case ProjectHelper.CODE_TYPE_BACK:
//			后台action
//			fu.analysisTemplate("templates", ACTIONBACK_FTL,
//					getProject().getSrcPath() + File.separator
//					+  ClassUtil.packageToPath(getProject().getOrg()+".web.controller") + File.separator +  domain.getName()+"Action.java", root);
				fu.analysisTemplate("templates", CONTROLLERBACK_FTL,
						getProject().getSrcPath() + File.separator
						+  ClassUtil.packageToPath(getProject().getOrg()+".web.controller") + File.separator +  domain.getName()+"Controller.java", root);
				
//			后台jsp
				fu.analysisTemplate("templates", JSP_INPUT_BACK_FTL, 
						getProject().getWebPath()+ File.separator + "WEB-INF"
								+ File.separator
								+ "jsp"
								+ File.separator
								+ domain.getLowerFirstName()
								+ File.separator
								+ "input.jsp", root);
				fu.analysisTemplate("templates", JSP_LIST_BACK_FTL, getProject().getWebPath()
						+ File.separator
						+ "WEB-INF"
						+ File.separator
						+ "jsp"
						+ File.separator
						+ domain.getLowerFirstName()
						+ File.separator
						+ "list.jsp", root);
				fu.analysisTemplate("templates", JSP_MAIN_BACK_FTL, getProject().getWebPath()
						+ File.separator
						+ "WEB-INF"
						+ File.separator
						+ "jsp"
						+ File.separator
						+ domain.getLowerFirstName()
						+ File.separator
						+ "main.jsp", root);
				if(domain.getMany2ManyRelationFields() != null){
					for(Field fieldMany :domain.getMany2ManyRelationFields()){
						this.root.put("domain", domain);
						this.root.put("fieldMany", fieldMany);
						this.root.put("domainMany", domain);
						this.root.put("domainManyOther", this.getProject().getDomainMap().get(fieldMany.getEntityName()));
						fu.analysisTemplate("templates", JSP_MANY2MANY_MAIN_BACK_FTL, getProject().getWebPath()
								+ File.separator
								+ "WEB-INF"
								+ File.separator
								+ "jsp"
								+ File.separator
								+ domain.getLowerFirstName()
								+ File.separator
								+ "main"+StringUtil.upperFirstChar(fieldMany.getName())+".jsp", root);
						this.root.put("domain", this.getProject().getDomainMap().get(fieldMany.getEntityName()));
						fu.analysisTemplate("templates", JSP_LIST_BACK_FTL, getProject().getWebPath()
								+ File.separator
								+ "WEB-INF"
								+ File.separator
								+ "jsp"
								+ File.separator
								+ domain.getLowerFirstName()
								+ File.separator
								+ "list"+StringUtil.upperFirstChar(fieldMany.getName())+".jsp", root);
					}
					this.root.remove("fieldMany");
					this.root.remove("domainMany");
					this.root.remove("domainManyOther");
					this.root.put("domain", domain);
				}
				fu.analysisTemplate("templates", JSP_VIEW_BACK_FTL, getProject().getWebPath()
						+ File.separator
						+ "WEB-INF"
						+ File.separator
						+ "jsp"
						+ File.separator
						+ domain.getLowerFirstName()
						+ File.separator
						+ "view.jsp", root);
				break;
				
			case ProjectHelper.CODE_TYPE_VIEW:
//			前台action
//			fu.analysisTemplate("templates", ACTIONVIEW_FTL,
//					getProject().getSrcPath() + File.separator
//					+  ClassUtil.packageToPath(getProject().getOrg()+".web.controller") + File.separator +  domain.getName()+"Action.java", root);
				fu.analysisTemplate("templates", CONTROLLERVIEW_FTL,
						getProject().getSrcPath() + File.separator
						+  ClassUtil.packageToPath(getProject().getOrg()+".web.controller") + File.separator +  domain.getName()+"Controller.java", root);
//			前台jsp	
				fu.analysisTemplate("templates", JSP_INPUT_VIEW_FTL, 
						getProject().getWebPath()+ File.separator + "WEB-INF"
								+ File.separator
								+ "jsp"
								+ File.separator
								+ domain.getLowerFirstName()
								+ File.separator
								+ "input.jsp", root);
				fu.analysisTemplate("templates", JSP_LIST_VIEW_FTL, getProject().getWebPath()
						+ File.separator
						+ "WEB-INF"
						+ File.separator
						+ "jsp"
						+ File.separator
						+ domain.getLowerFirstName()
						+ File.separator
						+ "list.jsp", root);
				break;
			case ProjectHelper.CODE_TYPE_ALL:
//			后台action
				fu.analysisTemplate("templates", CONTROLLERBACK_FTL,
						getProject().getSrcPath() + File.separator
						+  ClassUtil.packageToPath(getProject().getOrg()+".web.controller.back") + File.separator +  domain.getName()+"Controller.java", root);
				
//			后台jsp
				fu.analysisTemplate("templates", JSP_INPUT_BACK_FTL, 
						getProject().getWebPath()+ File.separator + "WEB-INF"
								+ File.separator
								+ "jsp/back"
								+ File.separator
								+ domain.getLowerFirstName()
								+ File.separator
								+ "input.jsp", root);
				fu.analysisTemplate("templates", JSP_LIST_BACK_FTL, getProject().getWebPath()
						+ File.separator
						+ "WEB-INF"
						+ File.separator
						+ "jsp/back"
						+ File.separator
						+ domain.getLowerFirstName()
						+ File.separator
						+ "list.jsp", root);
//			前台action
				fu.analysisTemplate("templates", CONTROLLERVIEW_FTL,
						getProject().getSrcPath() + File.separator
						+  ClassUtil.packageToPath(getProject().getOrg()+".web.controller.view") + File.separator +  domain.getName()+"Controller.java", root);
//			前台jsp	
				fu.analysisTemplate("templates", JSP_INPUT_VIEW_FTL, 
						getProject().getWebPath()+ File.separator + "WEB-INF"
								+ File.separator
								+ "jsp/view"
								+ File.separator
								+ domain.getLowerFirstName()
								+ File.separator
								+ "input.jsp", root);
				fu.analysisTemplate("templates", JSP_LIST_VIEW_FTL, getProject().getWebPath()
						+ File.separator
						+ "WEB-INF"
						+ File.separator
						+ "jsp/view"
						+ File.separator
						+ domain.getLowerFirstName()
						+ File.separator
						+ "list.jsp", root);
				break;
			}
			
		}

		
		
//		junit test
		fu.analysisTemplate("templates", TEST_MANAGER_FTL, getProject().getSrcPath() + File.separator
				+  ClassUtil.packageToPath("test") + File.separator + domain.getLowerFirstName() + File.separator +  "Test" + domain.getName()+"Service.java", root);
	}

	@Override
	public Project getProject() {
		return domain.getProject();
	}
}
