package ${project.org}.dao;

import ${project.org}.common.dao.BaseDao;
import ${project.org}.domain.User;
/**
 *
 * User: joeytang
 * Date: ${project.currentTime}
 * 用户dao接口
 */
public interface UserDao extends BaseDao<User, ${project.security.idType2ShortJavaType}> {
}
