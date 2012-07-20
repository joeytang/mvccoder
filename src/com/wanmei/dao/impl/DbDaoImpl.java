package com.wanmei.dao.impl;

import com.wanmei.domain.Db;
import com.wanmei.dao.DbDao;
import com.wanmei.common.dao.impl.BaseDaoImpl;

import org.springframework.stereotype.Repository;

/**
 * @author joeytang
 * Date: 2012-03-20 18:17
 * 数据库配置模块dao
 */
@Repository("dbDao")
public class DbDaoImpl extends BaseDaoImpl<Db,Integer> implements DbDao{

}
