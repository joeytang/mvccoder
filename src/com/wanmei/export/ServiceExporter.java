package com.wanmei.export;

import com.wanmei.domain.Dao;
import com.wanmei.domain.Project;

public class ServiceExporter extends AbstractExporter {

	private Dao dao;
	public ServiceExporter( Dao dao){
		this.dao = dao;
	}
	@Override
	public void configTasks() {
		
	}
	@Override
	public void doExecute() {
		
		
		super.copySrcconfig();
		super.copyWeb();
	}

	@Override
	public Project getProject() {
		return dao.getProject();
	}
}
