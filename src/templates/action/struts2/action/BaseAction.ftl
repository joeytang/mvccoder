package ${project.org}.security.web.action;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.opensymphony.xwork2.ActionSupport;

/**
 * User:joeytang
 * Date: ${project.currentTime}
 * 基础action
 */
public class BaseAction extends ActionSupport {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected transient final Log logger = LogFactory.getLog(this.getClass());
    private String forwardpagename;


    public String getForwardpagename() {
        return forwardpagename;
    }

    public void setForwardpagename(String forwardpagename) {
        this.forwardpagename = forwardpagename;
    }


    @Override
    public void addFieldError(String s, String s1) {
    	logger.debug("addFieldError1 = " + s);
    	logger.debug("addFieldError2 = " + s1);
        super.addFieldError(s, s1);    //To change body of overridden methods use File | Settings | File Templates.
    }

    @Override
    public void addActionError(String s) {
    	logger.debug("addActionError = " + s);
        super.addActionError(s);    //To change body of overridden methods use File | Settings | File Templates.
    }

    @Override
    public void addActionMessage(String s) {
    	logger.debug("addActionMessage = " + s);
        super.addActionMessage(s);    //To change body of overridden methods use File | Settings | File Templates.
    }
    
}