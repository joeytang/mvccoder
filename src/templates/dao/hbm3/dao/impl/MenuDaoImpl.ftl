package ${project.org}.dao.impl;

import org.springframework.stereotype.Repository;
import ${project.org}.domain.Menu;
import ${project.org}.dao.MenuDao;
import ${project.org}.common.dao.impl.BaseDaoImpl;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 菜单dao实现
 */
@Repository("menuDao")
public class MenuDaoImpl extends BaseDaoImpl<Menu, ${project.security.idType2ShortJavaType}> implements MenuDao {
}