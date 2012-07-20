package test.db;

import com.wanmei.domain.Db;
import com.wanmei.service.DbService;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import test.JunitBeanFactory;

public class TestDbService {

	private static DbService dbService ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		dbService = (DbService)JunitBeanFactory.getBean("dbService");
		System.out.println("----------begin TestDbService--------");
	}
	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		System.out.println("----------end TestDbService--------");
	}
	@Test
	public void testList() throws Exception {
		System.out.println(dbService.list(null, null, 0, 10));
	}
//	@Test
	public void testSave() throws Exception {
		Db db = new Db();
		dbService.save(db);
	}

}
