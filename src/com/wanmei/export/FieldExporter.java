package com.wanmei.export;

import com.wanmei.domain.Field;
import com.wanmei.domain.Project;


public class FieldExporter extends AbstractExporter {

	private Field field;
	public FieldExporter( Field field){
		this.field = field;
	}
	@Override
	public void configTasks() {
		
	}
	@Override
	public void doExecute() {
		
	}

	@Override
	public Project getProject() {
		return field.getDomain().getProject();
	}
}
