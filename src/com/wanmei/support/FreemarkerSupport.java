package com.wanmei.support;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

/**
 * freemarker相关处理
 * @author joeytang
 *
 */
@Service
public class FreemarkerSupport {
	@Autowired
	private FreeMarkerConfigurer freeMarkerConfigurer;
	
	
	
}
