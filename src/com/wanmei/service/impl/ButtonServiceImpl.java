package com.wanmei.service.impl;

import com.wanmei.dao.ButtonDao;
import com.wanmei.domain.Button;
import com.wanmei.service.ButtonService;
import com.wanmei.common.service.impl.BaseServiceImpl;
import org.springframework.stereotype.Service;

/**
 * @author joeytang  
 * Date: 2012-03-22 11:02
 * 按钮模块service
 */
@Service("buttonService")
public class ButtonServiceImpl  extends BaseServiceImpl<Button,Integer,ButtonDao>  implements ButtonService {
	
}
