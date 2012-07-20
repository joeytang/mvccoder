package com.wanmei.service.impl;

import org.springframework.stereotype.Service;

import com.wanmei.common.service.impl.BaseServiceImpl;
import com.wanmei.dao.ProjectDomainDao;
import com.wanmei.domain.ProjectDomain;
import com.wanmei.service.ProjectDomainService;

/**
 * @author joeytang  
 * Date: 2012-03-20 18:17
 * ProjectDomain全局配置模块service
 */
@Service("projectDomainService")
public class ProjectDomainServiceImpl  extends BaseServiceImpl<ProjectDomain,Integer,ProjectDomainDao>  implements ProjectDomainService {
	
}
