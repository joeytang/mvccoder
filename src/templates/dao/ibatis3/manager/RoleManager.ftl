package ${project.org}.security.manager;

import java.util.List;

import ${project.org}.security.domain.Menu;
import ${project.org}.security.domain.Resource;
import ${project.org}.security.domain.Role;

import org.springframework.transaction.annotation.Transactional;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 角色业务逻辑接口
 */
public interface RoleManager  extends BaseManager<Role,Long>{

    /**
     * 给该角色授权资源
     *
     * @param roleId
     * @param resourceId
     * @param isAuth
     */
    @Transactional
    void saveResources(Long roleId, Long resourceId, boolean isAuth)  throws Exception;

    /**
     * 给该角色授权菜单资源
     *
     * @param roleId
     * @param menuId
     * @param isAuth
     */
    @Transactional
    void saveMenus(Long roleId, Long menuId, boolean isAuth) throws Exception;

    /**
     * 得到所有的授权资源
     *
     * @param roleId
     * @param authorize
     * @return
     */
    @Transactional(readOnly = true)
    List<Resource> findResourcesByParameters(Long roleId, String authorize) throws Exception;

    /**
     * 得到所有的菜单资源
     *
     * @param roleId
     * @param authorize
     * @return
     */
    @Transactional(readOnly = true)
    List<Menu> findMenusByParameters(Long roleId, String authorize) throws Exception;

}

