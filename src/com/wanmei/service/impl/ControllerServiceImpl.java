package com.wanmei.service.impl;

import com.wanmei.dao.ControllerDao;
import com.wanmei.domain.Controller;
import com.wanmei.service.ControllerService;
import com.wanmei.common.service.impl.BaseServiceImpl;
import org.springframework.stereotype.Service;

/**
 * @author joeytang  
 * Date: 2012-03-20 18:17
 * 自定义的Controller模块service
 */
@Service("controllerService")
public class ControllerServiceImpl  extends BaseServiceImpl<Controller,Integer,ControllerDao>  implements ControllerService {
	
}
