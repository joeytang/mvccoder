package test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
/**
 *
 * User: joeytang
 * Date: 2012-03-20 18:17
 * junit测试获取spring管理的bean的工厂类
 *
 */
public class JunitBeanFactory {
	static {
		String[] locations = {"config/spring/spring-root.xml"};
		ctx = new ClassPathXmlApplicationContext(locations);
	}
	private JunitBeanFactory(){}
	public static ApplicationContext ctx;
	
	public static Object getBean(String bean){
		return ctx.getBean(bean);
	}
	
	public static ApplicationContext getContext(){
		return ctx;
	}

	
}
