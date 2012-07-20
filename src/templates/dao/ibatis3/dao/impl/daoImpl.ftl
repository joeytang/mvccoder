package ${domain.domainPackage}.dao.impl;

import ${domain.domainRealPackage}.${domain.domainName};
import ${domain.domainPackage}.dao.${domain.domainName}Dao;
import ${project.org}.security.dao.impl.IbatisDaoImpl;

import org.springframework.stereotype.Repository;

/**
 * @author joeytang
 * Date: ${project.currentTime}
 * ${domain.domainCnName}模块dao
 */
@Repository("${domain.domainName?uncap_first}Dao")
public class ${domain.domainName}DaoImpl extends IbatisDaoImpl<${domain.domainName},${domain.idClass.simpleName}> implements ${domain.domainName}Dao{

}
