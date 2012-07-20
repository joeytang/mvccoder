package com.wanmei.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wanmei.util.DateUtil;

public class Project implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer id;
	private String name;
	private String label;
	private String org;
	private String tablePre;
	private String output;
	private String version;
	private String jdkVersion = "1.7";
	private Boolean needTomcatPlug = true;
	private List<Domain> domains;
	private Byte proType = ProjectHelper.PRO_TYPE_COMMON;
	private Byte codeType = ProjectHelper.CODE_TYPE_BACK;
	private String currentTime = DateUtil.toDateTimeStr(new Date());
	private Db db;
	private Action action;
	private Dao dao;
	private Security security;
	private Map<String,Domain> domainMap = new HashMap<String,Domain>();
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getRootPath(){
		return output + "/" +name+version+"/" +name+"/";
	}
	public String getProjectDir(){
		return output + "/" +name+version;
	}
	public String getSrcPath(){
		if(this.proType == ProjectHelper.PRO_TYPE_MVN){
			return getRootPath() + "/src/main/java/";
		}
		return getRootPath() + "/src/";
	}
	public String getWebPath(){
		if(this.proType == ProjectHelper.PRO_TYPE_MVN){
			return getRootPath() + "/src/main/webapp/";
		}
		return getRootPath() + "/web/";
	}
	public String getResPath(){
		if(this.proType == ProjectHelper.PRO_TYPE_MVN){
			return getRootPath() + "/src/main/resources/";
		}
		return getRootPath() + "/src/resources/";
	}
	public String getConfPath(){
		if(this.proType == ProjectHelper.PRO_TYPE_MVN){
			return getRootPath() + "/src/main/config/";
		}
		return getRootPath() + "/src/config/";
	}
	public String getTestSrcPath(){
		if(this.proType == ProjectHelper.PRO_TYPE_MVN){
			return getRootPath() + "/src/test/java/";
		}
		return getRootPath() + "/src/";
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
	public String getOrg() {
		return org;
	}
	public void setOrg(String org) {
		this.org = org;
	}
	public Boolean getNeedTomcatPlug() {
		return needTomcatPlug;
	}
	public void setNeedTomcatPlug(Boolean needTomcatPlug) {
		this.needTomcatPlug = needTomcatPlug;
	}
	public List<Domain> getDomains() {
		return domains;
	}
	public void setDomains(List<Domain> domains) {
		this.domains = domains;
	}
	public Byte getProType() {
		return proType;
	}
	public void setProType(Byte proType) {
		this.proType = proType;
	}
	public Byte getCodeType() {
		return codeType;
	}
	public void setCodeType(Byte codeType) {
		this.codeType = codeType;
	}
	public String getCurrentTime() {
		return currentTime;
	}
	public void setCurrentTime(String currentTime) {
		this.currentTime = currentTime;
	}
	public Action getAction() {
		return action;
	}
	public void setAction(Action action) {
		this.action = action;
	}
	public Dao getDao() {
		return dao;
	}
	public void setDao(Dao dao) {
		this.dao = dao;
	}
	public Security getSecurity() {
		return security;
	}
	public void setSecurity(Security security) {
		this.security = security;
	}
	public void addDomain(Domain domain){
		if(null == this.domains){
			this.domains = new ArrayList<Domain>();
		}
		this.domains.add(domain);
	}
	public String getOutput() {
		return output;
	}
	public void setOutput(String output) {
		this.output = output;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getTablePre() {
		return tablePre;
	}
	public void setTablePre(String tablePre) {
		this.tablePre = tablePre;
	}
	public Db getDb() {
		return db;
	}
	public void setDb(Db db) {
		this.db = db;
	}
	public String getJdkVersion() {
		return jdkVersion;
	}
	public void setJdkVersion(String jdkVersion) {
		this.jdkVersion = jdkVersion;
	}
	/**
	 * 获得用户模块配置
	 * @return
	 */
	public Domain getUserDomain(){
		if(null == this.domains){
			return null;
		}
		for(Domain d:domains){
			if(d.getIsUser()){
				return d;
			}
		}
		return null;
	}
	public Map<String, Domain> getDomainMap() {
		return domainMap;
	}
	public void setDomainMap(Map<String, Domain> domainMap) {
		this.domainMap = domainMap;
	}
	
	
}

