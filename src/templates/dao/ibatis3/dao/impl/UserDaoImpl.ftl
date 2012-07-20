package ${project.org}.security.dao.impl;

import ${project.org}.security.domain.User;
import ${project.org}.security.dao.UserDao;
import org.springframework.stereotype.Repository;
/**
 *
 * User: joeytang
 * Date: ${project.currentTime}
 * 用户dao实现
 */
@Repository("userDao")
public class UserDaoImpl extends IbatisDaoImpl<User, Long> implements UserDao {
}
