package ${project.org}.security.dao.impl;

import java.util.List;

import ${project.org}.security.dao.MenuRoleDao;
import ${project.org}.security.domain.Role;
import ${project.org}.security.domain.Menu;
import ${project.org}.security.domain.MenuRole;

import org.springframework.stereotype.Repository;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * menurole关联表dao
 */
@Repository("menuRoleDao")
public class MenuRoleDaoImpl extends IbatisDaoImpl<MenuRole,MenuRole> implements MenuRoleDao {
	
	@SuppressWarnings("unchecked")
	public List<Menu> listMenuByRoleId(Long roleId){
		return (List<Menu>) this.selectListObject("listMenuByRoleId",  roleId);
	}
	@SuppressWarnings("unchecked")
	public List<Role> listRoleByMenuId(Long menuId){
		return (List<Role>) this.selectListObject("listRoleByMenuId",  menuId);
	}
}
