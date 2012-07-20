package com.wanmei.service.impl;

import com.wanmei.dao.SecurityDao;
import com.wanmei.domain.Security;
import com.wanmei.service.SecurityService;
import com.wanmei.common.service.impl.BaseServiceImpl;
import org.springframework.stereotype.Service;

/**
 * @author joeytang  
 * Date: 2012-03-20 18:17
 * SpringSecurity全局配置模块service
 */
@Service("securityService")
public class SecurityServiceImpl  extends BaseServiceImpl<Security,Integer,SecurityDao>  implements SecurityService {
	
}
