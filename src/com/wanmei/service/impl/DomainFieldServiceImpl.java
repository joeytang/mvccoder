package com.wanmei.service.impl;

import com.wanmei.dao.DomainFieldDao;
import com.wanmei.domain.DomainField;
import com.wanmei.service.DomainFieldService;
import com.wanmei.common.service.impl.BaseServiceImpl;
import org.springframework.stereotype.Service;

/**
 * @author joeytang  
 * Date: 2012-03-20 18:17
 * 模块与列属性映射模块service
 */
@Service("domainFieldService")
public class DomainFieldServiceImpl  extends BaseServiceImpl<DomainField,Integer,DomainFieldDao>  implements DomainFieldService {
	
}
