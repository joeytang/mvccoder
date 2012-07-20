package ${project.org}.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.lang.StringUtils;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 属性文件工具类
 */
public class PropertiesUtil {
     public PropertiesUtil() {
    }
    private static Map<String,Properties> propertiesMap = new ConcurrentHashMap<String,Properties>();

    public static Properties getProperties(String filename) throws IOException {
        Properties p = new Properties();
        InputStream in = null;
        try {
            in = PropertiesUtil.class.getResource(filename).openStream();
            p.load(in);
        } catch (IOException e) {
        	throw e;
        } finally {
            if(null != in){
        		in.close();
        	}
        }
        return p;
    }

    public static String getProperty(String filename, String key) throws IOException {
    	if(StringUtils.isBlank(filename) || StringUtils.isBlank(key)){
    		return null;
    	}
        Properties p = null;
        try {
        	p = propertiesMap.get(filename);
        	if(null == p){
        		p = getProperties(filename);
        		if(null != p){
        			propertiesMap.put(filename, p);
        		}
        	}
        } catch (IOException e) {
        	throw e;
        } 
        return p.getProperty(key);
    }
}
