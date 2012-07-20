package ${project.org}.dao.impl;

import org.springframework.stereotype.Repository;
import ${project.org}.domain.Resource;
import ${project.org}.dao.ResourceDao;
import ${project.org}.common.dao.impl.BaseDaoImpl;

/**
 * Created by IntelliJ IDEA.
 * User: joeytang
 * Date: ${project.currentTime}
 * 资源dao实现
 */
@Repository("resourceDao")
public class ResourceDaoImpl extends BaseDaoImpl<Resource, ${project.security.idType2ShortJavaType}> implements ResourceDao {
}

