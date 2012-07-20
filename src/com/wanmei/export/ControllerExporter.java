package com.wanmei.export;

import com.wanmei.domain.Controller;
import com.wanmei.domain.Project;


public class ControllerExporter extends AbstractExporter {

	private Controller controller;
	public ControllerExporter( Controller controller){
		this.controller = controller;
	}
	@Override
	public void configTasks() {
		
	}
	@Override
	public void doExecute() {
		
	}
	@Override
	public Project getProject() {
		return controller.getDomain().getProject();
	}
}
