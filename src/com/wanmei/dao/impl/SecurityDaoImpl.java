package com.wanmei.dao.impl;

import com.wanmei.domain.Security;
import com.wanmei.dao.SecurityDao;
import com.wanmei.common.dao.impl.BaseDaoImpl;

import org.springframework.stereotype.Repository;

/**
 * @author joeytang
 * Date: 2012-03-20 18:17
 * SpringSecurity全局配置模块dao
 */
@Repository("securityDao")
public class SecurityDaoImpl extends BaseDaoImpl<Security,Integer> implements SecurityDao{

}
