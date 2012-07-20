package templates.domain;

import java.io.Serializable;

import javax.persistence.Transient;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 基础类
 */
public class BaseAuthorizeDomain implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
     * 授权标识
     */
    private String authorize;

    @Transient
    public String getAuthorize() {
        return authorize;
    }

    public void setAuthorize(String authorize) {
        this.authorize = authorize;
    }
}