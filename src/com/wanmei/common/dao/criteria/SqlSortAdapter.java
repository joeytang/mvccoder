package com.wanmei.common.dao.criteria;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Order;

import com.wanmei.common.dao.SqlSort;

/**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * 排序条件
 */
public class SqlSortAdapter implements CriteriaCommand {
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
     * 加载过滤条件
     * @param criteria
     * @return
     */
    public Criteria execute(Criteria criteria) {
        for (Sort sort : sorts) {
            buildCriteria(criteria, sort.getProperty(), sort.getOrder());
        }

        return criteria;
    }

    /**
     * 按规则加载
     * @param criteria
     * @param property
     * @param order
     */
    private void buildCriteria(Criteria criteria, String property, String order) {
        if (order.equals(Sort.ASC)) {
            criteria.addOrder(Order.asc(property));
        } else if (order.equals(Sort.DESC)) {
            criteria.addOrder(Order.desc(property));
        }
    }

    /***
     * 内部类
     */
    private static class Sort {
        public final static String ASC = "asc";
        public final static String DESC = "desc";

        private final String property;
        private final String order;

        public Sort(String property, String order) {
            this.property = property;
            this.order = order;
        }

        public String getProperty() {
            return property;
        }

        public String getOrder() {
            return order;
        }
    }
    
    /**
     * 将公用排序适配成hibernate排序
     * @param sqlSort
     * @return
     */
    public static SqlSortAdapter createSort(SqlSort sqlSort){
    	SqlSortAdapter sort = new SqlSortAdapter();
    	if(null != sqlSort){
    		List<SqlSort.Sort> sqlSs = sqlSort.getSorts();
    		if(null != sqlSs && sqlSs.size() > 0){
    			for(SqlSort.Sort sqls:sqlSs){
    				sort.addSort(sqls.getProperty(), sqls.getOrder());
    			}
    		}
    	}
    	return sort;
    }
}