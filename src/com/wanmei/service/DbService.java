package com.wanmei.service;

import com.wanmei.domain.Db;
import com.wanmei.dao.DbDao;
import com.wanmei.common.service.BaseService;

/**
*
 * @author joeytang  
 * Date: 2012-03-20 18:17 
 * 数据库配置service接口
*/
public interface DbService extends BaseService<Db,Integer,DbDao> {
	
}
