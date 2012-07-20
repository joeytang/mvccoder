package ${project.org}.common.dao;

import java.util.ArrayList;
import java.util.List;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 过滤接口
 */
public class SqlFilter {
	public static enum OP{
		/**
		 * 或运算（or表达式）
		 */
		or,
		/**
		 * 非运算（not表达式）
		 */
		not,
		/**
		 * 模糊匹配（like操作）
		 */
		like,
		/**
		 * 不区分大小写模糊匹配（ilike操作）
		 */
		ilike,
		/**
		 * 大于等于（>=操作）
		 */
		ge,
		/**
		 * 大于（>操作）
		 */
		gt,
		/**
		 * 小于等于（<=操作）
		 */
		le,
		/**
		 * 小于（<操作）
		 */
		lt,
		/**
		 * 为null（is null 操作）
		 */
		isNull,
		/**
		 * 不为null（is not null 操作）
		 */
		isNotNull,
		/**
		 * 为空（is empty操作）
		 */
		isEmpty,
		/**
		 * 不为空（is not empty操作）
		 */
		isNotEmpty,
		/**
		 * 不等于（!= 操作）
		 */
		ne,
		/**
		 * 在什么之间（between操作）
		 */
		between,
		/**
		 * 在范围内（in操作）
		 */
		in,
		/**
		 * 加别名
		 */
		aliase
	}
    List<Filter> filters = new ArrayList<Filter>();
    /**
     * 添加过滤条件
     * @param property
     * @param value
     */
    public void addFilter(String property, Object value) {
    	addFilter(property, value,null);
    }
    /**
     * 添加过滤条件
     * @param property
     * @param value
     */
    public void addFilter(String property, Object value,OP operator) {
        filters.add(new Filter(property, value,operator));
    }

    /**
     * 获得过滤条件
     * @return
     */
    public List<Filter> getFilters() {
		return filters;
	}

	public static class Filter {
        private final String property;
        private final Object value;
        private final OP operator; 

        public Filter(String property, Object value,OP operator) {
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
		public OP getOperator() {
			return operator;
		}
        
    }
}
