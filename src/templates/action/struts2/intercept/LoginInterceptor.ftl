package ${project.org}.security.struts.interceptor;

import java.util.ArrayList;
import java.util.List;

import ${project.org}.security.service.UserContext;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

/**
 * 对需要登录的页面，进行拦截。
 * 如果没有登录，请求被拦截，并跳转到登录页面，否则请求可以通过
 * @author joeytang
 * Date: ${project.currentTime}
 */
public class LoginInterceptor extends AbstractInterceptor {

	private static final long serialVersionUID = 1L;
	
	@SuppressWarnings("unchecked")
	public String intercept(ActionInvocation invocation) throws Exception {
//		如果当前session中的用户对象为空，则认为没有登录
		
		if (null == UserContext.getViewUserId(ServletActionContext.getRequest())) {
			List<String> msgs = (List<String>)ServletActionContext.getRequest().getSession().getAttribute(UserContext.SESSION_MESSAGES_ID);
			if(null != msgs ){
				msgs.add("请先登录");
			}else{
				msgs = new ArrayList<String>();
			}
			ServletActionContext.getRequest().getSession().setAttribute(UserContext.SESSION_MESSAGES_ID, msgs);
			return "nologin";
		}
		return invocation.invoke();

	}
	
}
