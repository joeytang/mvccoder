package ${project.org}.security.dao.impl;

import java.util.List;

import ${project.org}.security.dao.UserRoleDao;
import ${project.org}.security.domain.Role;
import ${project.org}.security.domain.User;
import ${project.org}.security.domain.UserRole;

import org.springframework.stereotype.Repository;

/**
 *
 * User: joeytang
 * Date: ${project.currentTime}
 * userrole关联表dao
 *
 */
@Repository("userRoleDao")
public class UserRoleDaoImpl extends IbatisDaoImpl<UserRole,UserRole> implements UserRoleDao {
	
	@SuppressWarnings("unchecked")
	public List<User> listUserByRoleId(Long roleId){
		return (List<User>) this.selectListObject("listUserByRoleId",  roleId);
	}
	@SuppressWarnings("unchecked")
	public List<Role> listRoleByUserId(Long userId){
		return (List<Role>) this.selectListObject("listRoleByUserId",  userId);
	}
}
