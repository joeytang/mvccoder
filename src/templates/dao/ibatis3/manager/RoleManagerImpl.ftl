package ${project.org}.security.manager.impl;

import java.util.Date;
import java.util.List;

import ${project.org}.security.dao.MenuDao;
import ${project.org}.security.dao.MenuRoleDao;
import ${project.org}.security.dao.ResourceDao;
import ${project.org}.security.dao.RoleDao;
import ${project.org}.security.dao.RoleResourceDao;
import ${project.org}.security.dao.UserRoleDao;
import ${project.org}.security.domain.Menu;
import ${project.org}.security.domain.MenuRole;
import ${project.org}.security.domain.Resource;
import ${project.org}.security.domain.Role;
import ${project.org}.security.domain.RoleResource;
import ${project.org}.security.domain.UserRole;
import ${project.org}.security.manager.RoleManager;
import ${project.org}.util.AuthHelper;
import ${project.org}.util.Constants;
import ${project.org}.util.DateTimeUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 角色业务逻辑实现
 */
@Service("roleManager")
public class RoleManagerImpl extends BaseManagerImpl<Role,Long> implements RoleManager {
    @SuppressWarnings("unused")
	@Autowired
	private void setDao(RoleDao baseDao){
		this.baseDao = baseDao;
	}
    /**
     * 资源DAO
     */
    @Autowired
    private ResourceDao resourceDao;
    /**
     * 菜单DAO
     */
    @Autowired
    private MenuDao menuDao;
    
    @Autowired
    private UserRoleDao userRoleDao;
    @Autowired
    private MenuRoleDao menuRoleDao;
    @Autowired
    private RoleResourceDao roleResourceDao;

    /**
     * 删除角色
     *
     * @param id
     * @throws Exception 
     */
    @Transactional
    @Override
    public int removeById(Long id) throws Exception {
    	userRoleDao.remove(new UserRole(null,id));
    	menuRoleDao.remove(new MenuRole(null,id));
    	roleResourceDao.remove(new RoleResource(id,null));
        return this.baseDao.removeById(id);
    }

    /**
     * 保存角色
     *
     * @param role
     * @return
     * @throws Exception 
     */
    @Transactional
    @Override
    public int save(Role role) throws Exception {
        if (null == role.getId() || 0 == role.getId()) {
            role.setName(Constants.ROLE_PREFFIX + DateTimeUtil.dateForMat(new Date()).toString());
        }
        return this.baseDao.saveOrUpdate(role);
    }

    /**
     * 设置用户的资源
     *
     * @param roleId
     * @param resourceId
     * @param isAuth
     * @throws Exception 
     */
    @Transactional
    @Override
    public void saveResources(Long roleId, Long resourceId, boolean isAuth) throws Exception {
        Resource resource = this.resourceDao.get(resourceId);
        Role role = this.baseDao.get(roleId);
        AuthHelper.saveAuth(roleResourceDao.listResourceByRoleId(roleId), resource, isAuth);
        if (isAuth) {
            roleResourceDao.save(new RoleResource(roleId,resourceId));
        } else {
        	roleResourceDao.remove(new RoleResource(roleId,resourceId));
        }
        this.baseDao.save(role);
    }

    /**
     * 设置用户的菜单
     *
     * @param roleId
     * @param menuId
     * @param isAuth
     * @throws Exception 
     */
    @Transactional
    @Override
    public void saveMenus(Long roleId, Long menuId, boolean isAuth) throws Exception {
        Menu menu = this.menuDao.get(menuId);
        Role role = this.baseDao.get(roleId);
        AuthHelper.saveAuth(menuRoleDao.listMenuByRoleId(roleId), menu, isAuth);
        if (isAuth) {
            menuRoleDao.save(new MenuRole(menuId,roleId));
        } else {
        	menuRoleDao.remove(new MenuRole(menuId,roleId));
        }
        this.baseDao.save(role);
    }


    /**
     * 查找所有资源
     *
     * @param roleId
     * @param authorize
     * @return
     * @throws Exception 
     */
    @Transactional(readOnly = true)
     @Override
    public List<Resource> findResourcesByParameters(Long roleId, String authorize) throws Exception {

        List<Resource> resources = this.resourceDao.listAll(-1,-1);
        try {
            AuthHelper.judgeAuth(resources, roleResourceDao.listResourceByRoleId(roleId), authorize);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resources;
    }

    /**
     * 查找所有菜单
     *
     * @param roleId
     * @param authorize
     * @return
     * @throws Exception 
     */
    @Transactional(readOnly = true)
     @Override
    public List<Menu> findMenusByParameters(Long roleId, String authorize) throws Exception {
        List<Menu> menus = this.menuDao.listAll(-1,-1);
        try {
            AuthHelper.judgeAuth(menus, menuRoleDao.listMenuByRoleId(roleId), authorize);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return menus;
    }
}