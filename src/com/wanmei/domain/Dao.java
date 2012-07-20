package com.wanmei.domain;

public class Dao implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer id;
	private Byte type = DaoHelper.TYPE_HBM3;
	private Project project;
	public String getTypeName(){
		return (null == type)?"":DaoHelper.typeMap.get(type);
	}
	public Dao( ) {
	}
	public Dao(Project project) {
		this.project = project;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}
	public Byte getType() {
		return type;
	}

	public void setType(Byte type) {
		this.type = type;
	}
	
}
