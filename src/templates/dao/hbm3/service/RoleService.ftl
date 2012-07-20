package ${project.org}.service;

import java.util.List;

import ${project.org}.domain.Menu;
import ${project.org}.domain.Resource;
import ${project.org}.domain.Role;
import ${project.org}.common.service.BaseService;
import org.springframework.transaction.annotation.Transactional;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 角色业务逻辑接口
 */
public interface RoleService  extends BaseService<Role,${project.security.idType2ShortJavaType}>{

    /**
     * 给该角色授权资源
     *
     * @param roleId
     * @param resourceId
     * @param isAuth
     */
    @Transactional
    void saveResources(${project.security.idType2ShortJavaType} roleId, ${project.security.idType2ShortJavaType} resourceId, boolean isAuth)  throws Exception;

    /**
     * 给该角色授权菜单资源
     *
     * @param roleId
     * @param menuId
     * @param isAuth
     */
    @Transactional
    void saveMenus(${project.security.idType2ShortJavaType} roleId, ${project.security.idType2ShortJavaType} menuId, boolean isAuth) throws Exception;

    /**
     * 得到所有的授权资源
     *
     * @param roleId
     * @param authorize
     * @return
     */
    @Transactional(readOnly = true)
    List<Resource> findResourcesByParameters(${project.security.idType2ShortJavaType} roleId, String authorize) throws Exception;

    /**
     * 得到所有的菜单资源
     *
     * @param roleId
     * @param authorize
     * @return
     */
    @Transactional(readOnly = true)
    List<Menu> findMenusByParameters(${project.security.idType2ShortJavaType} roleId, String authorize) throws Exception;

}

