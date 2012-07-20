package com.wanmei.common.dao.impl;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.util.Assert;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.hibernate.Session;
import org.hibernate.HibernateException;
import org.hibernate.Criteria;
import org.hibernate.Transaction;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.text.MessageFormat;
import java.util.List;
import java.util.Collection;
import java.sql.SQLException;

import com.wanmei.common.dao.BaseDao;
import com.wanmei.common.dao.criteria.HqlInBean;
import com.wanmei.common.dao.SqlSort;
import com.wanmei.common.dao.SqlFilter;
import com.wanmei.common.dao.criteria.SqlSortAdapter;
import com.wanmei.common.dao.criteria.SqlFilterAdapter;

/**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * hibernate对基本dao的实现
 */
@SuppressWarnings("unchecked")
public class BaseDaoImpl<T, PK extends Serializable> extends HibernateDaoSupport implements BaseDao<T,PK> {

    protected final Log logger = LogFactory.getLog(this.getClass());
    protected final Class<T> entityClass;
    protected String className;
    protected boolean useSecondCache = true;

    @Autowired
    public void init(SessionFactory sessionFactory) {
        super.setSessionFactory(sessionFactory);
        super.getHibernateTemplate().setCacheQueries(useSecondCache);
    }

    public BaseDaoImpl() {
        this.entityClass = (Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        className = entityClass.getSimpleName();
    }


    /**
     * 修改或删除该对象
     *
     * @param entity 对象
     */
    @Override
    public void saveOrUpdate(T entity) {
        Assert.notNull(entity);
        if (logger.isDebugEnabled()) {
            logger.debug(MessageFormat.format("updating {0} instance", className));
        }
        super.getHibernateTemplate().saveOrUpdate(entity);

    }

    /**
     * 保存该对象 返回保存数据
     *
     * @param entity 对象
     * @return T
     */
    @Override
    public T save(T entity) {
        Assert.notNull(entity);
        if (logger.isDebugEnabled()) {
            logger.debug(MessageFormat.format("updating {0} instance", className));
        }
        T result = (T) super.getHibernateTemplate().merge(entity);
        if (logger.isDebugEnabled()) {
            logger.debug("update successful");
        }
        return result;
    }

    /**
     * 删除该对象
     *
     * @param entity 对象
     */
    @Override
    public void remove(T entity) {
        Assert.notNull(entity);
        if (logger.isDebugEnabled()) {
            logger.debug(MessageFormat.format("deleting {0} instance", className));
        }
        super.getHibernateTemplate().delete(entity);
        if (logger.isDebugEnabled()) {
            logger.info("remove successful");
        }
    }

    /**
     * 按主键删除数据
     *
     * @param id PK
     */
    @Override
    public void remove(final PK id){
    	Assert.notNull(id);
    	if (logger.isDebugEnabled()) {
    		logger.debug(MessageFormat.format("deleting {0} instance", className));
    	}
    	super.getHibernateTemplate().delete((this.get(id)));
    	if (logger.isDebugEnabled()) {
    		logger.debug("remove successful");
    	}
    }
    /**
     * 按主键删除数据
     *
     * @param id PK
     */
    @Override
    public int removeFake(final PK id){
        Assert.notNull(id);
        if (logger.isDebugEnabled()) {
            logger.debug(MessageFormat.format("removeFake {0} instance", className));
        }
        if (logger.isDebugEnabled()) {
            logger.debug("remove successful");
        }
        try {
			return this.excuteHql(MessageFormat.format("update from {0} set status = -1 where id= ? ", this.entityClass.getName()),id);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
    }

    /**
     * 按条件删除
     *
     * @param sql sql语句
     * @param obj 对象
     */
    @Override
    public void remove(String sql, Object obj){
        Assert.notNull(obj);
        Assert.notNull(sql);
        if (logger.isDebugEnabled()) {
            logger.debug(MessageFormat.format("deleting {0} instance", className));
        }
        super.getHibernateTemplate().delete(sql, obj);
        if (logger.isDebugEnabled()) {
            logger.debug("remove successful");
        }
    }

    /**
     * 按主键加载数据
     *
     * @param id 主键
     * @return T
     */
    @Override
    public T get(final PK id){
        Assert.notNull(id);
        if (logger.isDebugEnabled()) {
            logger.debug(MessageFormat.format("finding {0} instance with id: {1}", className, id));
        }
        return (T) super.getHibernateTemplate().get(this.entityClass, id);

    }

    /**
     * 查询 该对象是否存在
     *
     * @param entity 对象
     * @return boolean
     */
    @Override
    public boolean contains(T entity){
        Assert.notNull(entity);
        if (logger.isDebugEnabled()) {
            logger.debug(MessageFormat.format("contains {0} instance", className));
        }
        return super.getHibernateTemplate().contains(entity);
    }

    /**
     * 批量删除数据
     *
     * @param entities 批量删除
     */
    @Override
    public void deleteAll(Collection<T> entities){
        Assert.notNull(entities);
        if (logger.isDebugEnabled()) {
            logger.debug(MessageFormat.format("deleteAll {0} instance", className));
        }
        super.getHibernateTemplate().deleteAll(entities);
        if (logger.isDebugEnabled()) {
            logger.debug("deleteAll successful");
        }

    }

    /**
     * 批量添加或更新
     *
     * @param entities 对象集合
     */
    @Override
    public void saveOrUpdateAll(Collection<T> entities){
        Assert.notNull(entities);
        if (logger.isDebugEnabled()) {
            logger.debug(MessageFormat.format("saveOrUpdateAll {0} instance", className));
        }
        super.getHibernateTemplate().saveOrUpdateAll(entities);
        if (logger.isDebugEnabled()) {
            logger.debug("saveOrUpdateAll successful");
        }
    }

    /**
     * 加载所有数据
     *
     * @return List<T>
     */
    @Override
    public List<T> list(){
        return super.getHibernateTemplate().loadAll(getEntityClass());
    }

    /**
     * 自定义常用HQL语句
     *
     * @param queryName HQL
     * @return List<T>
     */
    public List<T> findByNamedQuery(String queryName){
        return super.getHibernateTemplate().findByNamedQuery(queryName);
    }

    /**
     * 自定义常用HQL语句
     *
     * @param queryName HQL
     * @param value     参数
     * @return List<T>
     */
    @Override
    public List<T> findByNamedQuery(String queryName, Object... value){
        return super.getHibernateTemplate().findByNamedQuery(queryName, value);
    }

    /**
     * 根据属性查找对象.
     *
     * @param propertyName        属性名
     * @param value               属性值
     * @param rowStartIdxAndCount 可选的分页参数.第一个参数为起始的记录,第二个参数为返回的对象数量.
     *                            eg.
     *                            <code>
     *                            findByProperty("country","china");      //查找属性值country为china的对象，返回所有对象.
     *                            findByProperty("country","china",0,10); //查找属性值country为china的对象，返回第1-10个符合的对象.
     *                            </code>
     * @return List<T>
     */
    @Override
    public List<T> findByProperty(final String propertyName, final Object value, final int... rowStartIdxAndCount){
        Assert.hasLength(propertyName);
        if (logger.isDebugEnabled()) {
            logger.debug(MessageFormat.format("finding {0} instance with property: {1} , value: {2}", className, propertyName, value));
        }
        final String queryString = MessageFormat.format("from {0} model where model.{1}= ?", className, propertyName);
        int rowStartIdx = 0;
        int rowCount = 0;
        if (rowStartIdxAndCount != null && rowStartIdxAndCount.length > 0) {
            rowStartIdx = Math.max(0, rowStartIdxAndCount[0]);
            if (rowStartIdxAndCount.length > 1) {
                rowCount = Math.max(0, rowStartIdxAndCount[1]);
            }
        }
        return findPaged(queryString, rowStartIdx, rowCount, value);

    }

    /**
     * 根据属性查找唯一对象
     *
     * @param propertyName 属性名
     * @param value        属性值
     * @return 唯一对象.如果不存在符合条件的结果,返回Null,如果有多个对象符合条件,抛出异常.
     */
    @Override
    public T findUniqueByProperty(final String propertyName, final Object value){
        return uniqueOfList(findByProperty(propertyName, value));
    }

    /**
     * 获取全部对象.
     *
     * @param rowStartIdxAndCount 可选的分页参数.第一个参数为起始的记录,第二个参数为返回的对象数量
     *                            eg.
     *                            <code>
     *                            findAll();     //返回所有对象
     *                            findAll(0,10); //返回第1-10个对象
     *                            </code>
     * @return List<T>
     */
    @Override
    public List<T> findAll(final int... rowStartIdxAndCount){
        if (logger.isDebugEnabled()) {
            logger.debug(MessageFormat.format("finding all {0} instances", className));
        }
        final String queryString = MessageFormat.format("from {0} model", className);
        int rowStartIdx = 0;
        int rowCount = 0;
        if (rowStartIdxAndCount != null && rowStartIdxAndCount.length > 0) {
            rowStartIdx = Math.max(0, rowStartIdxAndCount[0]);
            if (rowStartIdxAndCount.length > 1) {
                rowCount = Math.max(0, rowStartIdxAndCount[1]);
            }
        }
        return findPaged(queryString, rowStartIdx, rowCount);
    }

    /**
     * 查询相关数据
     *
     * @param queryString HQL
     * @return 对象集合
     */
    @Override
    public List<T> findByOrder(final String queryString){
        Assert.hasLength(queryString);
        return super.getHibernateTemplate().find(queryString);
    }
    
    /**
     * 直接使用查询语句查询
     *
     * @param queryString 查询HQL语句
     * @param values      任意数量的参数
     * @return List
     */
    @Override
    public List<T> find(final String queryString, final Object... values){
    	Assert.hasLength(queryString);
    	return super.getHibernateTemplate().find(queryString, values);
    }

    /**
     * 直接使用查询语句查询结果，返回的列表中对象不一定类型
     *
     * @param queryString 查询HQL语句
     * @param values      任意数量的参数
     * @return List
     */
    @Override
    public List<?> findObject(final String queryString, final Object... values){
        Assert.hasLength(queryString);
        return super.getHibernateTemplate().find(queryString, values);
    }

    /**
     * 按对象查询
     *
     * @param o 对象
     * @return List
     */
    @Override
    public List<T> findByObject(Object o){
        Assert.isNull(o);
        return super.getHibernateTemplate().findByExample(o);
    }

    /**
     * 返回唯一的对象
     *
     * @param queryString HQL
     * @param values      参数
     * @return Object
     */
    @Override
    public Object findUnique(final String queryString, final Object... values){
        Assert.hasLength(queryString);
        return uniqueOfList(super.getHibernateTemplate().find(queryString, values));
    }

    /**
     * 直接使用查询语句查询,带分页参数.
     *
     * @param queryString HQL语句
     * @param rowStartIdx 起始的记录,如不想设定，可设为-1.
     * @param rowCount    返回的记录数,如不想设定，可设为-1.
     * @param values      任意数量的参数.
     * @return List
     */
    @SuppressWarnings("rawtypes")
	@Override
    public List<T> findPaged(final String queryString, final int rowStartIdx, final int rowCount, final Object... values){
        return super.getHibernateTemplate().executeFind(new HibernateCallback() {
            public Object doInHibernate(Session session) throws HibernateException, SQLException {
                org.hibernate.Query query = session.createQuery(queryString);
                if(useSecondCache){
                	query.setCacheable(true);
                }
                if (null != values) {
                    for (int i = 0; i < values.length; i++) {
                        query.setParameter(i, values[i]);
                    }
                }
                if(rowStartIdx > -1 && rowCount > 0){
                    query.setFirstResult(rowStartIdx);
                    query.setMaxResults(rowCount);
                }
                return query.list();
            }
        });
    }
    /**
     * 根据特定的查询语句和参数统计记录条数
     * @param cmd
     * @param params
     * @return
     */
    @SuppressWarnings("rawtypes")
	@Override
	public int count( final String cmd, final Object...params  ) {
    	return (Integer)super.getHibernateTemplate().execute(new HibernateCallback() {
    		public Object doInHibernate(Session session) throws HibernateException, SQLException {
    			org.hibernate.Query query = session.createQuery(cmd);
    			if(useSecondCache){
    				query.setCacheable(true);
    			}
    			if (null != params) {
    				for (int i = 0; i < params.length; i++) {
    					query.setParameter(i, params[i]);
    				}
    			}
    			Long c = (Long) query.uniqueResult();
    			return c == null?0:c.intValue();
    		}
    	});
    }
    
    /**
     * 直接使用查询语句查询,带分页参数.
     *
     * @param queryString HQL语句
     * @param rowStartIdx 起始的记录,如不想设定，可设为-1.
     * @param rowCount    返回的记录数,如不想设定，可设为-1.
     * @param values      任意数量的参数.
     * @return List
     */
    @SuppressWarnings("rawtypes")
	@Override
    public List<?> findObjectPaged(final String queryString, final int rowStartIdx, final int rowCount, final Object... values){
    	return super.getHibernateTemplate().executeFind(new HibernateCallback() {
    		public Object doInHibernate(Session session) throws HibernateException, SQLException {
    			org.hibernate.Query query = session.createQuery(queryString);
    			if(useSecondCache){
    				query.setCacheable(true);
    			}
    			if (null != values) {
    				for (int i = 0; i < values.length; i++) {
    					query.setParameter(i, values[i]);
    				}
    			}
    			if (rowStartIdx > -1 && rowCount > 0) {
    				query.setFirstResult(rowStartIdx);
    				query.setMaxResults(rowCount);
    			}
    			return query.list();
    		}
    	});
    }


    /**
     * 取得entity的class.
     *
     * @return Class<T>
     */
    public Class<T> getEntityClass() {
        return entityClass;
    }

    /**
     * 取出列表的第一个对象.
     * 如果列表为空返回Null,如果有多于一个对象,抛出异常.
     *
     * @param list 对象的集合
     * @param <E>  对象
     * @return 如果列表为空返回Null,如果有多于一个对象,抛出异常.
     */
    private static <E> E uniqueOfList(List<E> list){
        if (list == null || list.isEmpty()) {
            return null;
        }
        return list.get(0);
    }

    /**
     * 查询返回的总数
     *
     * @param filter 条件
     * @return int
     */
    @SuppressWarnings("rawtypes")
	@Override
    public int countByFilter(final SqlFilter filter){
        Integer count = (Integer) getHibernateTemplate().execute(new HibernateCallback() {
            public Object doInHibernate(Session session)
                    throws HibernateException, SQLException {
                Criteria criteria = session.createCriteria(entityClass);
                if(useSecondCache){
                	criteria.setCacheable(true);
                }
                 if(null != filter){
                	criteria = SqlFilterAdapter.createFilter(filter).execute(criteria);
                }
                criteria.setProjection(Projections.rowCount());
                return criteria.uniqueResult();
            }
        });
        return count == null?0:count.intValue();
    }

    /**
     * 查询返回的结果
     *
     * @param filter   条件
     * @param sort     排序
     * @param rowStart 开始
     * @param rowEnd   结束
     * @return List
     */
    @SuppressWarnings("rawtypes")
    @Override
    public List<T> listByFilter(final SqlFilter filter, final SqlSort sort, final int rowStart, final int num){
    	List<T> applications = (List<T>) getHibernateTemplate().execute(new HibernateCallback() {
    		public Object doInHibernate(Session session)
    				throws HibernateException, SQLException {
    			Criteria criteria = session.createCriteria(entityClass);
    			if(useSecondCache){
    				criteria.setCacheable(true);
    			}
    			if(null != filter){
    				criteria = SqlFilterAdapter.createFilter(filter).execute(criteria);
    			}
    			if(null != sort){
    				criteria = SqlSortAdapter.createSort(sort).execute(criteria);
    			}
    			if(rowStart > -1 && num > 0){
    				criteria.setFirstResult(rowStart);
    				criteria.setMaxResults(num);
    			}
    			return criteria.list();
    		}
    	});
    	return applications;
    }
    /**
     * 查询返回的结果
     *
     * @param filter   条件
     * @param sort     排序
     * @param rowStart 开始
     * @param rowEnd   结束
     * @param properties 需要显示的列对应属性名
     * @return List
     */
    @SuppressWarnings("rawtypes")
	@Override
    public List<?> listObjectByFilter(final SqlFilter filter, final SqlSort sort, final int rowStart, final int num,final String... properties){
        List<?> applications = (List<T>) getHibernateTemplate().execute(new HibernateCallback() {
            public Object doInHibernate(Session session)
                    throws HibernateException, SQLException {
                Criteria criteria = session.createCriteria(entityClass);
                if(useSecondCache){
                	criteria.setCacheable(true);
                }
                if(null != filter){
                	criteria = SqlFilterAdapter.createFilter(filter).execute(criteria);
                }
                if(null != sort){
                	criteria = SqlSortAdapter.createSort(sort).execute(criteria);
                }
                if(rowStart > -1 && num > 0){
                	criteria.setFirstResult(rowStart);
                	criteria.setMaxResults(num);
                }
                if(null != properties && properties.length > 0){
                	ProjectionList projectionList = Projections.projectionList();
                	for(String p:properties){
                		projectionList.add(Projections.property(p));
                	}
                	criteria.setProjection(projectionList);
                }
                return criteria.list();
            }
        });
        return applications;
    }

    /**
     * 查询返回的结果
     *
     * @param filter   条件
     * @param sort     排序
     * @return List
     */
    @SuppressWarnings("rawtypes")
    @Override
    public List<T> listByFilter(final SqlFilter filter, final SqlSort sort){
    	List<T> applications = (List<T>) getHibernateTemplate().execute(new HibernateCallback() {
    		public Object doInHibernate(Session session)
    				throws HibernateException, SQLException {
    			Criteria criteria = session.createCriteria(entityClass);
    			if(useSecondCache){
    				criteria.setCacheable(true);
    			}
    			if(null != filter){
    				criteria = SqlFilterAdapter.createFilter(filter).execute(criteria);
    			}
    			if(null != sort){
    				criteria = SqlSortAdapter.createSort(sort).execute(criteria);
    			}
    			return criteria.list();
    		}
    	});
    	return applications;
    }
     /**
     * 查询返回的结果
     *
     * @param filter   条件
     * @param sort     排序
     * @return List
     */
    @SuppressWarnings("rawtypes")
	@Override
    public List<?> listObjectByFilter(final SqlFilter filter, final SqlSort sort,final String... properties){
        List<?> applications = (List<T>) getHibernateTemplate().execute(new HibernateCallback() {
            public Object doInHibernate(Session session)
                    throws HibernateException, SQLException {
                Criteria criteria = session.createCriteria(entityClass);
                if(useSecondCache){
                	criteria.setCacheable(true);
                }
                 if(null != filter){
                	criteria = SqlFilterAdapter.createFilter(filter).execute(criteria);
                }
                if(null != sort){
                	criteria = SqlSortAdapter.createSort(sort).execute(criteria);
                }
                if(null != properties && properties.length > 0){
                	ProjectionList projectionList = Projections.projectionList();
                	for(String p:properties){
                		projectionList.add(Projections.property(p));
                	}
                	criteria.setProjection(projectionList);
                }
                return criteria.list();
            }
        });
        return applications;
    }
    
    @SuppressWarnings("rawtypes")
	@Override
    public int excuteHql(final String hql,final Object... params) {
    	return (Integer)this.getHibernateTemplate().execute(new HibernateCallback() {
            public Object doInHibernate(Session session) throws HibernateException, SQLException {
            	Query query = session.createQuery(hql);
                if(useSecondCache){
                	query.setCacheable(true);
                }
                int i = 0;
    			for (Object obj : params) {
    				query.setParameter(i, obj);
    				i++;
    			}
                int result = query.executeUpdate();
                return result;
            }
        });
    }
    
    @SuppressWarnings("rawtypes")
	@Override
    public List<T> findByInCmd(final String cmd,final int offset,final int num,final HqlInBean[] inBeans, final Object... otherParams)  {
    	return (List<T>) this.getHibernateTemplate().execute(new HibernateCallback() {
    		public Object doInHibernate(Session session) throws HibernateException, SQLException {
    			Query query = session.createQuery(cmd);
    			if (offset > 0 && num > 0){
    				query.setFirstResult(offset);
    				query.setMaxResults(num);
    			}
    			int i = 0;
    			if(null != inBeans ){
    				for(HqlInBean inBean : inBeans){
    					query.setParameterList(inBean.getInName(), inBean.getInParam());
    				}
    			}
    			for (Object obj : otherParams) {
    				query.setParameter(i, obj);
    				i++;
    			}
    			return query.list();
    		}
    	});
    }
	@SuppressWarnings("rawtypes")
	@Override
	public List<T> findByInCmd(final String cmd,final int offset,final int num,final String inName,
			final Object[] inParams, final Object... otherParams)  {
    	return (List<T>) this.getHibernateTemplate().execute(new HibernateCallback() {
            public Object doInHibernate(Session session) throws HibernateException, SQLException {
            	Query query = session.createQuery(cmd);
            	if (offset > 0 && num > 0){
    				query.setFirstResult(offset);
    				query.setMaxResults(num);
    			}
    			int i = 0;
    			query.setParameterList(inName, inParams);
    			for (Object obj : otherParams) {
    				query.setParameter(i, obj);
    				i++;
    			}
    			return query.list();
            }
        });
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public  int executeInCmd(final String cmd, final String inName, final Object[] inParams, final Object...otherParams) 
	{
		return (Integer) this.getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createQuery(cmd);
				int i = 0;
				query.setParameterList(inName, inParams);
				for (Object obj : otherParams) {
					query.setParameter(i, obj);
					i++;
				}
				return query.executeUpdate();
			}
		});
	}
	@SuppressWarnings("rawtypes")
	@Override
    public  int executeInCmd(final String cmd,final HqlInBean[] inBeans, final Object...otherParams) 
    {
    	return (Integer) this.getHibernateTemplate().execute(new HibernateCallback() {
            public Object doInHibernate(Session session) throws HibernateException, SQLException {
            	Query query = session.createQuery(cmd);
    			int i = 0;
    			if(null != inBeans ){
    				for(HqlInBean inBean : inBeans){
    					query.setParameterList(inBean.getInName(), inBean.getInParam());
    				}
    			}
    			for (Object obj : otherParams) {
    				query.setParameter(i, obj);
    				i++;
    			}
    			return query.executeUpdate();
            }
        });
    }
	
