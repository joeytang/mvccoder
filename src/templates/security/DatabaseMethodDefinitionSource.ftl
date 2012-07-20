package ${project.org}.common.security.interceptor;

import java.lang.reflect.Method;

import org.springframework.stereotype.Service;

/**
 * User：joeytang
 * Date: ${project.currentTime}
 * springsecurity对方法的权限判断
 */
@Service("databaseMethodDefinitionSource")
public class DatabaseMethodDefinitionSource extends AbstractDatabaseMethodDefinitionSource {

	/**
	 * 自定义对方法执行的权限判断
	 * 
	 * @param method
	 * @param aClass
	 * @return
	 */
	@Override
	public boolean isOwner(final Method method,final Object object,
			final Object[] args) {
		return true;
	}

}