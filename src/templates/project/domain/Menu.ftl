package org.joey.security.domain;


import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
/**
 * User: joeytang
 * Date: ${project.currentTime}
 * Date: 2011-11-21 10:42
 * 菜单
 */

public class Menu extends BaseAuthorizeDomain implements Serializable {
  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ${project.security.idType2ShortJavaType} <#if project.security.idNameIsId>id<#else>menuId</#if>;
    /**
     * class
     */
    private String iconCls;
    /**
     * 描述
     */
    private String description;
    /**
     * 重定向
     */
    private String location;
    /**
     * 名字
     */
    private String name;
    /**
     * 标题
     */
    private String title;

    private Menu parent;

    private Set<Menu> children = new HashSet<Menu>(0);

    private Set<Role> roles = new HashSet<Role>(0);

    public ${project.security.idType2ShortJavaType} get<#if project.security.idNameIsId>Id<#else>MenuId</#if>() {
        return <#if project.security.idNameIsId>id<#else>menuId</#if>;
    }

    public void set<#if project.security.idNameIsId>Id<#else>MenuId</#if>(final ${project.security.idType2ShortJavaType} <#if project.security.idNameIsId>id<#else>menuId</#if>) {
        this.<#if project.security.idNameIsId>id<#else>menuId</#if> = <#if project.security.idNameIsId>id<#else>menuId</#if>;
    }

    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(final String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(final String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(final String location) {
        this.location = location;
    }

    public Menu getParent() {
        return parent;
    }

    public void setParent(final Menu parent) {
        this.parent = parent;
    }

    public Set<Menu> getChildren() {
        return children;
    }

    public void setChildren(final Set<Menu> menuItems) {
        this.children = menuItems;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(final Set<Role> roles) {
        this.roles = roles;
    }

    public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public void authorizeUser(Menu menu,User user){
		Set<Menu> items = menu.getChildren();
		if(null != items && items.size() > 0){
			for(Menu m:items){
				if(belongToUser(m,user)){
					authorizeUser(m,user);
				}else{
					items.remove(m);
				}
			}
		}
	}
	public void authorizeUser(User user){
		authorizeUser(this,user);
	}
	public boolean belongToUser(Menu menu,User user){
		Set<Role> userRoles = null;
		boolean belongTo = false;
		if(null != user && (userRoles = user.getRoles()) != null && userRoles.size() > 0){
			Set<Role> menuRoles = menu.getRoles();
			if(menuRoles != null ){
				for(Role r:menuRoles){
					if(userRoles.contains(r)){
						belongTo = true;
						break;
					}
				}
			}
		}
		return belongTo;
	}
	public boolean belongToUser(User user){
		return belongToUser(this,user);
	}

	@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Menu menu = (Menu) o;

        if (id != null ? !id.equals(menu.id) : menu.id != null) return false;
        return !(name != null ? !name.equals(menu.name) : menu.name != null);

    }

    @Override
    public int hashCode() {
        int result = (null != id ? id.hashCode() : 0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        return result;
    }
    
}

