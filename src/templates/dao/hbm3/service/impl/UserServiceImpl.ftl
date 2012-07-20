package ${project.org}.service.impl;


<#if project.security.type==statics["com.wanmei.domain.SecurityHelper"].TYPE_COMPLEX>
import java.util.List;
import java.util.Set;
import ${project.org}.dao.RoleDao;
import ${project.org}.dao.UserDao;
import ${project.org}.domain.Role;
import ${project.org}.util.AuthHelper;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
</#if>
import ${project.org}.domain.User;
import ${project.org}.dao.UserDao;
import ${project.org}.service.UserService;
import ${project.org}.common.service.impl.BaseServiceImpl;

import org.springframework.stereotype.Service;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 用户业务逻辑实现
 */
@Service("userService")
public class UserServiceImpl extends BaseServiceImpl<User,${project.security.idType2ShortJavaType},UserDao> implements UserService {
	<#if project.security.type==statics["com.wanmei.domain.SecurityHelper"].TYPE_COMPLEX>
	@Autowired
    private RoleDao roleDao;

	/**
	 * 禁用用户
	 * @param id
	 */
	@Transactional
	@Override
	public void disable(${project.security.idType2ShortJavaType} id)  throws Exception {
		User user = this.baseDao.get(id);
		user.getRoles().clear();
		user.setDisabled(true);
		this.baseDao.save(user);
	}
    /**
     * 禁用用户
     * @param id
     */
    @Transactional
    @Override
    public void enable(${project.security.idType2ShortJavaType} id)  throws Exception {
        User user = this.baseDao.get(id);
        user.getRoles().clear();
        user.setDisabled(false);
        this.baseDao.save(user);
    }

    /**
     * 用户角色授权
     * @param userId
     * @param roleId
     * @param isAuth
     */
    @Transactional
    @Override
    public void saveRoles(${project.security.idType2ShortJavaType} userId, ${project.security.idType2ShortJavaType} roleId, boolean isAuth) throws Exception {
        User user = this.baseDao.get(userId);
        Role role = this.roleDao.get(roleId);
        Set<Role> roles = user.getRoles();
        AuthHelper.saveAuth(roles, role, isAuth);

        if (isAuth) {
        	
            role.getUsers().add(user);
        } else {
            role.getUsers().remove(user);
        }

        this.baseDao.save(user);
    }

    /**
     * 查找该用户的所有角色
     * @param userId
     * @param authorize
     * @return
     */
    @Transactional(readOnly = true)
    @Override
    public List<Role> findUsersByParameters(${project.security.idType2ShortJavaType} userId, String authorize)  throws Exception {
        User user = baseDao.get(userId);
        List<Role> roles = this.roleDao.findAll();
        try {
            AuthHelper.judgeAuth(roles, user.getRoles(), authorize);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roles;
    }
    </#if>
}