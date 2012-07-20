package ${project.org}.security.dao.impl;

import java.util.List;

import ${project.org}.security.dao.RoleResourceDao;
import ${project.org}.security.domain.Role;
import ${project.org}.security.domain.Resource;
import ${project.org}.security.domain.RoleResource;

import org.springframework.stereotype.Repository;

/**
 *
 * User: joeytang
 * Date: ${project.currentTime}
 * roleresource关联表dao
 *
 */
@Repository("roleResourceDao")
public class RoleResourceDaoImpl extends IbatisDaoImpl<RoleResource,RoleResource> implements RoleResourceDao {
	
	@SuppressWarnings("unchecked")
	public List<Resource> listResourceByRoleId(Long roleId){
		return (List<Resource>) this.selectListObject("listResourceByRoleId",  roleId);
	}
	@SuppressWarnings("unchecked")
	public List<Role> listRoleByResourceId(Long resourceId){
		return (List<Role>) this.selectListObject("listRoleByResourceId",  resourceId);
	}
}
