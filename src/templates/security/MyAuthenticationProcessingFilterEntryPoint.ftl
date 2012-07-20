package ${project.org}.common.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ${project.org}.util.RenderUtils;

import org.apache.commons.lang.xwork.StringUtils;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;
/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 请求地址失败后处理登陆跳转，非ajax请求跳转到login.jsp，ajax请求，返回json对象
 */
public class MyAuthenticationProcessingFilterEntryPoint extends LoginUrlAuthenticationEntryPoint {
	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException)
            throws IOException, ServletException{
		String ajaxRequest = request.getHeader("X-Requested-With");//判断是否为ajax请求
		if(StringUtils.isNotBlank(ajaxRequest)){
			RenderUtils.renderText(response, RenderUtils.getStatusUnlogin().toString());
		}else{
			super.commence(request, response, authException);
		}
		return ;
	}
	
}
