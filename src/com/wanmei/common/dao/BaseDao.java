package com.wanmei.common.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Collection;

import com.wanmei.common.dao.criteria.HqlInBean;
import com.wanmei.common.dao.SqlSort;
import com.wanmei.common.dao.SqlFilter;

/**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * 基本dao接口
 */
public interface BaseDao<T, PK extends Serializable> {
    /**
     * 修改或删除该对象
     *
     * @param entity 对象
     */
    public void saveOrUpdate(T entity);

    /**
     * 保存该对象 返回保存数据
     *
     * @param entity 对象
     * @return T
     */
    public T save(T entity);

    /**
     * 删除该对象
     *
     * @param entity 对象
     */
    public void remove(T entity);

    /**
     * 按主键删除数据
     *
     * @param id PK
     */
    public void remove(final PK id);

    /**
     * 按条件删除
     *
     * @param sql sql语句
     * @param obj 对象
     */
    public void remove(String sql, Object obj);

    /**
     * 按主键加载数据
     *
     * @param id 主键
     * @return T
     */
    public T get(final PK id);

    /**
     * 查询 该对象是否存在
     *
     * @param entity 对象
     * @return boolean
     */
    public boolean contains(T entity);

    /**
     * 批量删除数据
     *
     * @param entities 批量删除
     */
    public void deleteAll(Collection<T> entities);

    /**
     * 批量添加或更新
     *
     * @param entities 对象集合
     */
    public void saveOrUpdateAll(Collection<T> entities);

    /**
     * 加载所有数据
     *
     * @return List<T>
     */
    public List<T> list();

    /**
     * 自定义常用HQL语句
     *
     * @param queryName HQL
     * @return List<T>
     */
    public List<T> findByNamedQuery(String queryName);

    /**
     * 自定义常用HQL语句
     *
     * @param queryName HQL
     * @param value     参数
     * @return List<T>
     */
    public List<T> findByNamedQuery(String queryName, Object... value);

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
    public List<T> findByProperty(final String propertyName, final Object value, final int... rowStartIdxAndCount);

    /**
     * 根据属性查找唯一对象
     *
     * @param propertyName 属性名
     * @param value        属性值
     * @return 唯一对象.如果不存在符合条件的结果,返回Null,如果有多个对象符合条件,抛出异常.
     */
    public T findUniqueByProperty(final String propertyName, final Object value);

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
    public List<T> findAll(final int... rowStartIdxAndCount);

    /**
     * 查询相关数据
     *
     * @param queryString HQL
     * @return 对象集合
     */
    public List<T> findByOrder(final String queryString);
    
    /**
     * 直接使用查询语句查询
     *
     * @param queryString 查询HQL语句
     * @param values      任意数量的参数
     * @return List
     */
    public List<T> find(final String queryString, final Object... values);
    
    /**
     * 直接使用查询语句查询结果，返回的列表中对象不一定类型
     *
     * @param queryString 查询HQL语句
     * @param values      任意数量的参数
     * @return List
     */
    public List<?> findObject(final String queryString, final Object... values);

    /**
     * 按对象查询
     *
     * @param o 对象
     * @return List
     */
    public List<T> findByObject(Object o);

    /**
     * 返回唯一的对象
     *
     * @param queryString HQL
     * @param values      参数
     * @return Object
     */
    public Object findUnique(final String queryString, final Object... values);

    /**
     * 直接使用查询语句查询,带分页参数.
     *
     * @param queryString HQL语句
     * @param rowStartIdx 起始的记录,如不想设定，可设为-1.
     * @param rowCount    返回的记录数,如不想设定，可设为-1.
     * @param values      任意数量的参数.
     * @return List
     */
    public List<T> findPaged(final String queryString, final int rowStartIdx, final int rowCount, final Object... values);
   
    /**
     * 直接使用查询语句查询,带分页参数.
     *
     * @param queryString HQL语句
     * @param rowStartIdx 起始的记录,如不想设定，可设为-1.
     * @param rowCount    返回的记录数,如不想设定，可设为-1.
     * @param values      任意数量的参数.
     * @return List
     */
    public List<?> findObjectPaged(final String queryString, final int rowStartIdx, final int rowCount, final Object... values);


