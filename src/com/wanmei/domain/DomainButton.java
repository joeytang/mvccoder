package com.wanmei.domain;

import com.wanmei.domain.Button;
import java.util.Date;
import com.wanmei.domain.Domain;
/**
 * @author joeytang
 * Date: 2012-03-22 11:16
 * DomainButton
 */
public class DomainButton implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private Domain domain;
	private Button button;
	private Date createTime = new Date();
	public DomainButton() {
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
	public void setButton(Button button){
		this.button = button;
	}
	public Button getButton(){
		return this.button;
	}
	public void setCreateTime(Date createTime){
		this.createTime = createTime;
	}
	public Date getCreateTime(){
		return this.createTime;
	}
	
	

}
