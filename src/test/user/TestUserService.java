package test.user;

import com.wanmei.domain.User;
import com.wanmei.service.UserService;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import test.JunitBeanFactory;

public class TestUserService {

	private static UserService userService ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		userService = (UserService)JunitBeanFactory.getBean("userService");
		System.out.println("----------begin TestUserService--------");
	}
	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		System.out.println("----------end TestUserService--------");
	}
	@Test
	public void testList() throws Exception {
		System.out.println(userService.list(null, null, 0, 10));
	}
//	@Test
	public void testSave() throws Exception {
		User user = new User();
		userService.save(user);
	}

}