    /**
     * 查询返回的总数
     *
     * @param filter 条件
     * @return int
     */
    public int countByFilter(final SqlFilter filter);

    /**
     * 查询返回的结果
     *
     * @param filter   条件
     * @param sort     排序
     * @param rowStart 开始
     * @param rowEnd   结束
     * @return List
     */
    public List<T> listByFilter(final SqlFilter filter, final SqlSort sort, final int rowStart, final int rowEnd);
    /**
     * 查询返回的结果
     *
     * @param filter   条件
     * @param sort     排序
     * @param rowStart 开始
     * @param rowEnd   结束
     * @return List
     */
    public List<?> listObjectByFilter(final SqlFilter filter, final SqlSort sort, final int rowStart, final int rowEnd,final String... properties);
    /**
     * 查询返回的结果
     *
     * @param filter   条件
     * @param sort     排序
     * @return List
     */
    public List<T> listByFilter(final SqlFilter filter, final SqlSort sort);
     /**
     * 查询返回的结果
     *
     * @param filter   条件
     * @param sort     排序
     * @return List
     */
    public List<?> listObjectByFilter(final SqlFilter filter, final SqlSort sort,final String... properties);
    /**
	/**
	 * 执行一个sql
	 * @param sql
	 */
    public void executeSql(final String sql);
    /**
     * 将延迟加载的对象装载进来
     * @param o
     */
    public void initLazy(Object o) ;

    /**
     * 使用in语句的统计命令
     * @param hql hql语句 
     * @param inName hql中in语句中的变量名
     * @param inParams in语句中需要传入的变量
     * @param otherParams hql语句中其他的变量
     * @return
     */
	int countInCmd(String hql, String inName, Object[] inParams,
			Object... otherParams) ;

	/**
	 * 使用in语句的执行语句
	 * @param hql hql语句 
	 * @param inName hql中in语句中的变量名
	 * @param inParams in语句中需要传入的变量
	 * @param otherParams hql语句中其他的变量
	 * @return
	 */
	int executeInCmd(String hql, String inName, Object[] inParams,
			Object... otherParams) ;
	 /**
     * 使用in语句的查询语句
     * @param hql hql语句 
     * @param inName hql中in语句中的变量名
     * @param inParams in语句中需要传入的变量
     * @param otherParams hql语句中其他的变量
     * @return
     */
	List<T> findByInCmd(String hql, int offset, int num, String inName,
			Object[] inParams, Object... otherParams) ;

	/**
	 * 执行一段hql语句，用于批量删除/更新
	 * @param hql
	 * @param params hql中的参数
	 * return 返回执行的条数
	 * @
	 */
	int excuteHql(String hql, Object... params) ;
	/**
	 * 执行假删除，要求对象具有status属性。假删除是把status属性设置为-1
	 * @param id 需要删除的对象的id
	 * return 返回执行的行数
	 */
	int removeFake(PK id) ;

	/**
	 * 使用in语句的查询语句,当有多个in条件时使用
	 * @param cmd
	 * @param offset
	 * @param num
	 * @param inBeans
	 * @param otherParams
	 * @return
	 */
	List<T> findByInCmd(String cmd, int offset, int num, HqlInBean[] inBeans,
			Object... otherParams) ;
	 /**
     * 使用in语句的统计命令,当有多个in条件时使用
     * @param hql hql语句 
     * @param inName hql中in语句中的变量名
     * @param inParams in语句中需要传入的变量
     * @param otherParams hql语句中其他的变量
     * @return
     */
	int countInCmd(String cmd, HqlInBean[] inBeans,
			Object... otherParams) ;
	 /**
     * 使用in语句的执行语句,当有多个in条件时使用
     * @param hql hql语句 
     * @param inName hql中in语句中的变量名
     * @param inParams in语句中需要传入的变量
     * @param otherParams hql语句中其他的变量
     * @return
     */
	int executeInCmd(String hql, HqlInBean[] inBeans,
			Object... otherParams) ;
	/**
     * 根据特定的查询语句和参数统计记录条数
     * @param cmd
     * @param params
     * @return
     */
	int count(String cmd, Object... params) ;
}
