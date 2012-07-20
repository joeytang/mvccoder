package ${project.org}.security.dao;

import java.util.List;

import ${project.org}.security.domain.Role;
import ${project.org}.security.domain.User;
import ${project.org}.security.domain.UserRole;

/**
 *
 * @author joeytang  
 * Date: ${project.currentTime}
 *
 */
public interface UserRoleDao extends BaseDao<UserRole, UserRole> {
	public List<User> listUserByRoleId(Long roleId);
	public List<Role> listRoleByUserId(Long userId);
}
