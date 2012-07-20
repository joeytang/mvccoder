package com.wanmei.dao.impl;

import com.wanmei.domain.Domain;
import com.wanmei.dao.DomainDao;
import com.wanmei.common.dao.impl.BaseDaoImpl;

import org.springframework.stereotype.Repository;

/**
 * @author joeytang
 * Date: 2012-03-20 18:17
 * 模块模块dao
 */
@Repository("domainDao")
public class DomainDaoImpl extends BaseDaoImpl<Domain,Integer> implements DomainDao{

}
