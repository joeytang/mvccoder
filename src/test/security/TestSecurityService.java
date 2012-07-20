package test.security;

import com.wanmei.domain.Security;
import com.wanmei.service.SecurityService;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import test.JunitBeanFactory;

public class TestSecurityService {

	private static SecurityService securityService ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		securityService = (SecurityService)JunitBeanFactory.getBean("securityService");
		System.out.println("----------begin TestSecurityService--------");
	}
	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		System.out.println("----------end TestSecurityService--------");
	}
	@Test
	public void testList() throws Exception {
		System.out.println(securityService.list(null, null, 0, 10));
	}
//	@Test
	public void testSave() throws Exception {
		Security security = new Security();
		securityService.save(security);
	}

}
