package org.joey.security.domain;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 资源
 */
public class ResourceHelper {


	public static final String TYPE_URL = "URL";
    public static final String TYPE_FUNCTION = "FUNCTION";
    public static final String TYPE_COMPONENT = "COMPONENT";
    
    public static final Map<String,String> typeMap = new LinkedHashMap<String, String>();
    static{
    	typeMap.put(ResourceHelper.TYPE_URL,"地址");
    	typeMap.put(ResourceHelper.TYPE_FUNCTION,"方法");
    	typeMap.put(ResourceHelper.TYPE_COMPONENT,"组件");
    }
}