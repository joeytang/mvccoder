package com.wanmei.dao.impl;

import org.springframework.stereotype.Repository;

import com.wanmei.common.dao.impl.BaseDaoImpl;
import com.wanmei.dao.ProjectDomainDao;
import com.wanmei.domain.ProjectDomain;

/**
 * @author joeytang
 * Date: 2012-03-20 18:17
 * ProjectDomain全局配置模块dao
 */
@Repository("projectDomainDao")
public class ProjectDomainDaoImpl extends BaseDaoImpl<ProjectDomain,Integer> implements ProjectDomainDao{

}
