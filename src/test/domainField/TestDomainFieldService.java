package test.domainField;

import com.wanmei.domain.DomainField;
import com.wanmei.service.DomainFieldService;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import test.JunitBeanFactory;

public class TestDomainFieldService {

	private static DomainFieldService domainFieldService ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		domainFieldService = (DomainFieldService)JunitBeanFactory.getBean("domainFieldService");
		System.out.println("----------begin TestDomainFieldService--------");
	}
	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		System.out.println("----------end TestDomainFieldService--------");
	}
	@Test
	public void testList() throws Exception {
		System.out.println(domainFieldService.list(null, null, 0, 10));
	}
//	@Test
	public void testSave() throws Exception {
		DomainField domainField = new DomainField();
		domainFieldService.save(domainField);
	}

}
