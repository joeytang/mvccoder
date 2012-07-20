package ${project.org}.common.security.interceptor;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import org.apache.oro.text.regex.MalformedPatternException;
import org.apache.oro.text.regex.Pattern;
import org.apache.oro.text.regex.PatternMatcher;
import org.apache.oro.text.regex.Perl5Compiler;
import org.apache.oro.text.regex.Perl5Matcher;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.stereotype.Service;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.PathMatcher;
import org.springframework.util.StringUtils;

import ${project.org}.domain.ResourceDetails;
import ${project.org}.common.security.SecurityCacheManager;

/**
 * Created by IntelliJ IDEA.
 * User：joeytang
 * Date: ${project.currentTime}
 * springsecurity对地址的权限过滤
 */
@Service("secureResourceFilterInvocationDefinitionSource")
public class SecureResourceFilterInvocationDefinitionSource implements FilterInvocationSecurityMetadataSource, InitializingBean {

    private boolean convertUrlToLowercaseBeforeComparison = true;

    private boolean useAntPath = true;

    private final PathMatcher pathMatcher = new AntPathMatcher();

    private final PatternMatcher matcher = new Perl5Matcher();


    private SecurityCacheManager securityCacheManager;

    @Autowired
    public void setSecurityCacheManager(final SecurityCacheManager securityCacheManager) {
        this.securityCacheManager = securityCacheManager;
    }

    public void afterPropertiesSet() throws Exception {
    }
   


    public boolean isConvertUrlToLowercaseBeforeComparison() {
        return convertUrlToLowercaseBeforeComparison;
    }

    public void setConvertUrlToLowercaseBeforeComparison(final boolean convertUrlToLowercaseBeforeComparison) {
        this.convertUrlToLowercaseBeforeComparison = convertUrlToLowercaseBeforeComparison;
    }

    public boolean isUseAntPath() {
        return useAntPath;
    }

    public void setUseAntPath(final boolean useAntPath) {
        this.useAntPath = useAntPath;
    }
    
    @Override
    public Collection<ConfigAttribute> getAttributes(final Object filter) throws IllegalArgumentException {

        FilterInvocation filterInvocation = (FilterInvocation) filter;
        String requestURI = filterInvocation.getRequestUrl();
        //找到当前的url数据
        if (isUseAntPath()) {
            int firstQuestionMarkIndex = requestURI.lastIndexOf("?");

            if (firstQuestionMarkIndex != -1) {
                requestURI = requestURI.substring(0, firstQuestionMarkIndex);
            }
        }

        //从数据库读取或读出缓存中的数据
        List<String> urls = securityCacheManager.getUrlResStrings();

        //倒叙排序--如果不进行排序，如果用户使用浏览器的导航工具访问页面可能出现问题
        //例如：访问被拒绝后用户刷新页面
        Collections.sort(urls);
        Collections.reverse(urls);
        //将URL在比较前都转换为小写
        if (convertUrlToLowercaseBeforeComparison) {
            requestURI = requestURI.toLowerCase();
        }

        Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();

        //将请求的URL与配置的URL资源进行匹配，并将正确匹配的URL资源对应的权限

        //取出
        for (Iterator<String> iterator = urls.iterator(); iterator.hasNext();) {
            String resString = iterator.next();
            boolean matched = false;
            //使用ant匹配URL
            if (isUseAntPath()) {
                matched = pathMatcher.match(resString, requestURI);
            } else {
                //perl5编译URL
                Pattern compiledPattern;
                Perl5Compiler compiler = new Perl5Compiler();
                try {
                    compiledPattern = compiler.compile(resString, Perl5Compiler.READ_ONLY_MASK);
                } catch (MalformedPatternException mpe) {
                    throw new IllegalArgumentException("Malformed regular expression: " + resString, mpe);
                }

                matched = matcher.matches(requestURI, compiledPattern);
            }
            //匹配正确,获取响应权限
            if (matched) {
                //获取正确匹配URL资源对应的权限
                ResourceDetails resourceDetails = securityCacheManager.getAuthorityFromCache(resString);
                authorities = resourceDetails.getAuthorities();
                break;
            }
        }
        //将权限封装成ConfigAttributeDefinition对象返回（使用ConfigAttributeEditor）       
        if (null != authorities ) {
        	String authoritiesStr = " ";
        	for(GrantedAuthority authoritie:authorities){
        		authoritiesStr += authoritie.getAuthority() + ",";
        	}

            String authStr = authoritiesStr.substring(0, authoritiesStr.length() - 1);
            return SecurityConfig.createList(StringUtils.commaDelimitedListToStringArray(authStr));
        }

        return null;
    }
	@Override
	public Collection<ConfigAttribute> getAllConfigAttributes() {
        return null;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return true;
	}
}

