package com.wanmei.service.impl;

import com.wanmei.dao.UserDao;
import com.wanmei.domain.User;
import com.wanmei.service.UserService;
import com.wanmei.common.service.impl.BaseServiceImpl;
import org.springframework.stereotype.Service;

/**
 * @author joeytang  
 * Date: 2012-03-20 18:17
 * 用户模块service
 */
@Service("userService")
public class UserServiceImpl  extends BaseServiceImpl<User,Integer,UserDao>  implements UserService {
	
}
