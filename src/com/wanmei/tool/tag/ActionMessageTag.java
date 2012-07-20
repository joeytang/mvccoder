package com.wanmei.tool.tag;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

import com.wanmei.support.UserContext;

/**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * 显示错误信息，并将信息从session中删除消息
 */
@SuppressWarnings("serial")
public class ActionMessageTag extends BodyTagSupport {
	private String key;
	
	@Override
	public int doStartTag(){
         try {
        	 String msg = null;
        	 HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
        	 if(null != key){
        		 msg = UserContext.getMessage(request,key);
        		 UserContext.removeMessage(request,key);
        	 }else{
        		 msg = UserContext.getMessage(request);
        		 UserContext.removeMessage(request);
        	 }
        	 JspWriter writer = pageContext.getOut(); 
             writer.write(null == msg?"":msg);
         } catch (IOException e) {
             e.printStackTrace(System.err);
         }
		return EVAL_PAGE;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}
	
	

}
