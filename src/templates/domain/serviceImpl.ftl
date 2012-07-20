package ${project.org}.service.impl;

import ${project.org}.dao.${domain.name}Dao;
import ${domain.packageName}.${domain.name};
<#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>
import ${domain.id.entityPackage}.${domain.id.entityName};
</#if>
<#list domain.many2ManyRelationFields as f>
import ${project.org}.dao.${project.domainMap[f.entityName].name}Dao;
import ${project.domainMap[f.entityName].packageName}.${project.domainMap[f.entityName].name};
</#list>
import ${project.org}.service.${domain.name}Service;
import ${project.org}.common.service.impl.BaseServiceImpl;
import org.springframework.stereotype.Service;
<#if domain.many2ManyRelationFields?? && (domain.many2ManyRelationFields?size > 0)>
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
</#if>

/**
 * @author joeytang  
 * Date: ${project.currentTime}
 * ${domain.label}模块service
 */
@Service("${domain.name?uncap_first}Service")
public class ${domain.name}ServiceImpl  extends BaseServiceImpl<${domain.name},<#if domain.isMany2ManyKey>${domain.name}<#elseif (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>${domain.id.entityName}<#else>${domain.id.primaryType}</#if>,${domain.name}Dao>  implements ${domain.name}Service {
	<#list domain.many2ManyRelationFields as f>
	@Autowired
	private ${project.domainMap[f.entityName].name}Dao ${project.domainMap[f.entityName].name?uncap_first}Dao;
	</#list>
	<#list domain.many2ManyRelationFields as f>
	@Override
	public List<${project.domainMap[f.entityName].name}> list${f.entityName}By${domain.name}Id(${domain.id.primaryType} id,int pageNo,int pageSize){
		String hql = "select ${f.name} from ${domain.name} ${domain.name?uncap_first} join ${domain.name?uncap_first}.${f.name} ${f.name} where ${domain.name?uncap_first}.${domain.id.name}=? ";
		return ${project.domainMap[f.entityName].name?uncap_first}Dao.findPaged(hql,
				(pageNo - 1) * pageSize, pageSize,id);
	}
	@Override
	public int count${f.entityName}By${domain.name}Id(${domain.id.primaryType} id){
		String hql = "select count(${f.name}) from ${domain.name} ${domain.name?uncap_first} join ${domain.name?uncap_first}.${f.name} ${f.name} where ${domain.name?uncap_first}.${domain.id.name}=? ";
		return ${project.domainMap[f.entityName].name?uncap_first}Dao.count(hql,id);
	}
	</#list>
	
	<#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>
	@Override
	public ${domain.name} save(${domain.name} entity) {
		if(null == entity){
			throw new RuntimeException("${domain.name} entity is null");
		}
		if(null == entity.get${domain.id.name?cap_first}()){
			entity.validId();
			return this.baseDao.save(entity);
		}else{
			return this.baseDao.saveOrUpdate(entity);
		}
	}
	</#if>
}
