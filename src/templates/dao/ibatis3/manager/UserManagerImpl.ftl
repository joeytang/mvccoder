package ${project.org}.security.manager.impl;

import java.util.HashSet;
import java.util.List;

import ${project.org}.security.dao.RoleDao;
import ${project.org}.security.dao.UserDao;
import ${project.org}.security.dao.UserRoleDao;
import ${project.org}.security.domain.Role;
import ${project.org}.security.domain.User;
import ${project.org}.security.domain.UserRole;
import ${project.org}.security.manager.UserManager;
import ${project.org}.util.AuthHelper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 用户业务逻辑实现
 */
@Service("userManager")
public class UserManagerImpl extends BaseManagerImpl<User,Long> implements UserManager {

	@SuppressWarnings("unused")
	@Autowired
	private void setDao(UserDao baseDao){
		this.baseDao = baseDao;
	}
	@Autowired
	private RoleDao roleDao;
	@Autowired
    private UserRoleDao userRoleDao;

    /**
     * 删除用户
     * @param id
     */
    @Transactional
    @Override
    public int removeById(Long id) throws Exception {
    	userRoleDao.remove(new UserRole(id,null));
        User user = this.baseDao.get(id);
        user.setDisabled(true);
        this.baseDao.update(user);
    	return 1;
    }

    /**
     * 用户角色授权
     * @param userId
     * @param roleId
     * @param isAuth
     */
    @Transactional
    @Override
    public void saveRoles(Long userId, Long roleId, boolean isAuth) throws Exception {
        Role role = this.roleDao.get(roleId);
        AuthHelper.saveAuth(this.userRoleDao.listRoleByUserId(userId), role, isAuth);
        if (isAuth) {
        	userRoleDao.save(new UserRole(userId, roleId));
        } else {
        	userRoleDao.remove(new UserRole(userId, roleId));
        }
    }

    /**
     * 查找该用户的所有角色
     * @param userId
     * @param authorize
     * @return
     */
    @Transactional(readOnly = true)
    @Override
    public List<Role> findUsersByParameters(Long userId, String authorize) throws Exception {
        List<Role> roles = this.roleDao.listAll(-1, -1);
        try {
            AuthHelper.judgeAuth(roles, this.userRoleDao.listRoleByUserId(userId), authorize);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roles;
    }
    public User get(Long id,boolean isLazy) throws Exception{
    	User user = this.baseDao.get(id);
    	if(null != user && !isLazy){
    		user.setRoles(new HashSet<Role>(userRoleDao.listRoleByUserId(id)));
    	}
    	return user;
    }
}