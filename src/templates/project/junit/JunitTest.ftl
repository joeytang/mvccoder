package test;

import org.junit.Assert;
import org.junit.Test;

/**
 *
 * User: joeytang
 * Date: ${project.currentTime}
 * junit测试基本类
 *
 */
public class JunitTest {

	@Test
	public void testTest(){
		Assert.assertNotNull(JunitBeanFactory.getContext());
	}
}
