package com.wanmei.domain;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import org.apache.commons.lang.StringUtils;

import com.wanmei.util.StringUtil;


public class Domain implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer idkey;
	private Field id;
	private String name;
	private String label;
	private String table;
	private String description;
	private String packageName;
	private List<Button> buttons;
	private Byte checkType = DomainHelper.CHECK_TYPE_RADIO;
	private List<Field> fields = new ArrayList<Field>();
	private List<Controller> controllers = new ArrayList<Controller>();
	private String disabledControllers ;
	private Project project;
	private Boolean isUser = false;
	private Boolean isComposeId = false;
	
	private Boolean isMany2OneRelationBean = false;//是否被多对一关联
	private String many2OneRelationBeanFieldName = "name";//被多对一关联时，读取列名
	
	private Boolean isOne2ManyRelationBean = false;//是否多对一中，由一方维持关系
	private Field one2ManyRelationField = null;//多对一中，由一方维持关系时的列对象
	
	private Boolean isMany2ManyKey = false; //是否多对多主键类
	
	private Boolean isMany2ManyRelationBean = false;//是否多对多中，由对方维持关系
	private Field many2ManyRelationField = null;//多对多中，由对方维持关系时的列对象
	
	private String lowerFirstName ;//被多对一关联时，读取列名
	
	public String getLowerFirstName(){
		if(StringUtils.isNotBlank(lowerFirstName)){
			return lowerFirstName;
		}
		return StringUtil.lowerFirstChar(name);
	}
	public void SetLowerFirstName(String lowerFirstName){
		this.lowerFirstName = lowerFirstName;
	}
	
	public Integer getIdkey() {
		return idkey;
	}

	public void setIdkey(Integer idkey) {
		this.idkey = idkey;
	}

	public Domain( ) {
	}
	public Domain(Project project) {
		this.project = project;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}
	public Field getId() {
		return id;
	}
	public void setId(Field id) {
		this.id = id;
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
	public String getTable() {
		return table;
	}
	public void setTable(String table) {
		this.table = table;
	}
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<Field> getFields() {
		return fields;
	}
	public void setFields(List<Field> fields) {
		this.fields = fields;
	}
	public void addField(Field field){
		if(null == this.fields){
			this.fields = new ArrayList<Field>();
		}
		this.fields.add(field);
	}
	
	public List<Field> getSortedField(Comparator<Field> com,List<Field> oriFields){
		if(null == oriFields){
			oriFields = this.fields;
		}
		if(null == oriFields || oriFields.size() == 0){
			return null;
		}
		List<Field> re = new ArrayList<Field>(oriFields);
		Collections.copy(re, oriFields);
		Collections.sort(re, com);
		return re;
	}
	public List<Field> getListSortField(){
		return getSortedField(new ListOrderComparator(),getListableFields());
	}
	public List<Field> getEditSortField(){
		return getSortedField(new EditOrderComparator(),getEditableFields());
	}
	public List<Field> getViewSortField(){
		return getSortedField(new ViewOrderComparator(),getViewableFields());
	}
	public List<Field> getSearchSortField(){
		return getSortedField(new SearchOrderComparator(),getSearchableFields());
	}
	
	public List<Controller> getControllers() {
		return controllers;
	}
	public void setControllers(List<Controller> controllers) {
		this.controllers = controllers;
	}
	public String getDisabledControllers() {
		return disabledControllers;
	}
	public void setDisabledControllers(String disabledControllers) {
		this.disabledControllers = disabledControllers;
	}
	

	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}
	

	public List<Button> getButtons() {
		return buttons;
	}

	public void setButtons(List<Button> buttons) {
		this.buttons = buttons;
	}

	public Byte getCheckType() {
		return checkType;
	}

	public void setCheckType(Byte checkType) {
		this.checkType = checkType;
	}

	public class ListOrderComparator implements Comparator<Field>{
		@Override
		public int compare(Field o1, Field o2) {
			return o1.getListOrder().compareTo(o2.getListOrder());
		}
	}
	public class EditOrderComparator implements Comparator<Field>{
		@Override
		public int compare(Field o1, Field o2) {
			return o1.getEditOrder().compareTo(o2.getEditOrder());
		}
	}
	public class ViewOrderComparator implements Comparator<Field>{
		@Override
		public int compare(Field o1, Field o2) {
			return o1.getViewOrder().compareTo(o2.getViewOrder());
		}
	}
	public class SearchOrderComparator implements Comparator<Field>{
		@Override
		public int compare(Field o1, Field o2) {
			return o1.getSearchOrder().compareTo(o2.getSearchOrder());
		}
	}
	
	public Set<String> getImportFieldTypes(){
		Set<String> clzSet = new HashSet<String>();
		for(Field f:getAllFields()){
			if(f.getType() == FieldHelper.TYPE_DATE || f.getType() == FieldHelper.TYPE_DATETIME){
				clzSet.add("java.util.Date");
			}else if(f.getType() == FieldHelper.TYPE_ONE2MANY || f.getType() == FieldHelper.TYPE_MANY2MANY){
				clzSet.add("java.util.Set");
				clzSet.add("java.util.HashSet");
				clzSet.add(f.getEntityPackage()+"."+f.getEntityName());
			}else if(f.getType() == FieldHelper.TYPE_MANY2ONE || f.getType() == FieldHelper.TYPE_MANY2MANY){
				clzSet.add(f.getEntityPackage()+"."+f.getEntityName());
				
			}
		}
		return clzSet;
	}
	public Set<String> getControllerImportFieldTypes(){
		Set<String> clzSet = new TreeSet<String>();
		if(null != this.project){
			clzSet.add(this.project.getOrg()+".common.controller.MvcControllerTemplate");
			clzSet.add(this.project.getOrg()+".support.SortBean");
			clzSet.add(this.project.getOrg()+".service."+this.name+"Service");
			clzSet.add(this.packageName+"."+this.name);
			clzSet.add("org.springframework.stereotype.Controller");
			clzSet.add("org.springframework.web.bind.annotation.RequestMapping");
			clzSet.add("org.springframework.web.bind.annotation.PathVariable");
			clzSet.add("org.springframework.ui.ModelMap");
			clzSet.add("javax.servlet.http.HttpServletRequest");
			clzSet.add("javax.servlet.http.HttpServletResponse");
			clzSet.add("net.sf.json.JSONObject");
			clzSet.add(this.project.getOrg()+".util.RenderUtils");
			if(isUser){
				clzSet.add(this.packageName+".helper."+this.name+"Helper");
				clzSet.add(this.project.getOrg()+".util.BeanHelper");
				clzSet.add("org.springframework.web.bind.annotation.RequestParam");
				clzSet.add("java.util.ArrayList");
			}
			if((this.getSearchSortField() != null && this.getSearchSortField().size() > 0 ) || this.getOne2ManyRelationFields() != null && this.getOne2ManyRelationFields().size() > 0){
				clzSet.add(this.project.getOrg()+".common.dao.SqlFilter");
				clzSet.add(this.project.getOrg()+".common.dao.SqlSort");
				clzSet.add("java.util.List");
				clzSet.add(this.project.getOrg()+".util.StringUtil");
				clzSet.add(this.project.getOrg()+".tool.paging.CommonList");
				clzSet.add("org.apache.commons.lang.StringUtils");
			}
			if(this.getIsMultipart() && (this.getDisabledControllers() != null || this.getDisabledControllers().indexOf("save") == -1 )){
				clzSet.add("org.springframework.beans.factory.annotation.Autowired");
				clzSet.add("org.springframework.web.multipart.MultipartHttpServletRequest");
				clzSet.add(this.project.getOrg()+".support.MvcUploadSupport");
				
			}
			if((this.getDisabledControllers() != null || this.getDisabledControllers().indexOf("save") == -1 ) && this.getEditableFields().size() > 0){
				clzSet.add(this.project.getOrg()+".util.ValidateUtils");
			}
			if(null != this.getSearchSortField() && this.getSearchSortField().size() > 0){
				clzSet.add("org.apache.commons.lang.StringUtils");
			}
			if(this.getIsMany2OneRelationBean()){
				clzSet.add(this.project.getOrg()+".common.dao.SqlFilter");
				clzSet.add(this.project.getOrg()+".common.dao.SqlSort");
				clzSet.add("org.apache.commons.lang.StringUtils");
				clzSet.add("java.util.List");
			}
			if(id.getType().equals(FieldHelper.TYPE_MANY2ONE)){
				clzSet.add(id.getEntityPackage()+"."+id.getEntityName());
			}
			List<Field> tempMany2ManyRelationFields = this.getMany2ManyRelationFields();
			if(tempMany2ManyRelationFields != null && tempMany2ManyRelationFields.size()>0){
				for(Field f:tempMany2ManyRelationFields){
					clzSet.add(f.getEntityPackage()+"."+f.getEntityName());
					clzSet.add(this.getPackageName()+"."+this.getName()+f.getEntityName()+"Key");
					clzSet.add(this.project.getOrg()+".service."+this.getName()+f.getEntityName()+"KeyService");
				}
				clzSet.add("java.util.List");
				clzSet.add("java.util.ArrayList");
				clzSet.add(this.project.getOrg()+".tool.paging.CommonList");
				clzSet.add(this.project.getOrg()+".util.StringUtil");
				clzSet.add("org.apache.commons.lang.StringUtils");
				clzSet.add("org.springframework.beans.factory.annotation.Autowired");
			}
		}
		return clzSet;
	}
	public List<Field> getAllFields(){
		List<Field> tempFields = new ArrayList<Field>();
		if(null != id){
			tempFields.add(id);
		}
		if(null != fields){
			tempFields.addAll(fields);
		}
		return tempFields;
	}
	public List<Field> getListableFields(){
		List<Field> fs = new ArrayList<Field>();
		for(Field f:getAllFields()){
			if(f.getListable()){
				fs.add(f);
			}
		}
		return fs;
	}
	public List<Field> getEditableFields(){
		List<Field> fs = new ArrayList<Field>();
		for(Field f:getAllFields()){
			if(f.getEditable()){
				fs.add(f);
			}
		}
		return fs;
	}
	public List<Field> getViewableFields(){
		List<Field> fs = new ArrayList<Field>();
		for(Field f:getAllFields()){
			if(f.getViewable()){
				fs.add(f);
			}
		}
		return fs;
	}
	public List<Field> getSearchableFields(){
		List<Field> fs = new ArrayList<Field>();
		if(null != this.fields){
			for(Field f:this.fields){
				if(f.getSearchable()){
					fs.add(f);
				}
			}
		}
		return fs;
	}
	public List<Field> getHbmableFields(){
		List<Field> fs = new ArrayList<Field>();
		if(null != this.fields){
			for(Field f:this.fields){
				if(f.getHbmable()){
					fs.add(f);
				}
			}
		}
		return fs;
	}
	public List<Field> getFileFields(){
		List<Field> fs = new ArrayList<Field>();
		if(null != this.fields){
			for(Field f:this.fields){
				if(f.getType() == FieldHelper.TYPE_FILE){
					fs.add(f);
				}
			}
		}
		return fs;
	}
	public boolean getIsMultipart(){
		if(null != this.fields){
			for(Field f:this.fields){
				if(f.getType() == FieldHelper.TYPE_FILE){
					return true;
				}
			}
		}
		return false;
	}
	public boolean getHasEdit(){
		if(null != this.buttons){
			for(Button b:this.buttons){
				if(b.getType() == ButtonHelper.TYPE_EDIT){
					return true;
				}
			}
		}
		return false;
	}
	public boolean getHasDel(){
		if(null != this.buttons){
			for(Button b:this.buttons){
				if(b.getType() == ButtonHelper.TYPE_DEL || b.getType() == ButtonHelper.TYPE_DELMORE){
					return true;
				}
			}
		}
		return false;
	}
	public List<Field> getRefFields(){
		List<Field> fs = new ArrayList<Field>();
		if(null != this.fields){
			for(Field f:this.fields){
				if(StringUtils.isNotEmpty(f.getEntityName())){
					fs.add(f);
				}
			}
		}
		return fs;
	}
	public String getRefFieldStr(){
		StringBuffer sb = new StringBuffer();
		List<Field> l = getRefFields();
		for(int i = 0;i< l.size();i++){
			sb.append("\"" + l.get(i).getName()+ "\"");
			if(i != l.size() - 1){
				sb.append(",");
			}
		}
		return sb.toString();
	}
	public List<Field> getDictFields(){
		List<Field> fs = new ArrayList<Field>();
		if(null != this.fields){
			for(Field f:this.fields){
				if( f.getIsDict()!= null && f.getIsDict()){
					fs.add(f);
				}
			}
		}
		return fs;
	}
	public List<Field> getDictEditFields(){
		List<Field> fs = new ArrayList<Field>();
		if(null != getDictFields()){
			for(Field f:getDictFields()){
				if( f.getEditable()){
					fs.add(f);
				}
			}
		}
		return fs;
	}
	public Boolean getIsUser() {
		return isUser;
	}

	public void setIsUser(Boolean isUser) {
		this.isUser = isUser;
	}
	
	
	public Boolean getIsComposeId() {
		return isComposeId != null?isComposeId:false;
	}
	public void setIsComposeId(Boolean isComposeId) {
		this.isComposeId = isComposeId;
	}
	public List<Field> getMany2OneEditSelectFields(){
		List<Field> fs = new ArrayList<Field>();
		if(null != this.fields){
			for(Field f:this.fields){
				if( f.getEditable() && f.getType().equals(FieldHelper.TYPE_MANY2ONE) && f.getRelationType().equals(FieldHelper.RELATION_TYPE_SELF) && f.getMany2OneType().equals(FieldHelper.MANY2ONETYPE_SELECT)){
					fs.add(f);
				}
			}
		}
		return fs;
	}
	
	public List<Field> getOne2ManyRelationFields(){
		List<Field> fs = new ArrayList<Field>();
		if(null != this.fields){
			for(Field f:this.fields){
				if( f.getType().equals(FieldHelper.TYPE_MANY2ONE) && f.getRelationType().equals(FieldHelper.RELATION_TYPE_OTHER)){
					fs.add(f);
				}
			}
		}
		return fs;
	}
	public Field getMany2OneOtherRelationField(){
		List<Field> l = getOne2ManyRelationFields();
		if(null != l && l.size()> 0){
			return l.get(0);
		}
		return null;
	}

	public Boolean getIsMany2OneRelationBean() {
		return isMany2OneRelationBean;
	}

	public void setIsMany2OneRelationBean(Boolean isMany2OneRelationBean) {
		this.isMany2OneRelationBean = isMany2OneRelationBean;
	}

	public String getMany2OneRelationBeanFieldName() {
		return many2OneRelationBeanFieldName;
	}

	public void setMany2OneRelationBeanFieldName(
			String many2OneRelationBeanFieldName) {
		this.many2OneRelationBeanFieldName = many2OneRelationBeanFieldName;
	}

	public Boolean getIsOne2ManyRelationBean() {
		return isOne2ManyRelationBean;
	}

	public void setIsOne2ManyRelationBean(Boolean isOne2ManyRelationBean) {
		this.isOne2ManyRelationBean = isOne2ManyRelationBean;
	}

	public Field getOne2ManyRelationField() {
		return one2ManyRelationField;
	}

	public void setOne2ManyRelationField(Field one2ManyRelationField) {
		this.one2ManyRelationField = one2ManyRelationField;
	}

	public Boolean getIsMany2ManyKey() {
		return isMany2ManyKey;
	}

	public void setIsMany2ManyKey(Boolean isMany2ManyKey) {
		this.isMany2ManyKey = isMany2ManyKey;
	}

	public List<Field> getMany2ManyRelationFields(){
		List<Field> fs = new ArrayList<Field>();
		if(null != this.fields){
			for(Field f:this.fields){
				if( f.getType().equals(FieldHelper.TYPE_MANY2MANY) && f.getRelationType().equals(FieldHelper.RELATION_TYPE_SELF)){
					fs.add(f);
				}
			}
		}
		return fs;
	}

	public Boolean getIsMany2ManyRelationBean() {
		return isMany2ManyRelationBean;
	}

	public void setIsMany2ManyRelationBean(Boolean isMany2ManyRelationBean) {
		this.isMany2ManyRelationBean = isMany2ManyRelationBean;
	}

	public Field getMany2ManyRelationField() {
		return many2ManyRelationField;
	}

	public void setMany2ManyRelationField(Field many2ManyRelationField) {
		this.many2ManyRelationField = many2ManyRelationField;
	}
	
	
	
	
}
