package com.wanmei.dao.impl;

import com.wanmei.domain.Dao;
import com.wanmei.dao.DaoDao;
import com.wanmei.common.dao.impl.BaseDaoImpl;

import org.springframework.stereotype.Repository;

/**
 * @author joeytang
 * Date: 2012-03-20 18:17
 * Dao全局配置模块dao
 */
@Repository("daoDao")
public class DaoDaoImpl extends BaseDaoImpl<Dao,Integer> implements DaoDao{

}
