package com.wanmei.dao.impl;

import com.wanmei.domain.Project;
import com.wanmei.dao.ProjectDao;
import com.wanmei.common.dao.impl.BaseDaoImpl;

import org.springframework.stereotype.Repository;

/**
 * @author joeytang
 * Date: 2012-03-20 18:17
 * 项目模块dao
 */
@Repository("projectDao")
public class ProjectDaoImpl extends BaseDaoImpl<Project,Integer> implements ProjectDao{

}
