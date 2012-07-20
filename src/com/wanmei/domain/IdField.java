package com.wanmei.domain;

import java.util.List;

public class IdField extends Field {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public IdField() {
		this(null);
	}
	public IdField(Domain domain) {
		super(domain);
		super.setListable(false);
		super.setEditable(false);
		super.setViewable(false);
		super.setNullable(false);
		super.setSortable(true);
	}
	public String getSortName() {
		if(this.getType()!= null && this.getType().equals(FieldHelper.TYPE_MANY2ONE)){
			Domain d = null;
			try{
				d = this.getDomain().getProject().getDomainMap().get(this.getEntityName());
			}catch (Exception e) {
			}
			if(null != d){
				List<Field> fs = d.getFields();
				if(null != fs){
					boolean search = false;
					Field firstField = null;
					int i = 0;
					for(Field f:fs){
						if(i==0){
							firstField = f;
							i++;
						}
						if(f.getSortable()){
							search = true;
							return f.getName();
						}
					}
					if(!search){
						return firstField.getName();
					}
				}
			}
		}
		return this.getName();
	}
	
}
