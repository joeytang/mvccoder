package com.wanmei.export;

import java.util.HashMap;
import java.util.Map;

import com.wanmei.domain.Project;
import com.wanmei.util.ConfigUtil;
import com.wanmei.util.FileUtil;
import com.wanmei.util.FreeMarkertUtil;

import freemarker.ext.beans.BeansWrapper;


public abstract class AbstractExporter {
	protected ExporterTask tasks = new ExporterTask();
	protected FreeMarkertUtil fu = new FreeMarkertUtil(); //根据ftl生成代码的工具类
	protected Map<String, Object> root = new HashMap<String, Object>(); //组装ftl需要的对象
	protected String rootFilePath = ConfigUtil.defaultConfigPath()+"/file/";
	public void execute(){
		root.put("project", getProject());
		root.put("statics", BeansWrapper.getDefaultInstance().getStaticModels());  
		configTasks();
		doExecute();
		tasks.execute();
	}
	public abstract void configTasks();
	public abstract void doExecute();
	public abstract Project getProject();
	public void copySrcconfig(){
		FileUtil.antCopy(rootFilePath + "srcconfig/",getProject().getSrcPath());
	}
	public void copyWeb(){
		FileUtil.antCopy(rootFilePath + "web/",getProject().getWebPath());
	}
	public void copyPro(){
		FileUtil.antCopy(rootFilePath + "pro/",getProject().getRootPath());
	}
	public void copyRes(){
		FileUtil.antCopy(rootFilePath + "res/",getProject().getResPath());
	}
}
