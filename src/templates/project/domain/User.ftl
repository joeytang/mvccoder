package ${project.org}.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;
import java.util.Collection;
<#if project.security.type==statics["com.wanmei.domain.SecurityHelper"].TYPE_COMPLEX>
import java.util.Set;
import java.util.HashSet;
<#else>
</#if>

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import ${project.org}.domain.helper.UserHelper;


/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 用户
 */
public class User<#if project.security.type==statics["com.wanmei.domain.SecurityHelper"].TYPE_COMPLEX> extends BaseAuthorizeDomain </#if> implements Serializable ,UserDetails {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private ${project.security.idType2ShortJavaType} <#if project.security.idNameIsId>id<#else>userId</#if>;
	private String account;
	private String email;
	private String password;
	private String userName;
	private Date createTime;
	private Byte status;
	<#if project.security.type==statics["com.wanmei.domain.SecurityHelper"].TYPE_COMPLEX>
	Set<Role> roles = new HashSet<Role>(0);
    <#else>
	private String role;
    </#if>
	
	public User() {
	}

	

	public ${project.security.idType2ShortJavaType} get<#if project.security.idNameIsId>Id<#else>UserId</#if>() {
		return this.<#if project.security.idNameIsId>id<#else>userId</#if>;
	}

	public void set<#if project.security.idNameIsId>Id<#else>UserId</#if>(${project.security.idType2ShortJavaType} <#if project.security.idNameIsId>id<#else>userId</#if>) {
		this.<#if project.security.idNameIsId>id<#else>userId</#if> = <#if project.security.idNameIsId>id<#else>userId</#if>;
	}

	public String getAccount() {
		return this.account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Byte getStatus() {
		return this.status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}
	<#if project.security.type==statics["com.wanmei.domain.SecurityHelper"].TYPE_COMPLEX>
	public Set<Role> getRoles(){
		return this.roles;
	}
	public void setRoles(Set<Role> roles){
		this.roles = roles;
	}
    public Collection<GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> grantedAuthorities = new ArrayList<GrantedAuthority>(roles.size());
        for (Role role : roles) {
            grantedAuthorities.add(new SimpleGrantedAuthority(role.getName()));
        }
        return grantedAuthorities;
    }
	public Set<Menu> getMenus(){
    	Set<Menu> allMenus = new HashSet<Menu>();
    	Set<Menu> list = new HashSet<Menu>();
    	if(null != this.roles){
    		for(Role r:roles){
    			Set<Menu> menus = r.getMenus();
    			if(null != menus){
    				for(Menu m:r.getMenus()){
    					allMenus.add(m);
    				}
    			}
    		}
    	}
    	organizeMenuTree(list,null,allMenus);
    	return list;
    }
    private void organizeMenuTree(Set<Menu> list,Menu menu,Collection<Menu> allMenus){
    	if(null != allMenus && null != list){
    		for(Menu m:allMenus){
    			boolean is = false;
    			if(null == menu && m.getParent() == null){
    				list.add(m);
    				is = true;
    			}else if(menu.equals(m.getParent())){
    				menu.getChildren().add(m);
    				is = true;
    			}
    			if(is){
    				allMenus.remove(m);
    				organizeMenuTree(list,m,allMenus);
    			}
    		}
    	}
    }
    <#else>
	public String getRole() {
		return this.role;
	}
	
	public void setRole(String role) {
		this.role = role;
	}
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> grantedAuthorities = new ArrayList<GrantedAuthority>();
		if(null != role){
			String[] roles  = role.split(",");
			if(roles != null){
				for(String r:roles){
					grantedAuthorities.add(new SimpleGrantedAuthority(r));
				}
			}
		}
        return grantedAuthorities;
	}
    </#if>

	@Override
	public boolean isEnabled(){
		if(null != status && status == UserHelper.STATUS_OK){
			return true;
		}
		return false;
	}
	
	@Override
	public String getUsername() {
		return this.account;
	}
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((account == null) ? 0 : account.hashCode());
		result = prime * result + ((<#if project.security.idNameIsId>id<#else>userId</#if> == null) ? 0 : <#if project.security.idNameIsId>id<#else>userId</#if>.hashCode());
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
		User other = (User) obj;
		if (account == null) {
			if (other.account != null)
				return false;
		} else if (!account.equals(other.account))
			return false;
		if (<#if project.security.idNameIsId>id<#else>userId</#if> == null) {
			if (other.<#if project.security.idNameIsId>id<#else>userId</#if> != null)
				return false;
		} else if (!<#if project.security.idNameIsId>id<#else>userId</#if>.equals(other.<#if project.security.idNameIsId>id<#else>userId</#if>))
			return false;
		return true;
	}
}


