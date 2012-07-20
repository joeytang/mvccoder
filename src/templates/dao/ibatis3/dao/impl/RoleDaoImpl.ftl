package ${project.org}.security.dao.impl;

import org.springframework.stereotype.Repository;

import ${project.org}.security.domain.Role;
import ${project.org}.security.dao.RoleDao;


/**
 * Created by IntelliJ IDEA.
 * User: joeytang
 * Date: ${project.currentTime}
 * 角色dao实现
 */
@Repository("roleDao")
public class RoleDaoImpl extends IbatisDaoImpl<Role, Long> implements RoleDao {

   
}

