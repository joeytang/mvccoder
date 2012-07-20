package com.wanmei.service.impl;

import com.wanmei.dao.DbDao;
import com.wanmei.domain.Db;
import com.wanmei.service.DbService;
import com.wanmei.common.service.impl.BaseServiceImpl;
import org.springframework.stereotype.Service;

/**
 * @author joeytang  
 * Date: 2012-03-20 18:17
 * 数据库配置模块service
 */
@Service("dbService")
public class DbServiceImpl  extends BaseServiceImpl<Db,Integer,DbDao>  implements DbService {
	
}
