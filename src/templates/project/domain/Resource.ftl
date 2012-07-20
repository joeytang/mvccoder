package org.joey.security.domain;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 资源
 */
public class Resource extends BaseAuthorizeDomain implements ResourceDetails {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

    private ${project.security.idType2ShortJavaType} <#if project.security.idNameIsId>id<#else>resourceId</#if>;

    /**
     *   名称
     */
    private String name;

    /**
     * 类型
     */
    private String type;

    /**
     * 过滤条件
     */
    private String resString;

    /**
     * 描述
     */
    private String descn;

    private Set<Role> roles = new HashSet<Role>(0);

    private List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();

    public ${project.security.idType2ShortJavaType} get<#if project.security.idNameIsId>Id<#else>ResourceId</#if>() {
        return <#if project.security.idNameIsId>id<#else>resourceId</#if>;
    }

    public void set<#if project.security.idNameIsId>Id<#else>ResourceId</#if>(final ${project.security.idType2ShortJavaType} <#if project.security.idNameIsId>id<#else>resourceId</#if>) {
        this.<#if project.security.idNameIsId>id<#else>resourceId</#if> = <#if project.security.idNameIsId>id<#else>resourceId</#if>;
    }

    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(final String type) {
        this.type = type;
    }

    public String getResString() {
        return resString;
    }

    public void setResString(final String resString) {
        this.resString = resString;
    }

    public String getDescn() {
        return descn;
    }

    public void setDescn(final String descn) {
        this.descn = descn;
    }


    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(final Set<Role> roles) {
        this.roles = roles;
    }

    public String getResourceString() {
        return this.getResString();
    }

    public String getResourceType() {
        return this.getType();
    }

    public  Collection<GrantedAuthority> getAuthorities() {
        if (null != authorities && !authorities.isEmpty()) {
            return this.authorities;
        }

        for (Iterator<Role> iter = this.roles.iterator(); iter.hasNext();) {
            Role role =  iter.next();
            GrantedAuthority g = new SimpleGrantedAuthority(role.getName());
            authorities.add(g);
        }

        return authorities;
    }
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Resource resource = (Resource) o;
        if (id != null ? !id.equals(resource.id) : resource.id != null) return false;
        if (name != null ? !name.equals(resource.name) : resource.name != null) return false;
        if (resString != null ? !resString.equals(resource.resString) : resource.resString != null) return false;
        return !(type != null ? !type.equals(resource.type) : resource.type != null);

    }

    @Override
    public int hashCode() {
        int result = (null!=this.id?id.hashCode():0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (type != null ? type.hashCode() : 0);
        result = 31 * result + (resString != null ? resString.hashCode() : 0);
        return result;
    }
}