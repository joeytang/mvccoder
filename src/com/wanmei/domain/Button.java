package com.wanmei.domain;

public class Button implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private String label;
	private String function;
	private Byte type;
	private Domain domain;
	
	
	public void setFunction(String function) {
		this.function = function;
	}

	public String getFunction(){
		return this.function;
	}
	
	public Button( ) {
	}
	
	public Button(Domain domain) {
		this.domain = domain;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public Byte getType() {
		return type;
	}

	public void setType(Byte type) {
		this.type = type;
	}

	public Domain getDomain() {
		return domain;
	}

	public void setDomain(Domain domain) {
		this.domain = domain;
	}

	
}
