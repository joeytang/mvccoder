package test.controller;

import com.wanmei.domain.Controller;
import com.wanmei.service.ControllerService;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import test.JunitBeanFactory;

public class TestControllerService {

	private static ControllerService controllerService ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		controllerService = (ControllerService)JunitBeanFactory.getBean("controllerService");
		System.out.println("----------begin TestControllerService--------");
	}
	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		System.out.println("----------end TestControllerService--------");
	}
	@Test
	public void testList() throws Exception {
		System.out.println(controllerService.list(null, null, 0, 10));
	}
//	@Test
	public void testSave() throws Exception {
		Controller controller = new Controller();
		controllerService.save(controller);
	}

}
