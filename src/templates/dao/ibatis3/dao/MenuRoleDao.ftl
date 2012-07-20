package ${project.org}.security.dao;

import java.util.List;

import ${project.org}.security.domain.Role;
import ${project.org}.security.domain.Menu;
import ${project.org}.security.domain.MenuRole;

/**
 *
 * @author joeytang  
 * Date: ${project.currentTime}
 *
 */
public interface MenuRoleDao extends BaseDao<MenuRole, MenuRole> {
	public List<Menu> listMenuByRoleId(Long roleId);
	public List<Role> listRoleByMenuId(Long menuId);
}
