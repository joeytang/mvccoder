package com.wanmei.common.service.impl;

import java.util.List;
import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.wanmei.common.service.BaseService;
import com.wanmei.common.dao.BaseDao;
import com.wanmei.common.dao.SqlFilter;
import com.wanmei.common.dao.SqlSort;

/**
 * 处理业务逻辑
 * @author joeytang  
 * Date: 2012-03-20 18:17
 */
public class BaseServiceImpl<T extends Serializable, PK extends Serializable,D extends BaseDao<T,PK>> implements BaseService<T, PK,D> {

	protected D baseDao;
	@Autowired
	protected void setBaseDao(D baseDao){
		this.baseDao = baseDao;
	}

	/**
	 * 保存T
	 */
	@Transactional
	@Override
	public T save(T entity)  {
		entity = this.baseDao.save(entity);
		return entity;
	}

	/**
	 * 删除T
	 */
	@Transactional
	@Override
	public void remove(T entity)  {
		if (null != entity) {
			this.baseDao.remove(entity);
		}
	}
	/**
	 * 删除T
	 */
	@Transactional
	@Override
	public void removeById(PK id)  {
		if (null != id) {
			this.baseDao.remove(id);
		}
	}

	/**
	 * 根据id得到T
	 */
	@Transactional(readOnly = true)
	@Override
	public T get(PK id)  {
		return this.baseDao.get(id);
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
	public List<T> list(SqlFilter filter,SqlSort sort, int pageNo, int pageSize) {
		return this.baseDao.listByFilter(filter, sort,
				(pageNo - 1) * pageSize, pageSize);
	}
	 /**
     * 分页装载数据
     * @param filter 查询条件
     * @param sort 排序方式
     * @param pageNo 页码
     * @param pageSize 每页显示条数
     * @param properties 需要显示的列对应属性名
     * @return
     */
	@Transactional(readOnly = true)
	@Override
    public List<?> listObject(SqlFilter filter,SqlSort sort, int pageNo, int pageSize,final String... properties) {
		return this.baseDao.listObjectByFilter(filter, sort,
				(pageNo - 1) * pageSize, pageSize,properties);
    }
    /**
     * 计算数据条数
     * @param filter 查询条件
     * @return
     */
    @Transactional(readOnly = true)
	@Override
    public int count(SqlFilter filter) {
    	return this.baseDao.countByFilter(filter);
    }
}

