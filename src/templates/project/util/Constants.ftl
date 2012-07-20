package ${project.org}.util;

<#if project.security.type==statics["com.wanmei.domain.SecurityHelper"].TYPE_COMPLEX>
import java.util.Map;
import java.util.LinkedHashMap;
import ${project.org}.security.domain.Resource;
</#if>

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 常量
 */
public class Constants {
    // 在分页中定义每页的显示记录数；
    public final static int PANGE_NUM = 15;

    public static final String VALIDATE_CODE_KEY_FOR_FACE_COMMENT = "guild_face_comment_rand";//验证码key
<#if project.security.type==statics["com.wanmei.domain.SecurityHelper"].TYPE_COMPLEX>
    private static Map<String, String> RESOURCETYPE = new LinkedHashMap<String, String>();
    
    public static Map<String, String> getResourceTypeMap() {
    	RESOURCETYPE.put(Resource.RESOURCE_TYPE_URL, "地址");
    	RESOURCETYPE.put(Resource.RESOURCE_TYPE_FUNCTION, "方法");
    	RESOURCETYPE.put(Resource.RESOURCE_TYPE_COMPONENT, "组件");
    	return RESOURCETYPE;
    }
    public static final String ROLE_PREFFIX = "ROLE_";//角色标识的前缀
    </#if>
}
