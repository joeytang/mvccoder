package com.wanmei.service.impl;

import com.wanmei.dao.FieldDao;
import com.wanmei.domain.Field;
import com.wanmei.service.FieldService;
import com.wanmei.common.service.impl.BaseServiceImpl;
import org.springframework.stereotype.Service;

/**
 * @author joeytang  
 * Date: 2012-03-20 18:17
 * 字段模块service
 */
@Service("fieldService")
public class FieldServiceImpl  extends BaseServiceImpl<Field,Integer,FieldDao>  implements FieldService {
	
}
