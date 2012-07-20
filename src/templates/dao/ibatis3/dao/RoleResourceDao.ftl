package ${project.org}.security.dao;

import java.util.List;

import ${project.org}.security.domain.Resource;
import ${project.org}.security.domain.Role;
import ${project.org}.security.domain.RoleResource;

/**
 *
 * @author joeytang  
 * Date: ${project.currentTime}
 *
 */
public interface RoleResourceDao extends BaseDao<RoleResource, RoleResource> {
	public List<Resource> listResourceByRoleId(Long roleId);
	public List<Role> listRoleByResourceId(Long resourceId);
}
