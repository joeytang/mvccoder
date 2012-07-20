package ${project.org}.tool.tags;

import org.apache.struts2.views.jsp.ComponentTagSupport;

import com.opensymphony.xwork2.util.ValueStack;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.components.Component;

import ${project.org}.tool.tags.component.Pages;


/**
 * User: joeytang
 * Date: ${project.currentTime}
 * struts实现分页标签
 */
public class PageTag extends ComponentTagSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
    private String value = null;
    private int pageNum = 10;
    private int model = 2;

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public int getModel() {
        return model;
    }

    public void setModel(int model) {
        this.model = model;
    }

    @Override
    protected void populateParams() {
        super.populateParams();
        Pages pages = (Pages)component;
        pages.setModel(model);
        pages.setPageNum(pageNum);
        pages.setValue(value);
    }

    public Component getBean(ValueStack valueStack, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {
        Pages pages = new Pages(valueStack);
        return pages;
    }
}