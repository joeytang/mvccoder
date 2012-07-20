package ${project.org}.dao;

import ${domain.packageName}.${domain.name};
import ${project.org}.common.dao.BaseDao;
<#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>
import ${domain.id.entityPackage}.${domain.id.entityName};
</#if>
/**
 * @author joeytang
 * Date: ${project.currentTime}
 * ${domain.label}dao接口
 */
public interface ${domain.name}Dao extends BaseDao<${domain.name},<#if domain.isMany2ManyKey>${domain.name}<#elseif (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>${domain.id.entityName}<#else>${domain.id.primaryType}</#if>> {
}
