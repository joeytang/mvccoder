package com.wanmei.dao.impl;

import com.wanmei.domain.Field;
import com.wanmei.dao.FieldDao;
import com.wanmei.common.dao.impl.BaseDaoImpl;

import org.springframework.stereotype.Repository;

/**
 * @author joeytang
 * Date: 2012-03-20 18:17
 * 字段模块dao
 */
@Repository("fieldDao")
public class FieldDaoImpl extends BaseDaoImpl<Field,Integer> implements FieldDao{

}
