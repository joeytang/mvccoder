package com.wanmei.export;

import java.io.File;

import com.wanmei.domain.Project;
import com.wanmei.domain.ProjectHelper;

public class EndExporter extends AbstractExporter {

	private Project project;

	public EndExporter(Project project) {
		this.project = project;
	}

	@Override
	public void configTasks() {
	}

	@Override
	public void doExecute() {
		String rootPath = "templates/project/";
		rootFilePath = rootFilePath + "project/";
		String PROJECT_FTL = rootPath + "/project.ftl";
		String CLASSES_FTL = rootPath + "/classpath.ftl";
		String JDT_FTL = rootPath + "/org.eclipse.jdt.core.prefs.ftl";
		String FACET_FTL = rootPath + "/org.eclipse.wst.common.project.facet.core.xml.ftl";
		String DYNAMIC_WEB_FTL = rootPath + "/org.eclipse.wst.common.component.ftl";
		String TOMCATPLUGIN_FTL = rootPath + "/tomcatplugin.ftl";

		copyPro();
		
		if (project.getProType() == ProjectHelper.PRO_TYPE_MVN) {

		} else {

		}
		// eclipse project file
		fu.analysisTemplate("templates", PROJECT_FTL, project.getRootPath()
				+ File.separator + ".project", root);
		File libFile = new File(project.getWebPath()+"WEB-INF/lib/");
		root.put("names", libFile.list());
		fu.analysisTemplate("templates", CLASSES_FTL, project.getRootPath()
				+ File.separator + ".classpath", root);
		fu.analysisTemplate("templates", JDT_FTL, project.getRootPath()
				+ File.separator +".settings"+File.separator + "org.eclipse.jdt.core.prefs", root);
		fu.analysisTemplate("templates", FACET_FTL, project.getRootPath()
				+ File.separator +".settings"+File.separator + "org.eclipse.wst.common.project.facet.core.xml", root);
		fu.analysisTemplate("templates", DYNAMIC_WEB_FTL, project.getRootPath()
				+ File.separator +".settings"+File.separator + "org.eclipse.wst.common.component", root);
		if (project.getNeedTomcatPlug()) {
			fu.analysisTemplate("templates", TOMCATPLUGIN_FTL,
					project.getRootPath() + File.separator + ".tomcatplugin",
					root);
		}

	}

	@Override
	public Project getProject() {
		return project;
	}

}
