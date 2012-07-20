package test.${domain.lowerFirstName};

import ${domain.packageName}.${domain.name};
import ${project.org}.service.${domain.name}Service;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import test.JunitBeanFactory;

public class Test${domain.name}Service {

	private static ${domain.name}Service ${domain.lowerFirstName}Service ;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		${domain.lowerFirstName}Service = (${domain.name}Service)JunitBeanFactory.getBean("${domain.lowerFirstName}Service");
		System.out.println("----------begin Test${domain.name}Service--------");
	}
	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		System.out.println("----------end Test${domain.name}Service--------");
	}
	@Test
	public void testList() throws Exception {
		System.out.println(${domain.lowerFirstName}Service.list(null, null, 0, 10));
	}
//	@Test
	public void testSave() throws Exception {
		${domain.name} ${domain.lowerFirstName} = new ${domain.name}();
		${domain.lowerFirstName}Service.save(${domain.lowerFirstName});
	}

}
