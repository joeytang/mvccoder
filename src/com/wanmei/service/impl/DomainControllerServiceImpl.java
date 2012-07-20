package com.wanmei.service.impl;

import com.wanmei.dao.DomainControllerDao;
import com.wanmei.domain.DomainController;
import com.wanmei.service.DomainControllerService;
import com.wanmei.common.service.impl.BaseServiceImpl;
import org.springframework.stereotype.Service;

/**
 * @author joeytang  
 * Date: 2012-03-21 17:54
 * 模块与Controller映射模块service
 */
@Service("domainControllerService")
public class DomainControllerServiceImpl  extends BaseServiceImpl<DomainController,Integer,DomainControllerDao>  implements DomainControllerService {
	
}
