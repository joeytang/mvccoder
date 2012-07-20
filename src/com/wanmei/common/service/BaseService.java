package com.wanmei.common.service;

import java.io.Serializable;
import java.util.List;

import com.wanmei.common.dao.BaseDao;
import com.wanmei.common.dao.SqlFilter;
import com.wanmei.common.dao.SqlSort;

import org.springframework.transaction.annotation.Transactional;

/**
*
 * 处理业务逻辑
 * @author joeytang  
 * Date: 2012-03-20 18:17
*/
public interface BaseService<T extends Serializable, PK extends Serializable,D extends BaseDao<T,PK>> {
		
		/**
		 * 保存T
		 
		 * @return
		 * @
		 */
		@Transactional
		public T save(T entity)   ;
		
		/**
		 * 删除T
		 * @return
		 * @
		 */
	    @Transactional
		public void remove(T entity)  ;
		public void removeById(PK id)  ;
	    
	    /**
	     * 根据id得到T
	     * @return
	     * @
	     */
	    @Transactional(readOnly = true)
		public T get(PK id) ;
	    
	    /**
	     * 分页装载数据
	     * @param filter 查询条件
	     * @param sort 排序方式
	     * @param pageNo 页码
	     * @param pageSize 每页显示条数
	     * @return
	     */
	    public List<T> list(SqlFilter filter,SqlSort sort, int pageNo, int pageSize) ;
	    
	    /**
	     * 分页装载数据
	     * @param filter 查询条件
	     * @param sort 排序方式
	     * @param pageNo 页码
	     * @param pageSize 每页显示条数
	     * @param properties 需要显示的列对应属性名
	     * @return
	     */
	    public List<?> listObject(SqlFilter filter,SqlSort sort, int pageNo, int pageSize,final String... properties) ;
	    /**
	     * 计算数据条数
	     * @param filter 查询条件
	     * @param sort 排序方式
	     * @return
	     */
	    public int count(SqlFilter filter) ;
	    
}