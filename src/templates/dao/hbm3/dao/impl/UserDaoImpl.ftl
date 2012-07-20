package ${project.org}.dao.impl;

import ${project.org}.common.dao.impl.BaseDaoImpl;
import ${project.org}.domain.User;
import ${project.org}.dao.UserDao;
import org.springframework.stereotype.Repository;
/**
 *
 * User: joeytang
 * Date: ${project.currentTime}
 * 用户dao实现
 */
@Repository("userDao")
public class UserDaoImpl extends BaseDaoImpl<User, ${project.security.idType2ShortJavaType}> implements UserDao {
}
