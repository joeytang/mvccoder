package com.wanmei.domain;

import java.util.Date;
/**
 * @author joeytang
 * Date: 2012-03-20 18:17
 * DomainField
 */
public class DomainField implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private Domain domain;
	private Field field;
	private Boolean nullable = true;
	private Boolean listable = true;
	private Boolean editable = true;
	private Boolean hbmable = true;
	private Boolean viewable = true;
	private Boolean searchable = false;
	private Boolean sortable = false;
	//private Boolean relationable = false;
	private Integer listOrder = 5;
	private Integer editOrder = 5;
	private Integer viewOrder = 5;
	private Integer searchOrder = 5;
	private Date createTime = new Date();
	
	private Byte relationType = FieldHelper.RELATION_TYPE_NONE;
	
	private Byte many2OneType = FieldHelper.MANY2ONETYPE_LIST;
	private String many2OneName = "name";
	private Integer many2OneOrder = 1;
	
	
	public DomainField() {
	}
	public void setId(Integer id){
		this.id = id;
	}
	public Integer getId(){
		return this.id;
	}
	public void setDomain(Domain domain){
		this.domain = domain;
	}
	public Domain getDomain(){
		return this.domain;
	}
	public void setField(Field field){
		this.field = field;
	}
	public Field getField(){
		return this.field;
	}
	public void setNullable(Boolean nullable){
		this.nullable = nullable;
	}
	public Boolean getNullable(){
		return this.nullable;
	}
	public void setListable(Boolean listable){
		this.listable = listable;
	}
	public Boolean getListable(){
		return this.listable;
	}
	public void setEditable(Boolean editable){
		this.editable = editable;
	}
	public Boolean getEditable(){
		return this.editable;
	}
	public void setHbmable(Boolean hbmable){
		this.hbmable = hbmable;
	}
	public Boolean getHbmable(){
		return this.hbmable;
	}
	public void setViewable(Boolean viewable){
		this.viewable = viewable;
	}
	public Boolean getViewable(){
		return this.viewable;
	}
	public void setSearchable(Boolean searchable){
		this.searchable = searchable;
	}
	public Boolean getSearchable(){
		return this.searchable;
	}
	public void setSortable(Boolean sortable){
		this.sortable = sortable;
	}
	public Boolean getSortable(){
		return this.sortable;
	}
	public void setListOrder(Integer listOrder){
		this.listOrder = listOrder;
	}
	public Integer getListOrder(){
		return this.listOrder;
	}
	public void setEditOrder(Integer editOrder){
		this.editOrder = editOrder;
	}
	public Integer getEditOrder(){
		return this.editOrder;
	}
	public void setViewOrder(Integer viewOrder){
		this.viewOrder = viewOrder;
	}
	public Integer getViewOrder(){
		return this.viewOrder;
	}
	public void setSearchOrder(Integer searchOrder){
		this.searchOrder = searchOrder;
	}
	public Integer getSearchOrder(){
		return this.searchOrder;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Byte getMany2OneType() {
		return many2OneType;
	}
	public void setMany2OneType(Byte many2OneType) {
		this.many2OneType = many2OneType;
	}
	public String getMany2OneName() {
		return many2OneName;
	}
	public void setMany2OneName(String many2OneName) {
		this.many2OneName = many2OneName;
	}
	public Integer getMany2OneOrder() {
		return many2OneOrder;
	}
	public void setMany2OneOrder(Integer many2OneOrder) {
		this.many2OneOrder = many2OneOrder;
	}
	public Byte getRelationType() {
		return relationType;
	}
	public void setRelationType(Byte relationType) {
		this.relationType = relationType;
	}
	
	

}
