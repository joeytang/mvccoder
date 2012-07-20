package ${project.org}.security.dao.impl;

import java.util.HashMap;
import java.util.Map;

import ${project.org}.security.dao.SqlFilter;
import ${project.org}.security.dao.SqlSort;
import ${project.org}.util.BeanHelper;

/**
 * Created by IntelliJ IDEA.
 * User: joeytang
 * Date: 2009-2-27
 * Time: 13:54:27
 * 过滤接口
 */
public class IbatisSqlFilter {
	
	private SqlFilter filter;
	private SqlSort sort;
	private Map<String,Object> bean;
	
	public IbatisSqlFilter(SqlFilter filter, SqlSort sort) {
		super();
		this.filter = filter;
		this.sort = sort;
		if(null != filter && filter.getFilters() != null && filter.getFilters().size() > 0){
			bean = new HashMap<String, Object>();
			for(SqlFilter.Filter fi:filter.getFilters()){
				try {
					BeanHelper.putMap(bean, fi.getProperty(), fi.getValue());
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (NoSuchFieldException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InstantiationException e) {
					e.printStackTrace();
				}
			}
		}
	}
	public SqlFilter getFilter() {
		return filter;
	}
	public void setFilter(SqlFilter filter) {
		this.filter = filter;
	}
	public SqlSort getSort() {
		return sort;
	}
	public void setSort(SqlSort sort) {
		this.sort = sort;
	}
	public Map<String, Object> getBean() {
		return bean;
	}
	public void setBean(Map<String, Object> bean) {
		this.bean = bean;
	}
	
	
}
