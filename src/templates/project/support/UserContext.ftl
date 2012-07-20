package ${project.org}.support;

import ${project.org}.domain.User;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.xwork.StringUtils;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Collection;
import java.util.HashSet;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 获取当前用户信息service
 */
public class UserContext {

    public static final String USER = "user";   //用户
    public static final String VALIDATECODEKEY = "rand";
    
    /**
     * 获取后台用户的当前用户
     *
     * @return user
     */
    public static User getSecurityUser() {
        return (SecurityContextHolder.getContext() == null || SecurityContextHolder.getContext().getAuthentication() == null) ? null : (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    }
    
    public static void setSessionUser(HttpServletRequest request,User user){
    	request.getSession().setAttribute(USER, user);
    }
    public static User getSessionUser(HttpServletRequest request) {
    	Object o = request.getSession().getAttribute(USER);
    	if(null != o){
    		return (User)o;
    	}
    	return null;
    }
    /**
     * 判断是否具有某个角色
     * @param role
     * @return
     */
    public static boolean hasRole(String role){
    	return hasRoles(new String[]{role});
    }
    /**
     * 判断是否具有某些角色
     * @param role
     * @return
     */
    public static boolean hasRoles(String[] roles){
    	if(null == roles || roles.length < 1 || SecurityContextHolder.getContext() == null || SecurityContextHolder.getContext().getAuthentication() == null || null == SecurityContextHolder.getContext().getAuthentication().getAuthorities()){
    		return false;
    	}
    	Collection<GrantedAuthority> aus = new HashSet<GrantedAuthority>();
    	for(String role:roles){
    		aus.add(new SimpleGrantedAuthority(role));
    	}
    	return SecurityContextHolder.getContext().getAuthentication().getAuthorities().containsAll(aus);
    }
    
	public static final String SESSION_MESSAGES_ID = "messages";

    /**
     * Save the message in the session, appending if messages already exist
     *
     * @param msg the message to put in the session
     */
	public static void saveMessage(HttpServletRequest request,String msg) {
    	request.getSession().setAttribute(SESSION_MESSAGES_ID, msg);
    }
    public static boolean hasMessage(HttpServletRequest request) {
    	if(null != request.getSession().getAttribute(SESSION_MESSAGES_ID)){
    		return true;
    	}
    	return false;
    }
   public static String getMessage(HttpServletRequest request) {
    	Object o = request.getSession().getAttribute(SESSION_MESSAGES_ID);
    	if(null != o){
    		return (String)o;
    	}
    	return null;
    }
    /**
     * Save the message in the session, appending if messages already exist
     *
     * @param msg the message to put in the session
     */
    public static void saveMessage(HttpServletRequest request,String key,String msg) {
        request.getSession().setAttribute(key, msg);
    }
    public static boolean hasMessage(HttpServletRequest request,String key) {
    	if(null != request.getSession().getAttribute(key)){
    		return true;
    	}
    	return false;
    }
    public static String getMessage(HttpServletRequest request,String key) {
    	Object o = request.getSession().getAttribute(key);
    	if(null != o){
    		return (String)o;
    	}
    	return null;
    }

    /**
     * 删除信息
     */
    public static void removeMessage(HttpServletRequest request) {
    	if (request.getSession().getAttribute(SESSION_MESSAGES_ID) != null) {
    		request.getSession().removeAttribute(SESSION_MESSAGES_ID);
    	}
    }
    /**
     * 删除信息
     */
    public static void removeMessage(HttpServletRequest request,String key) {
        if (request.getSession().getAttribute(key) != null) {
            request.getSession().removeAttribute(key);
        }
    }
    /**
     * 设置验证码
     * @param request
     * @param code
     */
    public static void setValidateCode(HttpServletRequest request,String code){
    	saveMessage(request,VALIDATECODEKEY,code);
    }
    /**
     * 读取验证码
     * @param request
     * @return
     */
    public static boolean isValidateCode(HttpServletRequest request,String code,boolean caseIgnoreCase){
    	String oriCode = getMessage(request,VALIDATECODEKEY);
    	if(StringUtils.isBlank(oriCode)){
    		return true;
    	}
    	if(StringUtils.isBlank(code)){
    		return false;
    	}
    	if(caseIgnoreCase){
    		return oriCode.equalsIgnoreCase(code);
    	}
    	return oriCode.equals(code);
    }
}
