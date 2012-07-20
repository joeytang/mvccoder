package ${project.org}.security.domain;

import java.io.Serializable;


/**
 *
 * @author joeytang  
 * Date: ${project.currentTime}
 */
public class UserRole implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Long userId;
	private Long roleId;
    
    
    
	public UserRole(Long userId, Long roleId) {
		this.userId = userId;
		this.roleId = roleId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Long getRoleId() {
		return roleId;
	}
	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

    
}


