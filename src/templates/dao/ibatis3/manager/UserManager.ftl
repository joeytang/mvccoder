package ${project.org}.security.manager;

import java.util.List;

import ${project.org}.security.domain.Role;
import ${project.org}.security.domain.User;
import org.springframework.transaction.annotation.Transactional;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 用户业务逻辑接口
 */
public interface UserManager extends BaseManager<User,Long>{


    /**
     * 用户角色授权
     *
     * @param userId
     * @param roleId
     * @param isAuth
     */
    @Transactional
    void saveRoles(Long userId, Long roleId, boolean isAuth) throws Exception;

    /**
     * 查找用户的角色
     *
     * @param userId
     * @param authorize
     * @return
     */
    @Transactional(readOnly = true)
    List<Role> findUsersByParameters(Long userId, String authorize) throws Exception;

}
