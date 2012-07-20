package test.dao;

import com.wanmei.domain.Dao;
import com.wanmei.service.DaoService;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import test.JunitBeanFactory;

public class TestDaoService {

	private static DaoService daoService ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		daoService = (DaoService)JunitBeanFactory.getBean("daoService");
		System.out.println("----------begin TestDaoService--------");
	}
	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		System.out.println("----------end TestDaoService--------");
	}
	@Test
	public void testList() throws Exception {
		System.out.println(daoService.list(null, null, 0, 10));
	}
//	@Test
	public void testSave() throws Exception {
		Dao dao = new Dao();
		daoService.save(dao);
	}

}
