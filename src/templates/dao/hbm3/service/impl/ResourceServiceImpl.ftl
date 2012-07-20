package ${project.org}.service.impl;

import java.util.Set;

import ${project.org}.dao.ResourceDao;
import ${project.org}.domain.Resource;
import ${project.org}.domain.Role;
import ${project.org}.service.ResourceService;
import ${project.org}.common.service.impl.BaseServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 资源业务逻辑实现
 */
@Service("resourceService")
public class ResourceServiceImpl extends BaseServiceImpl<Resource,${project.security.idType2ShortJavaType}> implements ResourceService {
    @SuppressWarnings("unused")
	@Autowired
	private void setDao(ResourceDao baseDao){
		this.baseDao = baseDao;
	}

    /**
     * 删除资源
     *
     * @param id
     */
    @Transactional
    @Override
    public void removeById(${project.security.idType2ShortJavaType} id)  throws Exception {
        Resource resource = this.baseDao.get(id);
        Set<Role> roles = resource.getRoles();
        if (null != roles && 0 != roles.size()) {
            for (Role r : roles) {
                r.getResources().remove(resource);
            }
        }
        this.baseDao.remove(resource);
    }
}
