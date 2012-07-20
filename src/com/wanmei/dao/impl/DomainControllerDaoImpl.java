package com.wanmei.dao.impl;

import com.wanmei.domain.DomainController;
import com.wanmei.dao.DomainControllerDao;
import com.wanmei.common.dao.impl.BaseDaoImpl;

import org.springframework.stereotype.Repository;

/**
 * @author joeytang
 * Date: 2012-03-21 17:54
 * 模块与Controller映射模块dao
 */
@Repository("domainControllerDao")
public class DomainControllerDaoImpl extends BaseDaoImpl<DomainController,Integer> implements DomainControllerDao{

}
