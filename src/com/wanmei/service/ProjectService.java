package com.wanmei.service;

import com.wanmei.domain.Project;
import com.wanmei.dao.ProjectDao;
import com.wanmei.common.service.BaseService;

/**
*
 * @author joeytang  
 * Date: 2012-03-20 18:17 
 * 项目service接口
*/
public interface ProjectService extends BaseService<Project,Integer,ProjectDao> {

	/**
	 * 组装project，将project关联的所有信息，如domains组装进来
	 * @param id
	 * @return
	 */
	Project wireProject(Integer id);
	
}
