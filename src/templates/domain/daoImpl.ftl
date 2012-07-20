package ${project.org}.dao.impl;

import ${domain.packageName}.${domain.name};
import ${project.org}.dao.${domain.name}Dao;
import ${project.org}.common.dao.impl.BaseDaoImpl;
<#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>
import ${domain.id.entityPackage}.${domain.id.entityName};
</#if>

import org.springframework.stereotype.Repository;

/**
 * @author joeytang
 * Date: ${project.currentTime}
 * ${domain.label}模块dao
 */
@Repository("${domain.name?uncap_first}Dao")
public class ${domain.name}DaoImpl extends BaseDaoImpl<${domain.name},<#if domain.isMany2ManyKey>${domain.name}<#elseif (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>${domain.id.entityName}<#else>${domain.id.primaryType}</#if>> implements ${domain.name}Dao{

}
