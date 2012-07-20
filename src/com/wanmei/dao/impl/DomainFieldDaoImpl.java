package com.wanmei.dao.impl;

import com.wanmei.domain.DomainField;
import com.wanmei.dao.DomainFieldDao;
import com.wanmei.common.dao.impl.BaseDaoImpl;

import org.springframework.stereotype.Repository;

/**
 * @author joeytang
 * Date: 2012-03-20 18:17
 * 模块与列属性映射模块dao
 */
@Repository("domainFieldDao")
public class DomainFieldDaoImpl extends BaseDaoImpl<DomainField,Integer> implements DomainFieldDao{

}
