package test.action;

import com.wanmei.domain.Action;
import com.wanmei.service.ActionService;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import test.JunitBeanFactory;

public class TestActionService {

	private static ActionService actionService ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		actionService = (ActionService)JunitBeanFactory.getBean("actionService");
		System.out.println("----------begin TestActionService--------");
	}
	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		System.out.println("----------end TestActionService--------");
	}
	@Test
	public void testList() throws Exception {
		System.out.println(actionService.list(null, null, 0, 10));
	}
//	@Test
	public void testSave() throws Exception {
		Action action = new Action();
		actionService.save(action);
	}

}
