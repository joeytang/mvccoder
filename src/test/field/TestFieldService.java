package test.field;

import com.wanmei.domain.Field;
import com.wanmei.service.FieldService;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import test.JunitBeanFactory;

public class TestFieldService {

	private static FieldService fieldService ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		fieldService = (FieldService)JunitBeanFactory.getBean("fieldService");
		System.out.println("----------begin TestFieldService--------");
	}
	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		System.out.println("----------end TestFieldService--------");
	}
	@Test
	public void testList() throws Exception {
		System.out.println(fieldService.list(null, null, 0, 10));
	}
//	@Test
	public void testSave() throws Exception {
		Field field = new Field();
		fieldService.save(field);
	}

}
