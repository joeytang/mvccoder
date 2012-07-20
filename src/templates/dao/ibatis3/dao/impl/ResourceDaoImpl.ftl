package ${project.org}.security.dao.impl;

import org.springframework.stereotype.Repository;
import ${project.org}.security.domain.Resource;
import ${project.org}.security.dao.ResourceDao;

/**
 * Created by IntelliJ IDEA.
 * User: joeytang
 * Date: ${project.currentTime}
 * 资源dao实现
 */
@Repository("resourceDao")
public class ResourceDaoImpl extends IbatisDaoImpl<Resource, Long> implements ResourceDao {
}

