package com.wanmei.export;

import java.util.ArrayList;
import java.util.List;

public class ExporterTask {

	private List<AbstractExporter> exports = new ArrayList<AbstractExporter>();
	
	public void addExport(AbstractExporter export){
		exports.add(export);
	}
	public void execute(){
		for(AbstractExporter export:exports){
			export.execute();
		}
	}
}
