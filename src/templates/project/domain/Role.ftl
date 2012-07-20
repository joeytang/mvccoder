package org.joey.security.domain;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 角色
 */
public class Role extends BaseAuthorizeDomain implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ${project.security.idType2ShortJavaType} <#if project.security.idNameIsId>id<#else>roleId</#if>;
    /**
     * 名称
     */
    private String name;
    /**
     * 描述
     */
    private String descn;
    /**
     * 标题
     */
    private String title;


    private Set<User> users = new HashSet<User>(0);

    private Set<Resource> resources = new HashSet<Resource>(0);

    private Set<Menu> menus = new HashSet<Menu>(0);
    

    /**
	 * @return the id
	 */
	public ${project.security.idType2ShortJavaType} get<#if project.security.idNameIsId>Id<#else>RoleId</#if>() {
		return <#if project.security.idNameIsId>id<#else>roleId</#if>;
	}

	/**
	 * @param id the id to set
	 */
	public void set<#if project.security.idNameIsId>Id<#else>RoleId</#if>(${project.security.idType2ShortJavaType} <#if project.security.idNameIsId>id<#else>roleId</#if>) {
		this.<#if project.security.idNameIsId>id<#else>roleId</#if> = <#if project.security.idNameIsId>id<#else>roleId</#if>;
	}

	public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public String getDescn() {
        return descn;
    }

    public void setDescn(final String descn) {
        this.descn = descn;
    }
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Set<User> getUsers() {
        return users;
    }

    public void setUsers(final Set<User> users) {
        this.users = users;
    }
    public Set<Resource> getResources() {
        return resources;
    }

    public void setResources(final Set<Resource> resources) {
        this.resources = resources;
    }
    public Set<Menu> getMenus() {
        return menus;
    }

    public void setMenus(final Set<Menu> menus) {
        this.menus = menus;
    }

	@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Role role = (Role) o;

        if (id != null ? !id.equals(role.id) : role.id != null) return false;
        return !(name != null ? !name.equals(role.name) : role.name != null);

    }

    @Override
    public int hashCode() {
        int result = (null!=this.id?id.hashCode():0);
        result = 31 * result + (null!=this.name?this.name.hashCode():0);
        return result;
    }

    @Override
    public String toString() {
        return "Role{" +
                "name='" + name + '\'' +
                ", descn='" + descn + '\'' +
                ", id=" + id +
                '}';
    }
}

