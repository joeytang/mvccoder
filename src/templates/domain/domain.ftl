package ${domain.packageName};

<#list domain.importFieldTypes as t>
import ${t};
</#list>
<#if domain.isUser>

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import ${project.org}.domain.helper.UserHelper;
</#if>
<#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>
import ${domain.id.entityPackage}.${domain.id.entityName};
</#if>
/**
 * @author joeytang
 * Date: ${project.currentTime}
 * ${domain.name}
 */
public class ${domain.name}<#if domain.isUser><#if project.security.type==statics["com.wanmei.domain.SecurityHelper"].TYPE_COMPLEX> extends BaseAuthorizeDomain </#if></#if> implements java.io.Serializable<#if domain.isUser>,UserDetails</#if> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	<#if domain.isMany2ManyKey>
	private ${domain.name} id = this; 
	</#if>
	<#list domain.allFields as f>
	<#if !domain.isComposeId || (domain.isComposeId && f.name != domain.id.name) >
	<#if (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_DATE) || (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_DATETIME)>
	private Date ${f.name};
	<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>
	private ${f.entityName} ${f.name};
	<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_ONE2MANY) || (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2MANY)>
	private Set<${f.entityName}> ${f.name} = new HashSet<${f.entityName}>(0);
	<#else>
	private ${f.primaryType} ${f.name};
	</#if>
	</#if>
	</#list>
	<#if domain.isComposeId>
	private static final String SEPERATOR = "_@_@_";
	</#if>
	public ${domain.name}() {
	}
	<#if domain.isMany2ManyKey >
	public ${domain.name}(<#assign ii=0><#list domain.allFields as f><#if (ii!=0)>, </#if><#assign ii=ii+1>${f.primaryType} ${f.name}</#list>) {
		<#list domain.allFields as f>
		this.${f.name} = ${f.name};
		</#list>
	}
	</#if>
	<#if domain.isComposeId>
	public ${domain.name}(<#assign ii=0><#list domain.fields as f><#if (ii!=0)>, </#if><#assign ii=ii+1>${f.primaryType} ${f.name}</#list>) {
		<#list domain.allFields as f>
		this.${f.name} = ${f.name};
		</#list>
	}
	</#if>
	<#if domain.isMany2ManyKey>
	public ${domain.name} getId(){
		return this.id;
	}
	public void setId(${domain.name} id){
		this.id = id;
	}
	</#if>
	<#list domain.allFields as f>
	<#if (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_DATE) || (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_DATETIME)>
	<#assign t="Date">
	<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>
	<#assign t="${f.entityName}">
	<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2MANY) || (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_ONE2MANY)>
	<#assign t="Set<${f.entityName}>">
	<#else>
	<#assign t="${f.primaryType}">
	</#if>
	public void set${f.name?cap_first}(${t} ${f.name}){
		<#if t=="Date">
		if(null != ${f.name}){
			this.${f.name} = new Date(${f.name}.getTime());
		}
		<#else>
		this.${f.name} = ${f.name};
		</#if>
	}
	<#if domain.isUser && ( f.name == 'username' || f.name == 'password' )>
	@Override
	</#if>
	public ${t} get${f.name?cap_first}(){
		
		<#if t=="Date">
		if(null != this.${f.name}){
			return new Date(this.${f.name}.getTime());
		}
		return null;
		<#else>
		return this.${f.name};
		</#if>
	}
	</#list>
	
	<#if domain.isUser>
	<#if project.security.type==statics["com.wanmei.domain.SecurityHelper"].TYPE_COMPLEX>
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
		if (username == null) {
			if (other.username != null)
				return false;
		} else if (!username.equals(other.username))
			return false;
		return true;
	}
	</#if>
	<#if domain.isComposeId>
	@Override
	public String toString() {
		return <#assign ii=0><#list domain.fields as f><#if (ii!=0)> + SEPERATOR + </#if><#assign ii=ii+1> ${f.name} </#list> ;
	}
	public static ${domain.name} convert(String val){
		if(null == val){
			return null;
		}
		val = val.trim();
		if(val.length() < 1){
			return null;
		}
		String[] as = val.split(SEPERATOR);
		if(as == null || as.length != ${domain.fields?size}){
			throw new RuntimeException("${domain.name} id param is wrong");
		}
		${domain.name} ${domain.name?uncap_first} = new ${domain.name}();
		<#assign ii=0>
		<#list domain.fields as f>
		${domain.name?uncap_first}.set${f.name?cap_first}(as[${ii}]);
		<#assign ii=ii+1>
		</#list>
		return ${domain.name?uncap_first};
	}
	</#if>
	<#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>
	public void validId(){
		if(null == ${domain.id.name}){
			this.${domain.id.name} = new ${domain.id.entityName}(<#assign ii=0><#list project.domainMap[domain.id.entityName].fields as f><#if (ii!=0)>,</#if>this.${f.name}<#assign ii=ii+1> </#list>);
		}
	}
	</#if>
}
