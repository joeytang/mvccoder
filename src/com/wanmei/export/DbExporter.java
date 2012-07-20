package com.wanmei.export;

import java.io.File;

import com.wanmei.domain.Db;
import com.wanmei.domain.Project;
import com.wanmei.util.ClassUtil;
import com.wanmei.util.FileUtil;

public class DbExporter extends AbstractExporter {

	private Db db;
	public DbExporter( Db db){
		this.db = db;
	}
	@Override
	public void configTasks() {
		
	}
	@Override
	public void doExecute() {
		
		String rootPath = "templates/db/";
		rootFilePath = rootFilePath + "db/";
		root.put("db", db);
		String JDBC = rootPath + "jdbc.ftl";
		String CREATE = rootPath + "create.ftl";
		String INIT = rootPath + "init.ftl";
		String PDWORKSPACE = rootPath + "sws.ftl";
		String PDPDB = rootPath + "pdb.ftl";
		String PDPDM = rootPath + "pdm.ftl";
		fu.analysisTemplate("templates", JDBC, getProject().getConfPath()
				+ File.separator + FileUtil.getFileNameWithoutExt(JDBC)
				+ ".properties", root);
		fu.analysisTemplate("templates", CREATE, getProject().getRootPath() + "sql"
				+ File.separator + FileUtil.getFileNameWithoutExt(INIT)
				+ ".sql", root);
		fu.analysisTemplate("templates", PDWORKSPACE, getProject().getRootPath() + ClassUtil.packageToPath("sql.pd")
				+ File.separator
				+ "Workspace.sws", root);
		fu.analysisTemplate("templates", PDPDB, getProject().getRootPath() + ClassUtil.packageToPath("sql.pd")
				+ File.separator
				+ getProject().getName() + ".pdb", root);
		fu.analysisTemplate("templates", PDPDM, getProject().getRootPath() + ClassUtil.packageToPath("sql.pd")
				+ File.separator
				+ getProject().getName() + ".pdm", root);
	}
	@Override
	public Project getProject() {
		return db.getProject();
	}
	
}
