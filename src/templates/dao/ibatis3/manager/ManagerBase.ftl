package ${project.org}.security.manager;

import java.io.Serializable;
import java.util.List;

import ${project.org}.security.dao.SqlFilter;
import ${project.org}.security.dao.SqlSort;

import org.springframework.transaction.annotation.Transactional;

/**
*
 * 处理业务逻辑
 * @author joeytang  
 * Date: ${project.currentTime}
*/
public interface BaseManager<T extends Serializable, PK extends Serializable> {
		
		/**
		 * 保存T
				 
		 * @return
		 * @throws Exception
		 */
		@Transactional
		public int save(Object entity) throws Exception  ;
		/**
		 * 保存T
			 
		 * @return
		 * @throws Exception
		 */
		@Transactional
		public int save(T entity) throws Exception  ;
		/**
		 * 修改T
			 
		 * @return
		 * @throws Exception
		 */
		@Transactional
		public int update(Object entity) throws Exception  ;
		/**
		 * 修改T
			 
		 * @return
		 * @throws Exception
		 */
		@Transactional
		public int update(T entity) throws Exception  ;
		/**
		 * 保存或修改T
		 
		 * @return
		 * @throws Exception
		 */
		@Transactional
		public int saveOrUpdate(T entity) throws Exception  ;
		/**
		 * 保存或修改T
		 
		 * @return
		 * @throws Exception
		 */
		@Transactional
		public int saveOrUpdate(Object entity) throws Exception  ;
		
		/**
		 * 删除T
		 * @return
		 * @throws Exception
		 */
		@Transactional
		public int remove(T entity) throws Exception ;
		/**
		 * 删除T
		 * @return
		 * @throws Exception
		 */
		@Transactional
		public int remove(Object entity) throws Exception ;
		/**
		 * 删除T
		 * @return
		 * @throws Exception
		 */
	    @Transactional
		public int removeById(PK id) throws Exception ;
	    
	    /**
	     * 根据id得到T
	     * @return
	     * @throws Exception
	     */
	    @Transactional(readOnly = true)
	    public T get(PK id) throws Exception;
	    /**
	     * 根据id得到T
	     * @return
	     * @throws Exception
	     */
	    @Transactional(readOnly = true)
		public T get(Object findEntity) throws Exception;
	    
	    /**
	     * +
	     * 分页查询数据库记录总数
	     * @return int
	     */
	    @Transactional(readOnly = true)
	    public int countAll() throws Exception ;

	    /**
	     * 分页查询装载数据
	     *
	     * @param pageNo 页码数
	     * @param pageSize   每页显示条数
	     * @return List
	     */
	    @Transactional(readOnly = true)
	    public List<T> listAll(int pageNo, int pageSize) throws Exception ;
	    
	    /**
	     * +
	     * 分页查询数据库记录总数
	     * @param findEntity 查询条件
	     * @return int
	     */
	    @Transactional(readOnly = true)
	    public int count(Object findEntity) throws Exception ;
	    /**
	     * 分页查询装载数据
	     *
	     * @param findEntity 查询条件
	     * @param pageNo 页码数
	     * @param pageSize   每页显示条数
	     * @return List
	     */
	    @Transactional(readOnly = true)
	    public List<T> listAll(Object findEntity,int pageNo, int pageSize) throws Exception ;
		/**
	     * 分页装载数据
	     * @param filter 查询条件
	     * @param sort 排序方式
	     * @param pageNo 页码
	     * @param pageSize 每页显示条数
	     * @return
	     */
	    public List<T> list(SqlFilter filter,SqlSort sort, int pageNo, int pageSize) throws Exception ;
	    /**
	     * 计算数据条数
	     * @param filter 查询条件
	     * @param sort 排序方式
	     * @return
	     */
	    public int count(SqlFilter filter) throws Exception ;
}