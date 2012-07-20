package com.wanmei.dao.impl;

import com.wanmei.domain.Controller;
import com.wanmei.dao.ControllerDao;
import com.wanmei.common.dao.impl.BaseDaoImpl;

import org.springframework.stereotype.Repository;

/**
 * @author joeytang
 * Date: 2012-03-20 18:17
 * 自定义的Controller模块dao
 */
@Repository("controllerDao")
public class ControllerDaoImpl extends BaseDaoImpl<Controller,Integer> implements ControllerDao{

}
