package com.wanmei.domain;


import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.wanmei.domain.helper.UserHelper;
/**
 * @author joeytang
 * Date: 2012-03-20 18:17
 * User
 */
public class User implements java.io.Serializable,UserDetails {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String username;
	private String password;
	private String nickname;
	private String role;
	private Byte status;
	public User() {
	}
	public void setId(Integer id){
		this.id = id;
	}
	public Integer getId(){
		return this.id;
	}
	public void setUsername(String username){
		this.username = username;
	}
	@Override
	public String getUsername(){
		return this.username;
	}
	public void setPassword(String password){
		this.password = password;
	}
	@Override
	public String getPassword(){
		return this.password;
	}
	public void setNickname(String nickname){
		this.nickname = nickname;
	}
	public String getNickname(){
		return this.nickname;
	}
	public void setRole(String role){
		this.role = role;
	}
	public String getRole(){
		return this.role;
	}
	public void setStatus(Byte status){
		this.status = status;
	}
	public Byte getStatus(){
		return this.status;
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

	@Override
	public boolean isEnabled(){
		if(null != status && status == UserHelper.STATUS_OK){
			return true;
		}
		return false;
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
				+ ((username == null) ? 0 : username.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
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
		if (username == null) {
			if (other.username != null)
				return false;
		} else if (!username.equals(other.username))
			return false;
		return true;
	}
	

}
