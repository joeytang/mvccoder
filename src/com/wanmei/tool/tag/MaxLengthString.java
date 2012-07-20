package com.wanmei.tool.tag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

import com.wanmei.util.ContentUtils;

/**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * 截取字符串
 */
@SuppressWarnings("serial")
public class MaxLengthString extends BodyTagSupport {
	private Integer length;
	private String value;
	
	@Override
	public int doStartTag(){
         try {
        	 length = (null == length || length < 1?20:length);
        	 JspWriter writer = pageContext.getOut(); 
             writer.write(ContentUtils.getSubString(value, length));
         } catch (IOException e) {
             e.printStackTrace(System.err);
         }
		return EVAL_PAGE;
	}

	public Integer getLength() {
		return length;
	}

	public void setLength(Integer length) {
		this.length = length;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	

}
