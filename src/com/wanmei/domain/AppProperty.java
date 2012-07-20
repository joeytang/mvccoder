package com.wanmei.domain;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.wanmei.util.DateUtil;

public class AppProperty {

	private String src;
	private String org;
	private String root;
	private String project;
//	private List<Property> properties;
	private List<File> hbmFiles;
	
	private String currentTime = DateUtil.toDateTimeStr(new Date());
	
	public String getSrc() {
		return src;
	}
	public void setSrc(String src) {
		this.src = src;
	}
	public String getOrg() {
		return org;
	}
	public void setOrg(String org) {
		this.org = org;
	}
	public String getRoot() {
		return root;
	}
	public void setRoot(String root) {
		this.root = root;
	}
	public String getProject() {
		return project;
	}
	public void setProject(String project) {
		this.project = project;
	}
	
//	/**
//	 * @return the properties
//	 */
//	public List<Property> getProperties() {
//		return properties;
//	}
//	/**
//	 * @param properties the properties to set
//	 */
//	public void setProperties(List<Property> properties) {
//		this.properties = properties;
//	}
//	public void addProperty(Property p){
//		if(null == this.properties){
//			this.properties = new ArrayList<Property>();
//		}
//		this.properties.add(p);
//	}
	/**
	 * @return the hbmFiles
	 */
	public List<File> getHbmFiles() {
		return hbmFiles;
	}
	/**
	 * @param hbmFiles the hbmFiles to set
	 */
	public void setHbmFiles(List<File> hbmFiles) {
		this.hbmFiles = hbmFiles;
	}
	public void addHbmFile(File s){
		if(null == this.hbmFiles){
			this.hbmFiles = new ArrayList<File>();
		}
		this.hbmFiles.add(s);
	}
	
	
	public String getCurrentTime() {
		return currentTime;
	}
	public void setCurrentTime(String currentTime) {
		this.currentTime = currentTime;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((org == null) ? 0 : org.hashCode());
		result = prime * result + ((project == null) ? 0 : project.hashCode());
		result = prime * result + ((root == null) ? 0 : root.hashCode());
		result = prime * result + ((src == null) ? 0 : src.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final AppProperty other = (AppProperty) obj;
		if (org == null) {
			if (other.org != null)
				return false;
		} else if (!org.equals(other.org))
			return false;
		if (project == null) {
			if (other.project != null)
				return false;
		} else if (!project.equals(other.project))
			return false;
		if (root == null) {
			if (other.root != null)
				return false;
		} else if (!root.equals(other.root))
			return false;
		if (src == null) {
			if (other.src != null)
				return false;
		} else if (!src.equals(other.src))
			return false;
		return true;
	}
	
	
	
}

