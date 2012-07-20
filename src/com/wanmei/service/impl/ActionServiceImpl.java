package com.wanmei.service.impl;

import com.wanmei.dao.ActionDao;
import com.wanmei.domain.Action;
import com.wanmei.service.ActionService;
import com.wanmei.common.service.impl.BaseServiceImpl;
import org.springframework.stereotype.Service;

/**
 * @author joeytang  
 * Date: 2012-03-20 18:17
 * Action全局配置模块service
 */
@Service("actionService")
public class ActionServiceImpl  extends BaseServiceImpl<Action,Integer,ActionDao>  implements ActionService {
	
}
