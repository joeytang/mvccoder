package ${project.org}.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Set;

import ${project.org}.dao.MenuDao;
import ${project.org}.dao.ResourceDao;
import ${project.org}.dao.RoleDao;
import ${project.org}.domain.Menu;
import ${project.org}.domain.Resource;
import ${project.org}.domain.Role;
import ${project.org}.domain.User;
import ${project.org}.service.RoleService;
import ${project.org}.util.AuthHelper;
import ${project.org}.util.Constants;
import ${project.org}.util.DateTimeUtil;
import ${project.org}.common.service.impl.BaseServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 角色业务逻辑实现
 */
@Service("roleService")
public class RoleServiceImpl extends BaseServiceImpl<Role,${project.security.idType2ShortJavaType}> implements RoleService {
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

    /**
     * 删除角色
     *
     * @param id
     */
    @Transactional
    @Override
    public void removeById(${project.security.idType2ShortJavaType} id)  throws Exception {
        Role role = this.baseDao.get(id);
        role.getResources().clear();
        role.getMenus().clear();
        Set<User> users = role.getUsers();
        for (User u : users) {
            u.getRoles().remove(role);
        }
        this.baseDao.remove(role);
    }

    /**
     * 保存角色
     *
     * @param role
     * @return
     */
    @Transactional
    @Override
    public Role save(Role role)  throws Exception {
        if (null == role.getId() || 0 == role.getId()) {
            role.setName(Constants.ROLE_PREFFIX + DateTimeUtil.dateForMat(new Date()).toString());
        }
        return this.baseDao.save(role);
    }

    /**
     * 设置用户的资源
     *
     * @param roleId
     * @param resourceId
     * @param isAuth
     */
    @Transactional
    @Override
    public void saveResources(${project.security.idType2ShortJavaType} roleId, ${project.security.idType2ShortJavaType} resourceId, boolean isAuth)  throws Exception {
        Resource resource = this.resourceDao.get(resourceId);
        Role role = this.baseDao.get(roleId);
        Set<Resource> resources = role.getResources();
        AuthHelper.saveAuth(resources, resource, isAuth);
        if (isAuth) {
            resource.getRoles().add(role);
            role.getResources().add(resource);
        } else {
            resource.getRoles().remove(role);
            role.getResources().remove(resource);
        }
        this.baseDao.save(role);
    }

    /**
     * 设置用户的菜单
     *
     * @param roleId
     * @param menuId
     * @param isAuth
     */
    @Transactional
    @Override
    public void saveMenus(${project.security.idType2ShortJavaType} roleId, ${project.security.idType2ShortJavaType} menuId, boolean isAuth)  throws Exception {
        Menu menu = this.menuDao.get(menuId);
        Role role = this.baseDao.get(roleId);
        Set<Menu> menus = role.getMenus();
        AuthHelper.saveAuth(menus, menu, isAuth);
        if (isAuth) {
            menu.getRoles().add(role);
            role.getMenus().add(menu);
        } else {
            menu.getRoles().remove(role);
            role.getMenus().remove(menu);
        }
        this.baseDao.save(role);
    }


    /**
     * 查找所有资源
     *
     * @param roleId
     * @param authorize
     * @return
     */
    @Transactional(readOnly = true)
     @Override
    public List<Resource> findResourcesByParameters(${project.security.idType2ShortJavaType} roleId, String authorize)  throws Exception {
        Role role = this.baseDao.get(roleId);

        List<Resource> AllResources = this.resourceDao.findAll();
        try {
            AuthHelper.judgeAuth(AllResources, role.getResources(), authorize);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return AllResources;
    }

    /**
     * 查找所有菜单
     *
     * @param roleId
     * @param authorize
     * @return
     */
    @Transactional(readOnly = true)
     @Override
    public List<Menu> findMenusByParameters(${project.security.idType2ShortJavaType} roleId, String authorize)  throws Exception {
        Role role = this.baseDao.get(roleId);
        List<Menu> allMenus = this.menuDao.findAll();
        try {
            AuthHelper.judgeAuth(allMenus, role.getMenus(), authorize);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return allMenus;
    }
}