package com.wanmei.service;

import com.wanmei.domain.Domain;
import com.wanmei.dao.DomainDao;
import com.wanmei.common.service.BaseService;

/**
*
 * @author joeytang  
 * Date: 2012-03-20 18:17 
 * 模块service接口
*/
public interface DomainService extends BaseService<Domain,Integer,DomainDao> {

	/**
	 * 组装domain对象。将domain关联的列和Controller全部装载
	 * @param id
	 * @return
	 */
	Domain weirDomain(Integer id);
	
}
