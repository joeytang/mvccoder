package com.wanmei.service;

import com.wanmei.domain.Security;
import com.wanmei.dao.SecurityDao;
import com.wanmei.common.service.BaseService;

/**
*
 * @author joeytang  
 * Date: 2012-03-20 18:17 
 * SpringSecurity全局配置service接口
*/
public interface SecurityService extends BaseService<Security,Integer,SecurityDao> {
	
}
