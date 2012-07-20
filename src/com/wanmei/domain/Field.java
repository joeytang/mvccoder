package com.wanmei.domain;

public class Field implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer id;
	private String name;
	private String label;
	private String table;
	private String column;
	private String manyColumn;
	private String description;
	private Byte type = FieldHelper.TYPE_STRING;
	private Integer length;
	private Boolean nullable = true;
	private Boolean listable = true;
	private Boolean editable = true;
	private Boolean hbmable = true;
	private Boolean viewable = true;
	private Boolean searchable = false;
	private Boolean sortable = false;
	//private Boolean relationable = false;
	private String entityName;
	private String entityPackage;
	private Integer listOrder = 5;
	private Integer editOrder = 5;
	private Integer viewOrder = 5;
	private Integer searchOrder = 5;
	private Domain domain;
	
	private Boolean isDict = false;
	private Byte category = FieldHelper.CATEGORY_COMM;
	
	private Byte relationType = FieldHelper.RELATION_TYPE_NONE;
	private Byte many2OneType = FieldHelper.MANY2ONETYPE_LIST;
	private String many2OneName = "name";
	private Integer many2OneOrder = 1;
	
	
	
	public Field( ) {
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	public Field(Domain domain) {
		this.domain = domain;
	}

	public Domain getDomain() {
		return domain;
	}

	public void setDomain(Domain domain) {
		this.domain = domain;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getColumn() {
		return column;
	}
	public void setColumn(String column) {
		this.column = column;
	}
	public Byte getType() {
		return type;
	}
	public void setType(Byte type) {
		this.type = type;
	}
	public Integer getLength() {
		return length;
	}
	public void setLength(Integer length) {
		this.length = length;
	}
	public Boolean getNullable() {
		return nullable;
	}
	public void setNullable(Boolean nullable) {
		this.nullable = nullable;
	}
	public Boolean getSortable() {
		return sortable;
	}
	public void setSortable(Boolean sortable) {
		this.sortable = sortable;
	}
	
	public Boolean getSearchable() {
		return searchable;
	}

	public void setSearchable(Boolean searchable) {
		this.searchable = searchable;
	}

	public Boolean getListable() {
		return listable;
	}
	public void setListable(Boolean listable) {
		this.listable = listable;
	}
	public Boolean getEditable() {
		return editable;
	}
	public void setEditable(Boolean editable) {
		this.editable = editable;
	}
	public Boolean getViewable() {
		return viewable;
	}
	public void setViewable(Boolean viewable) {
		this.viewable = viewable;
	}
	public Integer getListOrder() {
		return listOrder;
	}
	public void setListOrder(Integer listOrder) {
		this.listOrder = listOrder;
	}
	public Integer getEditOrder() {
		return editOrder;
	}
	public void setEditOrder(Integer editOrder) {
		this.editOrder = editOrder;
	}
	public Integer getViewOrder() {
		return viewOrder;
	}
	public void setViewOrder(Integer viewOrder) {
		this.viewOrder = viewOrder;
	}
	
	public Integer getSearchOrder() {
		return searchOrder;
	}

	public void setSearchOrder(Integer searchOrder) {
		this.searchOrder = searchOrder;
	}

	public String getEntityName() {
		return entityName;
	}
	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}
	public String getEntityPackage() {
		return entityPackage;
	}
	public void setEntityPackage(String entityPackage) {
		this.entityPackage = entityPackage;
	}
	public String getTable() {
		return table;
	}
	public void setTable(String table) {
		this.table = table;
	}
	public String getManyColumn() {
		return manyColumn;
	}
	public void setManyColumn(String manyColumn) {
		this.manyColumn = manyColumn;
	}
	
	public Boolean getHbmable() {
		return hbmable;
	}

	public void setHbmable(Boolean hbmable) {
		this.hbmable = hbmable;
	}

	public String getPrimaryType(){
		return FieldHelper.getPrimaryType(type);
	}
	public String getLowPrimaryType(){
		return FieldHelper.getLowPrimaryType(type);
	}
	public String getDictValue(){
		return FieldHelper.getDictValue(type);
	}

	public Boolean getIsDict() {
		return isDict;
	}

	public void setIsDict(Boolean isDict) {
		this.isDict = isDict;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Byte getCategory() {
		return category;
	}

	public void setCategory(Byte category) {
		this.category = category;
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
