package ${project.org}.security.dao.impl;

import org.springframework.stereotype.Repository;

import ${project.org}.domain.Role;
import ${project.org}.dao.RoleDao;
import ${project.org}.common.dao.impl.BaseDaoImpl;


/**
 * Created by IntelliJ IDEA.
 * User: joeytang
 * Date: ${project.currentTime}
 * 角色dao实现
 */
@Repository("roleDao")
public class RoleDaoImpl extends BaseDaoImpl<Role, ${project.security.idType2ShortJavaType}> implements RoleDao {

   
}

