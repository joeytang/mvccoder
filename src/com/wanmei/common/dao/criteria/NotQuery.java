package com.wanmei.common.dao.criteria;

/**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * 不查询条件
 */
public class NotQuery {
    private Object object;
    
	public NotQuery(){}
    public NotQuery(Object object){
    	this.object = object;
    }
    public Object getObject() {
        return object;
    }

    public void setObject(Object object) {
        this.object = object;
    }
}
