package com.wanmei.domain;


public class Security implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer id;
	private Byte type = SecurityHelper.TYPE_SIMPLE;
	private Boolean idNameIsId = true;
	private Project project;
	private Byte idType = SecurityHelper.ID_TYPE_INTEGER;
	
	public String getTypeName(){
		return (null == type)?"":SecurityHelper.typeMap.get(type);
	}
	
	public String getIdType2JavaType(){
		switch(idType){
		case SecurityHelper.ID_TYPE_INTEGER:
			return "java.lang.Integer";
		case SecurityHelper.ID_TYPE_LONG:
			return "java.lang.Integer";
		default:
			return "java.lang.Integer";
		}
	}
	public String getIdType2ShortJavaType(){
		String t = getIdType2JavaType();
		return t.substring(t.lastIndexOf(".") + 1);
	}
	public Security( ) {
	}
	
	public Security(Project project) {
		this.project = project;
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

	public Boolean getIdNameIsId() {
		return idNameIsId;
	}

	public void setIdNameIsId(Boolean idNameIsId) {
		this.idNameIsId = idNameIsId;
	}

	public Byte getIdType() {
		return idType;
	}

	public void setIdType(Byte idType) {
		this.idType = idType;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	
}

