package ${project.org}.domain.helper;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 */
public class ${domain.name}Helper {

	<#list domain.dictFields as f>
	/**
	 * ${f.label}
	 */
	public final static ${f.lowPrimaryType} ${f.name?upper_case}_1 = ${f.dictValue};
	public static Map<${f.primaryType},String> ${f.name}Map = new LinkedHashMap<${f.primaryType},String>();
    static {
    	${f.name}Map.put(${f.name?upper_case}_1, "${f.label}1请在${domain.name}Helper中修改");
    }
	</#list>
}