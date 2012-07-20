package com.wanmei.service.impl;

import com.wanmei.dao.DomainButtonDao;
import com.wanmei.domain.DomainButton;
import com.wanmei.service.DomainButtonService;
import com.wanmei.common.service.impl.BaseServiceImpl;
import org.springframework.stereotype.Service;

/**
 * @author joeytang  
 * Date: 2012-03-22 11:02
 * 模块与按钮映射模块service
 */
@Service("domainButtonService")
public class DomainButtonServiceImpl  extends BaseServiceImpl<DomainButton,Integer,DomainButtonDao>  implements DomainButtonService {
	
}
