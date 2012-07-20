package ${project.org}.security.dao;

import java.io.Serializable;
import java.util.List;

import ${project.org}.security.dao.impl.IbatisSqlFilter;
/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 基本dao接口
 */
public interface BaseDao<T extends Serializable, PK extends Serializable> {
	/**
	 * 保存T
		 
	 * @return
	 * @throws Exception
	 */
	public int save(Object entity) throws Exception  ;
	/**
	 * 修改T
		 
	 * @return
	 * @throws Exception
	 */
	public int update(Object entity) throws Exception  ;
	/**
	 * 保存或修改T
	 
	 * @return
	 * @throws Exception
	 */
	public int saveOrUpdate(Object entity) throws Exception  ;
	
	/**
	 * 删除T
	 * @return
	 * @throws Exception
	 */
	public int remove(Object entity) throws Exception ;
	/**
	 * 删除T
	 * @return
	 * @throws Exception
	 */
	public int removeById(PK id) throws Exception ;
    
    /**
     * 根据id得到T
     * @return
     * @throws Exception
     */
    public T get(PK id) throws Exception;
    /**
     * 根据id得到T
     * @return
     * @throws Exception
     */
	public T get(Object findEntity) throws Exception;
    
    /**
     * +
     * 分页查询数据库记录总数
     * @return int
     */
    public int countAll() throws Exception ;

    /**
     * 分页查询装载数据
     *
     * @param pageNo 页码数
     * @param pageSize   每页显示条数
     * @return List
     */
    public List<T> listAll(int pageNo, int pageSize) throws Exception ;
    
    /**
     * +
     * 分页查询数据库记录总数
     * @param findEntity 查询条件
     * @return int
     */
	public int count(Object findEntity) throws Exception ;
	/**
     * 分页查询装载数据
     *
     * @param findEntity 查询条件
     * @param pageNo 页码数
     * @param pageSize   每页显示条数
     * @return List
     */
	public List<T> listAll(Object findEntity,int pageNo, int pageSize) throws Exception ;
	/**
	 * 分页查询装载数据,动态组装查询条件
	 *
	 * @param filter 查询条件
	 * @param pageNo 页码数
	 * @param pageSize   每页显示条数
	 * @return List
	 */
	public List<T> listDynamic(IbatisSqlFilter filter,int pageNo, int pageSize);
	/**
     * 分页查询装载数据,动态组装查询条件
     *
     * @param filter 查询条件
     * @return int
     */
	public int countDynamic(IbatisSqlFilter filter);
	
	
	//以下是自定义iBATIS  statement的方法
	
	public int delete(String statement, Object entity)  throws Exception ;
	
	public int delete(String statement)  throws Exception ;
	
	public int insert(String statement, Object entity)  throws Exception ;
	public int insert(String statement)  throws Exception ;
	
	public List<T> selectList(String statement, Object entity,
			final int offset,final int limit)  throws Exception ;
	
	public List<T> selectList(String statement, Object entity)  throws Exception ;
	/**
	 * 根据entity条件查询数据，返回Object类型的列表，并进行分页
	 * @param statement
	 * @param entity
	 * @param offset 
	 * @param limit
	 * @return
	 */
	
	public List<?> selectListObject(String statement, Object entity,final int offset,final int limit)  throws Exception ;
	/**
	 * 根据entity条件查询数据，返回Object类型的列表，不进行分页
	 * @param statement
	 * @param entity
	 * @return
	 */
	
	public List<?> selectListObject(String statement, Object entity)  throws Exception ;
	/**
	 * 根据查询语句查询数据，返回Object类型的列表
	 * @param statement
	 * @return
	 */
	
	public List<?> selectListObject(String statement)  throws Exception ;
	
	public List<T> selectList(String statement)  throws Exception ;
	
	public T selectOne(String statement, Object entity) throws Exception ;
	
	public T selectOne(String statement)  throws Exception ;
	
	public Object selectOneObject(String statement, Object entity)  throws Exception ;
	
	public Object selectOneObject(String statement)  throws Exception ;
	public int update(String statement)  throws Exception ;
	public int update(String statement, Object entity)  throws Exception ;
}
