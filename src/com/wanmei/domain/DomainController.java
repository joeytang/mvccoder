package com.wanmei.domain;

import com.wanmei.domain.Controller;
import java.util.Date;
import com.wanmei.domain.Domain;
/**
 * @author joeytang
 * Date: 2012-03-21 17:54
 * DomainController
 */
public class DomainController implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private Domain domain;
	private Controller controller;
	private Date createTime = new Date();
	public DomainController() {
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
	public void setController(Controller controller){
		this.controller = controller;
	}
	public Controller getController(){
		return this.controller;
	}
	public void setCreateTime(Date createTime){
		this.createTime = createTime;
	}
	public Date getCreateTime(){
		return this.createTime;
	}
	
	

}
