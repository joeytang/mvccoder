package com.wanmei.dao.impl;

import com.wanmei.domain.User;
import com.wanmei.dao.UserDao;
import com.wanmei.common.dao.impl.BaseDaoImpl;

import org.springframework.stereotype.Repository;

/**
 * @author joeytang
 * Date: 2012-03-20 18:17
 * 用户模块dao
 */
@Repository("userDao")
public class UserDaoImpl extends BaseDaoImpl<User,Integer> implements UserDao{

}
