package ${project.org}.common.dao.criteria;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Disjunction;
import org.hibernate.criterion.Restrictions;

import ${project.org}.common.dao.SqlFilter;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 过滤接口
 */
public class SqlFilterAdapter implements CriteriaCommand {
	List<Filter> filters = new ArrayList<Filter>();
	// 过滤重复的别名
	Map<String,String> aliases = new HashMap<String,String>();

	/**
	 * 添加过滤条件
	 * 
	 * @param property
	 * @param value
	 */
	public void addFilter(String property, Object value) {
		addFilter(property, value, null);
	}

	/**
	 * 添加过滤条件
	 * 
	 * @param property
	 * @param value
	 */
	public void addFilter(String property, Object value, SqlFilter.OP operator) {
		filters.add(new Filter(property, value, operator));
	}

	/**
	 * 加载过滤条件
	 * 
	 * @param criteria
	 * @return
	 */
	public Criteria execute(Criteria criteria) {
		criteria.add(buildAndCriterion(buildCriterions()));
		if (null != aliases && aliases.size() > 0) {
			for (Map.Entry<String, String> a : aliases.entrySet()) {
				criteria.createAlias(a.getKey(), a.getValue());
			}
		}
		return criteria;
	}

	public List<Filter> getFilters() {
		return filters;
	}

	/**
	 * 根据filter属性，转换成Criterion
	 * 
	 * @return
	 */
	public List<Criterion> buildCriterions() {
		List<Criterion> cs = new LinkedList<Criterion>();
		for (Filter filter : filters) {
			Criterion c = buildCriterion(filter);
			if (null != c) {
				cs.add(c);
			}
		}
		return cs;
	}

	/**
	 * 将Criterion列表组装到and集合里
	 * 
	 * @param cs
	 * @return
	 */
	public Conjunction buildAndCriterion(List<Criterion> cs) {
		Conjunction conjunction = Restrictions.conjunction();
		for (Criterion c : buildCriterions()) {
			conjunction.add(c);
		}
		return conjunction;
	}

	/**
	 * 将Criterion列表组装到or集合里
	 * 
	 * @param cs
	 * @return
	 */
	public Criterion buildOrCriterion(List<Criterion> cs) {
		Disjunction disjunction = Restrictions.disjunction();
		for (Criterion c : buildCriterions()) {
			disjunction.add(c);
		}
		return disjunction;
	}

	/**
	 * 将Criterion列表组装到not集合里
	 * 
	 * @param cs
	 * @return
	 */
	public Criterion buildNotCriterion(List<Criterion> cs) {
		Conjunction conjunction = Restrictions.conjunction();
		for (Criterion c : buildCriterions()) {
			conjunction.add(c);
		}
		return Restrictions.not(conjunction);
	}

	public Criterion buildCriterion(Filter filter) {
		String property = filter.getProperty();
		Object value = filter.getValue();
		SqlFilter.OP operator = filter.getOperator();
		boolean isId = false;
    	if(null != value && value instanceof CompositeId){
    		isId = true;
    		value = ((CompositeId) value).getObject();
    	}
		if(null != property && property.indexOf(".")!=-1 && !isId){
			String a = property.substring(0,property.indexOf("."));
        	aliases.put(a,a);
        }
		if (operator == null) {
			return Restrictions.eq(property, value);
		}
		switch (operator) {
		case aliase:
			aliases.put(property,value.toString());
			return null;
		case like:
			return Restrictions.like(property, "%"+value+"%");
		case ilike:
			return Restrictions.ilike(property, "%"+value+"%");
		case ge:
			return Restrictions.ge(property, value);
		case gt:
			return Restrictions.gt(property, value);
		case le:
			return Restrictions.le(property, value);
		case lt:
			return Restrictions.lt(property, value);
		case ne:
			return Restrictions.ne(property, value);
		case isNull:
			return Restrictions.isNull(property);
		case isNotNull:
			return Restrictions.isNotNull(property);
		case isEmpty:
			return Restrictions.isEmpty(property);
		case isNotEmpty:
			return Restrictions.isNotEmpty(property);
		case between:
			Object[] v = (Object[]) value;
			return Restrictions.between(property, v[0], v[1]);
		case in:
			Collection<?> values = (Collection<?>) value;
			return Restrictions.in(property, values);
		case or:
			SqlFilterAdapter filterOrAdapter = createFilter((SqlFilter) value);
			return filterOrAdapter.buildOrCriterion(filterOrAdapter
					.buildCriterions());
		case not:
			SqlFilterAdapter filterNotAdapter = createFilter((SqlFilter) value);
			return filterNotAdapter.buildNotCriterion(filterNotAdapter
					.buildCriterions());
		default:
			return Restrictions.eq(property, value);

		}
	}

	public static class Filter {
		private final String property;
		private final Object value;
		private final SqlFilter.OP operator;

		public Filter(String property, Object value, SqlFilter.OP operator) {
			this.property = property;
			this.value = value;
			this.operator = operator;
		}

		public Filter(String property, Object value) {
			this(property, value, null);
		}

		public String getProperty() {
			return property;
		}

		public Object getValue() {
			return value;
		}

		public SqlFilter.OP getOperator() {
			return operator;
		}

	}

	/**
	 * 将公用过滤适配成hibernate过滤
	 * 
	 * @param sqlFilter
	 * @return
	 */
	public static SqlFilterAdapter createFilter(SqlFilter sqlFilter) {
		SqlFilterAdapter filter = new SqlFilterAdapter();
		if (null != sqlFilter) {
			List<SqlFilter.Filter> sqlFs = sqlFilter.getFilters();
			if (null != sqlFs && sqlFs.size() > 0) {
				for (SqlFilter.Filter sqlF : sqlFs) {
					filter.addFilter(sqlF.getProperty(), sqlF.getValue(),
							sqlF.getOperator());
				}
			}
		}
		return filter;
	}
}
