package test.project;

import com.wanmei.domain.Project;
import com.wanmei.export.ExporterTask;
import com.wanmei.export.ProjectExporter;
import com.wanmei.service.ProjectService;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import test.JunitBeanFactory;

public class TestProjectService {

	private static ProjectService projectService ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		projectService = (ProjectService)JunitBeanFactory.getBean("projectService");
		System.out.println("----------begin TestProjectService--------");
	}
	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		System.out.println("----------end TestProjectService--------");
	}
	@Test
	public void testList() throws Exception {
//		System.out.println(projectService.list(null, null, 0, 10));
		Project project = projectService.wireProject(1);
		if(null != project){
			project.setOutput("E:/workspace/wmpg-web/other/mvccoder/web/output/");
		}
		ExporterTask task = new ExporterTask();
		task.addExport(new ProjectExporter(project));
		task.execute();
	}
//	@Test
	public void testSave() throws Exception {
		Project project = new Project();
		projectService.save(project);
	}

}
