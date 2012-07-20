package com.wanmei.export;

import com.wanmei.domain.Project;

public class ProjectExporter extends AbstractExporter {

	private Project project;

	public ProjectExporter(Project project) {
		this.project = project;
	}

	@Override
	public void configTasks() {
		tasks.addExport(new BeginExporter(project));
		tasks.addExport(new DbExporter(project.getDb()));
		tasks.addExport(new ActionExporter(project.getAction()));
		tasks.addExport(new DaoExporter(project.getDao()));
		tasks.addExport(new SecurityExporter(project.getSecurity()));
		tasks.addExport(new DomainsExporter(project.getDomains()));
		tasks.addExport(new EndExporter(project));
	}

	@Override
	public void doExecute() {
		
	}

	@Override
	public Project getProject() {
		return project;
	}

}
