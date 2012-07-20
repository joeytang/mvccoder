package com.wanmei.dao.impl;

import com.wanmei.domain.Action;
import com.wanmei.dao.ActionDao;
import com.wanmei.common.dao.impl.BaseDaoImpl;

import org.springframework.stereotype.Repository;

/**
 * @author joeytang
 * Date: 2012-03-20 18:17
 * Action全局配置模块dao
 */
@Repository("actionDao")
public class ActionDaoImpl extends BaseDaoImpl<Action,Integer> implements ActionDao{

}
