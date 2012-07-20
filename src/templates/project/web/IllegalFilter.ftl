package ${project.org}.web.filter;

import java.io.IOException;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 *  过滤非法的链接
 */
public class IllegalFilter implements Filter {

	// Allowed names of parameters
    private String acceptedParamNames = "[a-zA-Z0-9\\.\\]\\[_'\\s]+";
    private Pattern acceptedPattern = Pattern.compile(acceptedParamNames);
    Set<Pattern> excludeParamsPattern = Collections.emptySet();
    Set<Pattern> acceptParamsPattern = Collections.emptySet();
    
    /**
     * init
     */
    public void init(FilterConfig config) throws ServletException {
    	@SuppressWarnings("rawtypes")
		Enumeration paramNames = config.getInitParameterNames();
    	if(null != paramNames){
    		String excludeString = null ;
    		String includeString = null ;
    		while(paramNames.hasMoreElements()){
    			String paramName = (String) paramNames.nextElement();
    			if(paramName != null && paramName.trim().toLowerCase().equals("include")){
    				includeString = config.getInitParameter(paramName);
    			}else if(paramName != null && paramName.trim().toLowerCase().equals("exclude")){
    				excludeString = config.getInitParameter(paramName);
    			}
    		}
    		if(null != includeString){
    			acceptParamsPattern = new HashSet<Pattern>();
    			String[] inludeStrings = includeString.split(",");
    			for(String i:inludeStrings){
    				acceptParamsPattern.add(Pattern.compile(i));
    			}
    		}
    		if(null != excludeString){
    			excludeParamsPattern = new HashSet<Pattern>();
    			String[] exludeStrings = excludeString.split(",");
    			for(String e:exludeStrings){
    				excludeParamsPattern.add(Pattern.compile(e));
    			}
    		}
    	}
    }
    /**
     * Filters requests to disable URL-based session identifiers.
     */
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        // skip non-http requests
        if (!(request instanceof HttpServletRequest)) {
            chain.doFilter(request, response);
            return;
        }

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        @SuppressWarnings("unchecked")
		Map<String, Object> params = request.getParameterMap();
        for(Map.Entry<String,Object> e:params.entrySet()){
        	String paramName = e.getKey();
        	if(!acceptableName(paramName)){
        		httpResponse.sendRedirect(httpRequest.getContextPath()+"/illegeparam.jsp");
        		return ;
        	}
        }
        // process next request in chain
        chain.doFilter(request, response);
    }

    

    /**
     * Unused.
     */
    public void destroy() {
    }
    
    protected boolean acceptableName(String name) {
    	if(isExcluded(name)){
    		return true;
    	}else if(isAccepted(name)) {
            return true;
        }
        return false;
    }

    protected boolean isAccepted(String paramName) {
        if (!this.acceptParamsPattern.isEmpty()) {
            for (Pattern pattern : acceptParamsPattern) {
                Matcher matcher = pattern.matcher(paramName);
                if (matcher.matches()) {
                    return true;
                }
            }
            return false;
        } else{//Added by PengFei, if not matched, break current thread.
        	boolean result = acceptedPattern.matcher(paramName).matches();
        	return result;
        }
    }

    protected boolean isExcluded(String paramName) {
        if (!this.excludeParamsPattern.isEmpty()) {
            for (Pattern pattern : excludeParamsPattern) {
                Matcher matcher = pattern.matcher(paramName);
                if (matcher.matches()) {
                    return true;
                }
            }
        }
        return false;
    }
}