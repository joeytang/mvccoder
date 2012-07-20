package ${project.org}.service;

<#if project.security.type==statics["com.wanmei.domain.SecurityHelper"].TYPE_COMPLEX>
import java.util.List;
import ${project.org}.domain.Role;
import org.springframework.transaction.annotation.Transactional;
</#if>
import ${project.org}.dao.UserDao;
import ${project.org}.domain.User;
import ${project.org}.common.service.BaseService;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 用户业务逻辑接口
 */
public interface UserService extends BaseService<User,${project.security.idType2ShortJavaType},UserDao>{
  <#if project.security.type==statics["com.wanmei.domain.SecurityHelper"].TYPE_COMPLEX>
   /**
     * 用户角色授权
     *
     * @param userId
     * @param roleId
     * @param isAuth
     */
    @Transactional
    void saveRoles(${project.security.idType2ShortJavaType} userId, ${project.security.idType2ShortJavaType} roleId, boolean isAuth) throws Exception;

    /**
     * 查找用户的角色
     *
     * @param userId
     * @param authorize
     * @return
     */
    @Transactional(readOnly = true)
    List<Role> findUsersByParameters(${project.security.idType2ShortJavaType} userId, String authorize) throws Exception;
    /**
     * 禁用用户
     * @param id
     */
    @Transactional
    public void disable(${project.security.idType2ShortJavaType} id)  throws Exception;
    /**
     * 启用用户
     * @param id
     */
    @Transactional
    public void enable(${project.security.idType2ShortJavaType} id)  throws Exception;
</#if>
}
