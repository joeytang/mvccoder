package ${project.org}.service;

import ${domain.packageName}.${domain.name};
<#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>
import ${domain.id.entityPackage}.${domain.id.entityName};
</#if>
<#list domain.many2ManyRelationFields as f>
import ${project.domainMap[f.entityName].packageName}.${project.domainMap[f.entityName].name};
</#list>
import ${project.org}.dao.${domain.name}Dao;
import ${project.org}.common.service.BaseService;

<#if domain.many2ManyRelationFields?? && (domain.many2ManyRelationFields?size > 0)>
import java.util.List;
</#if>

/**
*
 * @author joeytang  
 * Date: ${project.currentTime} 
 * ${domain.label}service接口
*/
public interface ${domain.name}Service extends BaseService<${domain.name},<#if domain.isMany2ManyKey>${domain.name}<#elseif (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>${domain.id.entityName}<#else>${domain.id.primaryType}</#if>,${domain.name}Dao> {
	<#list domain.many2ManyRelationFields as f>
	/**
	 * 根据${domain.label}id列出关联的${f.label}
	 * @param id
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List<${project.domainMap[f.entityName].name}> list${f.entityName}By${domain.name}Id(${domain.id.primaryType} id,int pageNo,int pageSize);
	/**
	 * 根据${domain.label}id统计关联的${f.label}
	 * @param id
	 * @return
	 */
	public int count${f.entityName}By${domain.name}Id(${domain.id.primaryType} id);
	</#list>
}
