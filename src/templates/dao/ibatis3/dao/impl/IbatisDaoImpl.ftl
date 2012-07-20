package ${project.org}.security.dao.impl;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;

import org.joey.security.dao.BaseDao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by IntelliJ IDEA.
 * User: joeytang
 * Date: 2009-2-23
 * Time: 12:03:31
 * To change this template use File | Settings | File Templates.
 */
@SuppressWarnings("unchecked")
public abstract class IbatisDaoImpl<T extends Serializable,PK extends Serializable> extends IbatisDaoSurpport implements BaseDao<T,PK> {

	protected final Log logger = LogFactory.getLog(this.getClass());
	protected Class<T> entityClass;
    protected String className;
    
    
	@Autowired
	public void init(SqlSessionFactory sqlSessionFactory) {
		super.setSqlSessionFactory(sqlSessionFactory);
	}

	public IbatisDaoImpl() {
		this.entityClass = (Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        className = entityClass.getSimpleName();
	}
	
	 /**
     * 保存T
     */
    @Override
    public int save(Object entity) throws Exception {
    	if(entity != null){
    		return this.insert(className+".insert", entity);
    	}
    	return 0;
    }
    /**
     * 修改T
     */
    @Override
    public int update(Object entity) throws Exception {
    	if(entity != null){
    		return this.update(className+".update", entity);
    	}
    	return 0;
    }
	/**
	 * 保存或者修改T
	 */
	@Override
	public synchronized int saveOrUpdate(Object entity) throws Exception {
		T o = this.selectOne(className+".selectOneById", entity);
		if(o == null){
			return this.insert(className+".insert", entity);
		}else{
			return this.update(className+".update", entity);
		}
	}

	/**
	 * 删除T
	 */
	@Override
	public int remove(Object entity) throws Exception {
		if (null != entity) {
			return this.delete(className+".deleteByEntity", entity);
		}
		return 0;
	}
	/**
	 * 删除T
	 */
	@Override
	public int removeById(PK id) throws Exception {
		if (null != id) {
			return this.delete(className+".deleteById", id);
		}
		return 0;
	}

	/**
	 * 根据id得到T
	 */
	@Override
	public T get(PK id) throws Exception {
		return this.selectOne(className+".selectOneById", id);
	}
	/**
	 * 根据查询条件得到T
	 */
	@Override
	public T get(Object findEntity) throws Exception {
		return this.selectOne(className+".selectOneByEntity", findEntity);
	}

	/**
	 * +
	 * 分页查询数据库记录总数
	 * @return int
	 */
	@Override
	public int countAll() {
		return (Integer) this.selectOneObject(className+".countAllIds");
	}
	
	/**
	 * 分页查询装载数据
	 *
	 * @param pageNo 页码数
	 * @param pageSize   每页显示条数
	 * @return List
	 */
	@Override
	public List<T> listAll(int pageNo, int pageSize) {
		if(pageNo < 1 || pageSize < 0){
			return this.selectList(className+".listAll");
		}
		return this.selectList(className+".listAll",null,
				(pageNo - 1) * pageSize, pageSize);
		
	}
	/**
     * +
     * 分页查询数据库记录总数
     * @param findEntity 查询条件
     * @return int
     */
	@Override
	public int count(Object findEntity) {
		return (Integer) this.selectOneObject(className+".countIdsByEntity",findEntity);
	}

	/**
	 * 分页查询装载数据
	 *
	 * @param findEntity 查询条件
	 * @param pageNo 页码数
	 * @param pageSize   每页显示条数
	 * @return List
	 */
	@Override
	public List<T> listAll(Object findEntity,int pageNo, int pageSize) {
		if(pageNo < 1 || pageSize < 0){
			return this.selectList(className+".listByEntity",findEntity);
		}
		return this.selectList(className+".listByEntity",findEntity,
				(pageNo - 1) * pageSize, pageSize);
		
	}
	/**
	 * 分页查询装载数据,动态组装查询条件
	 *
	 * @param filter 查询条件
	 * @param pageNo 页码数
	 * @param pageSize   每页显示条数
	 * @return List
	 */
	@Override
	public List<T> listDynamic(IbatisSqlFilter filter,int pageNo, int pageSize) {
		if(pageNo < 1 || pageSize < 0){
			return this.selectList(className+".listDynamic",filter);
		}
		return this.selectList(className+".listDynamic",filter,
				(pageNo - 1) * pageSize, pageSize);
		
	}
	/**
     * 分页查询装载数据,动态组装查询条件
     *
     * @param filter 查询条件
     * @return int
     */
	@Override
	public int countDynamic(IbatisSqlFilter filter) {
			return (Integer)this.selectOneObject(className+".countDynamic",filter);
	}


	@Override
	public int delete(String statement, Object entity) {
		return getSqlSessionTemplate().delete(statement, entity);
	}
	@Override
	public int delete(String statement) {
		return getSqlSessionTemplate().delete(statement);
	}
	@Override
	public int insert(String statement, Object entity) {
		return getSqlSessionTemplate().insert(statement, entity);
	}
	@Override
	public int insert(String statement) {
		return getSqlSessionTemplate().insert(statement);
	}
	@Override
	public List<T> selectList(String statement, Object entity,
			final int offset,final int limit) {
		return getSqlSessionTemplate().selectList(statement, entity, offset, limit);
	}
	@Override
	public List<T> selectList(String statement, Object entity) {
		return getSqlSessionTemplate().selectList(statement, entity);
	}
	/**
	 * 根据entity条件查询数据，返回Object类型的列表，并进行分页
	 * @param statement
	 * @param entity
	 * @param offset 
	 * @param limit
	 * @return
	 */
	@Override
	public List<?> selectListObject(String statement, Object entity,final int offset,final int limit) {
		return getSqlSessionTemplate().selectList(statement, entity, offset, limit);
	}
	/**
	 * 根据entity条件查询数据，返回Object类型的列表，不进行分页
	 * @param statement
	 * @param entity
	 * @return
	 */
	@Override
	public List<?> selectListObject(String statement, Object entity) {
		return getSqlSessionTemplate().selectList(statement, entity);
	}
	/**
	 * 根据查询语句查询数据，返回Object类型的列表
	 * @param statement
	 * @return
	 */
	@Override
	public List<?> selectListObject(String statement) {
		return getSqlSessionTemplate().selectList(statement);
	}
	@Override
	public List<T> selectList(String statement) {
		return getSqlSessionTemplate().selectList(statement);
	}
	@Override
	public T selectOne(String statement, Object entity) {
		return (T)getSqlSessionTemplate().selectOne(statement, entity);
	}
	@Override
	public T selectOne(String statement) {
		return (T)getSqlSessionTemplate().selectOne(statement);
	}
	@Override
	public Object selectOneObject(String statement, Object entity) {
		
		return getSqlSessionTemplate().selectOne(statement, entity);
	}
	@Override
	public Object selectOneObject(String statement) {
		return getSqlSessionTemplate().selectOne(statement);
	}
	@Override
	public int update(String statement) {
		return getSqlSessionTemplate().update(statement);
	}
	@Override
	public int update(String statement, Object entity) {
		return getSqlSessionTemplate().update(statement,entity);
	}
}
