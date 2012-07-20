package ${project.org}.security.manager.impl;

import java.io.Serializable;
import java.util.List;

import ${project.org}.security.dao.BaseDao;
import ${project.org}.security.dao.SqlFilter;
import ${project.org}.security.dao.SqlSort;
import ${project.org}.security.dao.impl.IbatisSqlFilter;
import ${project.org}.security.manager.BaseManager;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.transaction.annotation.Transactional;

/**
 * 处理业务逻辑
 * @author joeytang  
 * Date: ${project.currentTime}
 */
public class BaseManagerImpl<T extends Serializable, PK extends Serializable> implements BaseManager<T, PK> {

	 
	protected BaseDao<T, PK> baseDao;
	protected final Log logger = LogFactory.getLog(this.getClass());
	
	/**
	 * 保存T
	 */
	@Transactional
	@Override
	public int save(T entity) throws Exception {
		return this.baseDao.save(entity);
	}
    /**
     * 保存T
     */
    @Transactional
    @Override
    public int save(Object entity) throws Exception {
    	return this.baseDao.save(entity);
    }
    /**
     * 修改T
     */
    @Transactional
    @Override
    public int update(T entity) throws Exception {
    	return this.baseDao.update(entity);
    }
    /**
     * 修改T
     */
    @Transactional
    @Override
    public int update(Object entity) throws Exception {
    	return this.baseDao.update(entity);
    }
    /**
     * 保存或者修改T
     */
    @Transactional
    @Override
    public synchronized int saveOrUpdate(Object entity) throws Exception {
    	return this.baseDao.saveOrUpdate( entity);
    }
	/**
	 * 保存或者修改T
	 */
	@Transactional
	@Override
	public synchronized int saveOrUpdate(T entity) throws Exception {
		return this.baseDao.saveOrUpdate( entity);
	}

	/**
	 * 删除T
	 */
	@Transactional
	@Override
	public int remove(T entity) throws Exception {
		return this.baseDao.remove(entity);
	}
	/**
	 * 删除T
	 */
	@Transactional
	@Override
	public int remove(Object entity) throws Exception {
		return this.baseDao.remove(entity);
	}
	/**
	 * 删除T
	 */
	@Transactional
	@Override
	public int removeById(PK id) throws Exception {
		return this.baseDao.removeById(id);
	}

	/**
	 * 根据id得到T
	 */
	@Transactional(readOnly = true)
	@Override
	public T get(PK id) throws Exception {
		return this.baseDao.get(id);
	}
	/**
	 * 根据查询条件得到T
	 */
	@Transactional(readOnly = true)
	@Override
	public T get(Object findEntity) throws Exception {
		return this.baseDao.get(findEntity);
	}

	/**
	 * +
	 * 分页查询数据库记录总数
	 * @return int
	 */
	@Transactional(readOnly = true)
	@Override
	public int countAll()  throws Exception {
		return this.baseDao.countAll();
	}
	
	/**
	 * 分页查询装载数据
	 *
	 * @param pageNo 页码数
	 * @param pageSize   每页显示条数
	 * @return List
	 */
	@Transactional(readOnly = true)
	@Override
	public List<T> listAll(int pageNo, int pageSize) throws Exception {
		return this.baseDao.listAll(pageNo,pageSize);
	}
	/**
     * +
     * 分页查询数据库记录总数
     * @param findEntity 查询条件
     * @return int
     */
	@Transactional(readOnly = true)
	@Override
	public int count(Object findEntity) throws Exception {
		return this.baseDao.count(findEntity);
	}

	/**
     * 分页查询装载数据
     *
     * @param findEntity 查询条件
     * @param pageNo 页码数
     * @param pageSize   每页显示条数
     * @return List
     */
	@Transactional(readOnly = true)
	@Override
	public List<T> listAll(Object findEntity,int pageNo, int pageSize) throws Exception {
		return this.baseDao.listAll(findEntity,pageNo,pageSize);
	}
	/**
     * 分页装载数据
     * @param filter 查询条件
     * @param sort 排序方式
     * @param pageNo 页码
     * @param pageSize 每页显示条数
     * @return
     */
	@Transactional(readOnly = true)
	@Override
    public List<T> list(SqlFilter filter,SqlSort sort, int pageNo, int pageSize) throws Exception {
		return this.baseDao.listDynamic(new IbatisSqlFilter(filter, sort), pageNo, pageSize);
    }
    /**
     * 计算数据条数
     * @param filter 查询条件
     * @return
     */
    @Transactional(readOnly = true)
	@Override
    public int count(SqlFilter filter) throws Exception {
    	return this.baseDao.countDynamic(new IbatisSqlFilter(filter, null));
    }
	
}

