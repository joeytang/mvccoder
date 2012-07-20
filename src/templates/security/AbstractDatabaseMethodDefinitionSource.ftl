package ${project.org}.common.security.interceptor;

import java.lang.reflect.Method;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.aopalliance.intercept.MethodInvocation;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.reflect.CodeSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.access.method.MethodSecurityMetadataSource;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.util.StringUtils;

import ${project.org}.domain.ResourceDetails;
import ${project.org}.common.security.SecurityCacheManager;

/**
 * User：joeytang
 * Date: ${project.currentTime}
 * springsecurity对方法的权限判断
 */
public abstract class AbstractDatabaseMethodDefinitionSource implements MethodSecurityMetadataSource {

	private static final Log LOGGER = LogFactory
			.getLog(AbstractDatabaseMethodDefinitionSource.class);

	private SecurityCacheManager securityCacheManager;

	@Autowired
	public void setSecurityCacheManager(
			final SecurityCacheManager securityCacheManager) {
		this.securityCacheManager = securityCacheManager;
	}

	/**
	 * 资源或方法过滤
	 * 
	 * @param method
	 * @param aClass
	 * @return
	 */
	public abstract boolean isOwner(final Method method,final Object object,
			final Object[] args) ;
	/**
	 * 资源或方法过滤
	 * 
	 * @param method
	 * @param aClass
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public Collection<ConfigAttribute> getAttributes(final Method method,
			final Class aClass) {
		List<String> methodStrings = securityCacheManager.getFunctions();
		Set<GrantedAuthority> auths = new HashSet<GrantedAuthority>();
		for (Object methodString1 : methodStrings) {
			String methodString = (String) methodString1;
			if (isMatch(aClass, method, methodString)) {
				ResourceDetails resourceDetails = securityCacheManager
						.getAuthorityFromCache(methodString);

				if (resourceDetails == null) {
					break;
				}

				Collection<GrantedAuthority> authorities = resourceDetails
				.getAuthorities();

				if (authorities == null || authorities.size() == 0) {
					break;
				}
				auths.addAll(authorities);
			}
		}
		if (auths.isEmpty()) {
			return null;
		}
		String authoritiesStr = " ";
		for (Object auth : auths) {
			GrantedAuthority authority = (GrantedAuthority) auth;
			authoritiesStr += authority.getAuthority() + ",";
		}
		String authStr = authoritiesStr.substring(0,
				authoritiesStr.length() - 1);

		return SecurityConfig.createList(StringUtils.commaDelimitedListToStringArray(authStr));
	}
	@Override
	public Collection<ConfigAttribute> getAllConfigAttributes() {
		return null;
	}
	/**
	 * 容器菜单初始化
	 * 
	 * @param object
	 * @return
	 * @throws IllegalArgumentException
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Collection<ConfigAttribute> getAttributes(final Object object)
			throws IllegalArgumentException {
		Collection<ConfigAttribute> result = null;
		if (object instanceof MethodInvocation) {
			MethodInvocation miv = (MethodInvocation) object;
			result= this.getAttributes(miv.getMethod(), miv.getThis().getClass());
			if(null != result){
				if(!this.isOwner(miv.getMethod(), miv.getThis(),miv.getArguments())){
					return null;
				}
			}
			return result;
		}

		if (object instanceof JoinPoint) {
			JoinPoint jp = (JoinPoint) object;
			Class targetClazz = jp.getTarget().getClass();
			String targetMethodName = jp.getStaticPart().getSignature().getName();
			Class[] types = ((CodeSignature) jp.getStaticPart().getSignature())
					.getParameterTypes();

			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Target Class: " + targetClazz);
				LOGGER.debug("Target Method Name: " + targetMethodName);

				for (int i = 0; i < types.length; i++) {
					LOGGER.debug("Target Method Arg #" + i + ": " + types[i]);
				}
			}

			try {
				result = this.getAttributes(targetClazz.getMethod(targetMethodName, types), targetClazz);
				
				if(null != result){
					if(!this.isOwner(targetClazz.getMethod(targetMethodName, types), jp.getTarget(),jp.getArgs())){
						return null;
					}
				}
				return result;
			} catch (NoSuchMethodException nsme) {
				throw new IllegalArgumentException(
						"Could not obtain target method from JoinPoint: " + jp,
						nsme);
			}
		}

		throw new IllegalArgumentException(
				"Object must be a MethodInvocation or JoinPoint");
	}

	@SuppressWarnings("rawtypes")
	@Override
	public boolean supports(final Class aClass) {
		return (MethodInvocation.class.isAssignableFrom(aClass) || JoinPoint.class
				.isAssignableFrom(aClass));
	}

	/**
	 * 初始化加载
	 * 
	 * @param clszz
	 * @param mi
	 * @param methodString
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static boolean isMatch(Class clszz, Method mi, String methodString) {
		boolean isMatch = true;

		try {
			int lastDotIndex = methodString.lastIndexOf('.');
			String className = methodString.substring(0, lastDotIndex);
			String methodName = methodString.substring(lastDotIndex + 1);

			if (!clszz.getName().equals(className))
				isMatch = false;

			Class[] interfaces = clszz.getInterfaces();

			for (int i = 0; i < interfaces.length; i++) {
				Class inf = interfaces[i];
				if (inf.getName().equals(className)) {
					isMatch = true;
				}
			}

			if (isMatch
					&& !(mi.getName().equals(methodName)
							|| (methodName.endsWith("*") && mi.getName()
									.startsWith(
											methodName.substring(0,
													methodName.length() - 1))) || (methodName
							.startsWith("*") && mi.getName().endsWith(
							methodName.substring(1, methodName.length())))))
				isMatch = false;

		} catch (Exception e) {
			isMatch = false;
		}
		return isMatch;
	}
}
