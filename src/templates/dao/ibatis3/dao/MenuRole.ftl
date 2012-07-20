package ${project.org}.security.domain;

import java.io.Serializable;


/**
 *
 * @author joeytang  
 * Date: ${project.currentTime}
 * 用户
 */
public class MenuRole implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Long menuId;
	private Long roleId;
	
	public MenuRole(Long menuId, Long roleId) {
		this.menuId = menuId;
		this.roleId = roleId;
	}

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	public Long getMenuId() {
		return menuId;
	}

	public void setMenuId(Long menuId) {
		this.menuId = menuId;
	}
}


