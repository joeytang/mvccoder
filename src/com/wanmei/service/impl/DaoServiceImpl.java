package com.wanmei.service.impl;

import com.wanmei.dao.DaoDao;
import com.wanmei.domain.Dao;
import com.wanmei.service.DaoService;
import com.wanmei.common.service.impl.BaseServiceImpl;
import org.springframework.stereotype.Service;

/**
 * @author joeytang  
 * Date: 2012-03-20 18:17
 * Dao全局配置模块service
 */
@Service("daoService")
public class DaoServiceImpl  extends BaseServiceImpl<Dao,Integer,DaoDao>  implements DaoService {
	
}
