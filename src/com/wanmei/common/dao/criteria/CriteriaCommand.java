package com.wanmei.common.dao.criteria;

import org.hibernate.Criteria;

/**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * 执行接口
 */
public interface CriteriaCommand {
    public Criteria execute(Criteria criteria);
}
