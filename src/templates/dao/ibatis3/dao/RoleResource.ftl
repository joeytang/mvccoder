package ${project.org}.security.domain;

import java.io.Serializable;


/**
 *
 * @author joeytang  
 * Date: ${project.currentTime}
 *  角色资源关系
 */
public class RoleResource implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Long roleId;
	private Long resouceId;
	public RoleResource(Long roleId, Long resouceId) {
		this.roleId = roleId;
		this.resouceId = resouceId;
	}

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	public Long getResouceId() {
		return resouceId;
	}

	public void setResouceId(Long resouceId) {
		this.resouceId = resouceId;
	}
}


