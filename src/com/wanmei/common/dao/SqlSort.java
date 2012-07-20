package com.wanmei.common.dao;

import java.util.ArrayList;
import java.util.List;

/**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * 排序条件
 */
public class SqlSort {
    List<Sort> sorts = new ArrayList<Sort>();

    /**
     * 添加排序条件
     * @param property
     * @param order
     */
    public void addSort(String property, String order) {
        sorts.add(new Sort(property, order));
    }

	/**
	 * 获得排序条件
	 * @return
	 */
    public List<Sort> getSorts() {
		return sorts;
	}


	/***
     * 内部类
     */
    public static class Sort {
        private final String property;
        private final String order;
        private final String column; 

        public Sort(String property, String order) {
        	this(property, order, property);
        }
        public Sort(String property, String order,String column) {
            this.property = property;
            this.order = order;
            this.column = column;
        }
        public String getProperty() {
            return property;
        }

        public String getOrder() {
            return order;
        }
		public String getColumn() {
			return column;
		}
        
    }
}