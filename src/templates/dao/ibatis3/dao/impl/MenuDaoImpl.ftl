package ${project.org}.security.dao.impl;

import org.springframework.stereotype.Repository;
import ${project.org}.security.domain.Menu;
import ${project.org}.security.dao.MenuDao;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 菜单dao实现
 */
@Repository("menuDao")
public class MenuDaoImpl extends IbatisDaoImpl<Menu, Long> implements MenuDao {
}