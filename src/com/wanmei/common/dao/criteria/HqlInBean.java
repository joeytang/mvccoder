package com.wanmei.common.dao.criteria;

 /**
 * @author joeytang
 * Date: 2012-03-20 18:17
 * hql中调用in语句时传入的参数
 */
public class HqlInBean {
	private String inName;
	private Object[] inParam;
	public HqlInBean(String inName, Object[] inParam) {
		super();
		this.inName = inName;
		this.inParam = inParam;
	}
	public String getInName() {
		return inName;
	}
	public void setInName(String inName) {
		this.inName = inName;
	}
	public Object[] getInParam() {
		return inParam;
	}
	public void setInParam(Object[] inParam) {
		this.inParam = inParam;
	}
}
