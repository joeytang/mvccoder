package ${project.org}.tool.tag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

import ${project.org}.util.ContentUtils;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 截取字符串
 */
@SuppressWarnings("serial")
public class MaxLengthString extends BodyTagSupport {
	private Integer length;
	private String value;
	
	@Override
	public int doStartTag(){
         try {
        	 int temp = null == length?0: length.intValue();
        	 temp = (temp < 1?20:temp);
        	 JspWriter writer = pageContext.getOut(); 
             writer.write(ContentUtils.getSubString(value, temp));
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
