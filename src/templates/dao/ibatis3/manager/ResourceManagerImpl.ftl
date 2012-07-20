package ${project.org}.security.manager.impl;

import ${project.org}.security.dao.ResourceDao;
import ${project.org}.security.dao.RoleResourceDao;
import ${project.org}.security.domain.Resource;
import ${project.org}.security.domain.RoleResource;
import ${project.org}.security.manager.ResourceManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 资源业务逻辑实现
 */
@Service("resourceManager")
public class ResourceManagerImpl extends BaseManagerImpl<Resource,Long> implements ResourceManager {
    @SuppressWarnings("unused")
	@Autowired
	private void setDao(ResourceDao baseDao){
		this.baseDao = baseDao;
	}
    @Autowired
	private RoleResourceDao roleResourceDao;
    /**
     * 删除资源
     *
     * @param id
     * @throws Exception 
     */
    @Transactional
    public int removeById(Long id) throws Exception {
    	roleResourceDao.remove(new RoleResource(null,id));
        return this.baseDao.removeById(id);
    }
}
