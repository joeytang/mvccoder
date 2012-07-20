package com.wanmei.dao.impl;

import com.wanmei.domain.Button;
import com.wanmei.dao.ButtonDao;
import com.wanmei.common.dao.impl.BaseDaoImpl;

import org.springframework.stereotype.Repository;

/**
 * @author joeytang
 * Date: 2012-03-22 11:02
 * 按钮模块dao
 */
@Repository("buttonDao")
public class ButtonDaoImpl extends BaseDaoImpl<Button,Integer> implements ButtonDao{

}
