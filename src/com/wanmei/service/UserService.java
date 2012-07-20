package com.wanmei.service;

import com.wanmei.domain.User;
import com.wanmei.dao.UserDao;
import com.wanmei.common.service.BaseService;

/**
*
 * @author joeytang  
 * Date: 2012-03-20 18:17 
 * 用户service接口
*/
public interface UserService extends BaseService<User,Integer,UserDao> {
	
}
