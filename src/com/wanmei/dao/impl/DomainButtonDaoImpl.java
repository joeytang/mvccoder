package com.wanmei.dao.impl;

import com.wanmei.domain.DomainButton;
import com.wanmei.dao.DomainButtonDao;
import com.wanmei.common.dao.impl.BaseDaoImpl;

import org.springframework.stereotype.Repository;

/**
 * @author joeytang
 * Date: 2012-03-22 11:02
 * 模块与按钮映射模块dao
 */
@Repository("domainButtonDao")
public class DomainButtonDaoImpl extends BaseDaoImpl<DomainButton,Integer> implements DomainButtonDao{

}
