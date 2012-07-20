package test.domain;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import test.JunitBeanFactory;

import com.wanmei.common.dao.SqlFilter;
import com.wanmei.domain.Domain;
import com.wanmei.service.DomainService;

public class TestDomainService {

	private static DomainService domainService ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		domainService = (DomainService)JunitBeanFactory.getBean("domainService");
		System.out.println("----------begin TestDomainService--------");
	}
	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		System.out.println("----------end TestDomainService--------");
	}
	@Test
	public void testList() throws Exception {
		SqlFilter filter = new SqlFilter();
		filter.addFilter("fields", "f",SqlFilter.OP.aliase);
		filter.addFilter("f", null,SqlFilter.OP.isNotNull);
		domainService.count(filter);
	}
//	@Test
	public void testSave() throws Exception {
		Domain domain = new Domain();
		domainService.save(domain);
	}

}