	@SuppressWarnings("rawtypes")
	@Override
	public int countInCmd(final String cmd, final String inName,
			final Object[] inParams, final Object... otherParams)  {
		return (Integer) this.getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createQuery(cmd);
				int i = 0;
				query.setParameterList(inName, inParams);
				for (Object obj : otherParams) {
					query.setParameter(i, obj);
					i++;
				}
				Long count =  (Long)query.list().get(0);
				return count == null?0:count.intValue();
			}
		});
	}
	@SuppressWarnings("rawtypes")
	@Override
	public int countInCmd(final String cmd,final HqlInBean[] inBeans, final Object... otherParams)  {
    	return (Integer) this.getHibernateTemplate().execute(new HibernateCallback() {
            public Object doInHibernate(Session session) throws HibernateException, SQLException {
            	Query query = session.createQuery(cmd);
    			int i = 0;
    			if(null != inBeans ){
    				for(HqlInBean inBean : inBeans){
    					query.setParameterList(inBean.getInName(), inBean.getInParam());
    				}
    			}
    			for (Object obj : otherParams) {
    				query.setParameter(i, obj);
    				i++;
    			}
    			Long count =  (Long)query.list().get(0);
    			return count == null?0:count.intValue();
            }
        });
	}
    
    /**
	/**
	 * 执行一个sql
	 * @param sql
	 */
    @SuppressWarnings("rawtypes")
	@Override
	  public void executeSql(final String sql)  {
	        this.getHibernateTemplate().execute(new HibernateCallback() {
	            public Object doInHibernate(Session session) throws HibernateException, SQLException {
	                SQLQuery sqlQuery = session.createSQLQuery(sql);
	                if(useSecondCache){
	                	sqlQuery.setCacheable(true);
	                }
	                int result = sqlQuery.executeUpdate();
	                return result;
	            }
	        });
	        
	    }
	  
	  /**
	   * 自定义事务执行：获得一个session连接，并开始事务
	   * 如果当前线程找不到session则新建一个session
	   */
	  public void beginSession(){
		  beginSession(true);
	  }
	  /**
	   * 自定义事务执行：获得一个session连接，并开始事务
	   * @param allowNew 如果当前线程找不到session是否允许新建一个session
	   */
	  public void beginSession(boolean allowNew){
		  Session session = this.getSession(allowNew);
		  if(session == null){
			  throw new DataAccessResourceFailureException("Could not open Hibernate Session");
		  }
		  logger.info("get a new session");
		  Transaction t = session.beginTransaction();
		  t.begin();
		  logger.info("begin Transaction"+t);
	  }
	  /**
	   * 自定义事务执行：获得当前线程上的session连接，并结束该session的事务，关闭该session
	   */
	  public void endSession(){
		  Session session = this.getSession();
		  if(session == null){
			  throw new DataAccessResourceFailureException("Could not open Current Session");
		  }
		  logger.info("get current session");
		  Transaction t = session.beginTransaction();
		   if(null != t){
			   t.commit();
			   logger.info("commit Transaction"+t);
		   }
		   session.close();
	       logger.info("close session");
	  }
	  public void initLazy(Object o) {
		  Hibernate.initialize(o);
	  }
	  public Criteria customCriteria(T t){
		  Session session = this.getSession(true);
		  Criteria criteria = session.createCriteria(entityClass);
          if(useSecondCache){
          	criteria.setCacheable(true);
          }
          return criteria;
	  }
}
