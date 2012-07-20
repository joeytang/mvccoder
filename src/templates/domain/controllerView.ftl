package ${project.org}.web.controller<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>.view</#if>;

import ${project.org}.common.controller.MvcControllerTemplate;
import ${domain.packageName}.${domain.name};
import ${project.org}.service.${domain.name}Service;
<#if domain.isMultipart || !domain.disabledControllers?? || domain.disabledControllers?index_of("save") == -1>
import net.sf.json.JSONObject;
import ${project.org}.util.RenderUtils;
</#if>
<#if ( !domain.disabledControllers?? || domain.disabledControllers?index_of("save") == -1 ) && domain.editableFields?size gt 0>
import ${project.org}.util.ValidateUtils;
</#if>
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
<#if !domain.disabledControllers?? || domain.disabledControllers?index_of("save") == -1>
<#if domain.isMultipart>
import org.apache.commons.lang.StringUtils;
</#if>
</#if>

/**
 * @author joeytang
 * Date: 2011-11-21 10:42
 * ${domain.label}action
 */
@Controller<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>("view${domain.name}Action")</#if>
@RequestMapping("<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/view</#if>/${domain.name?uncap_first}")
public class ${domain.name}Controller  extends MvcControllerTemplate<${domain.name},<#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>${domain.id.entityName}<#else>${domain.id.primaryType}</#if>,${domain.name}Service>  {

	<#if !domain.disabledControllers?? || domain.disabledControllers?index_of("input") == -1>
	/**
	 * 添加或修改对象
	 * 
	 * @return 返回到模块下input.jsp
	 * @throws Exception
	 */
	@RequestMapping(value = "/input")
	public String input(HttpServletRequest request, ${domain.name} ${domain.lowerFirstName}, ModelMap modelMap)
			throws Exception {
		return super.input(request,${domain.lowerFirstName},modelMap);
	}
	</#if>
	
	<#if !(domain.disabledControllers??) || domain.disabledControllers?index_of("remove") == -1>
	/**
	 * 删除对象
	 * 
	 * @return
	 */
	@RequestMapping(value = "/remove")
	public void remove(HttpServletRequest request,HttpServletResponse response, ${domain.name} ${domain.lowerFirstName}, ModelMap modelMap)
			throws Exception{
		super.remove(request, response, ${domain.lowerFirstName}, modelMap);
	}
	</#if>
	
	<#if !(domain.disabledControllers??) || domain.disabledControllers?index_of(",removeMore,") == -1>
	/**
	 * 批量删除对象
	 * 
	 * @return
	 */
	@RequestMapping(value = "/removeMore")
	public void removeMore(HttpServletRequest request,HttpServletResponse response, ${domain.id.primaryType}[] ids, ModelMap modelMap)
			throws Exception{
		super.removeMore(request, response, ids, modelMap);
	}
	</#if>
	
	
	<#if !(domain.disabledControllers??) || domain.disabledControllers?index_of("list") == -1>
	/**
	 * 列出所有的对象
	 * 
	 * @param request
	 * @param modelMap
	 * @return 返回到模块下list.jsp
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request, ${domain.name} ${domain.lowerFirstName},
			Integer pageNo, Integer pageSize, ModelMap modelMap)
			throws Exception{
		return super.list(request, ${domain.lowerFirstName},pageNo,pageSize, modelMap);
	}
	</#if>
	
	<#if !domain.disabledControllers?? || domain.disabledControllers?index_of("save") == -1>
	/**
	 * 保存对象
	 * 
	 * @return {模块名：保存的对象}
	 */
	@RequestMapping(value = "/save")
	public void save(HttpServletRequest request,HttpServletResponse response, ${domain.name} ${domain.lowerFirstName},
			ModelMap modelMap) throws Exception {
		super.save(request,response,${domain.lowerFirstName}, modelMap);
	}
			
	@Override
	public JSONObject preSave(HttpServletRequest request, ${domain.name} domain,
			ModelMap modelMap) {
		JSONObject json = null;
		if(null == domain){
			json = RenderUtils.getJsonSuccess();
			json.put(RenderUtils.KEY_ERROR,"请求出错，重新提交");
			return json;
		}
		<#list domain.editableFields as f>
		<#if f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_INT ||  f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_LONG >
		if(!ValidateUtils.isValidateDeci(domain.get${f.name?cap_first}(),4,0,0,10000,<#if f.nullable>true<#else>false</#if>)){
			json = RenderUtils.getJsonSuccess();
			json.put(RenderUtils.KEY_ERROR,"${f.label}<#if !f.nullable>不能为空,且</#if>在0-10000之间！");
			return json;
	    }
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_FLOAT) || (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_DOUBLE)>	
	    if(!ValidateUtils.isValidateDeci(domain.get${f.name?cap_first}(),4,2,0,10000,<#if f.nullable>true<#else>false</#if>)){
			json = RenderUtils.getJsonSuccess();
			json.put(RenderUtils.KEY_ERROR,"${f.label}<#if !f.nullable>不能为空,且</#if>在0-10000之间！");
			return json;
	    }
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_STRING)>		
	    if(!ValidateUtils.isStringLengthValidated(domain.get${f.name?cap_first}(),<#if f.nullable>0<#else>1</#if>,${(f.length?c)?default("250")})){
			json = RenderUtils.getJsonSuccess();
			json.put(RenderUtils.KEY_ERROR,"${f.label}<#if !f.nullable>不能为空,且</#if>不能大于${(f.length?c)?default("250")}字符！");
			return json;
	    }
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_BOOLEAN)>		
	    <#if (!f.nullable) >
	    if(domain.get${f.name?cap_first}() == null){
			json = RenderUtils.getJsonSuccess();
			json.put(RenderUtils.KEY_ERROR,"${f.label}必须选择！");
			return json;
	    }
	    </#if>
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_TEXT)>
		if(!ValidateUtils.isStringLengthValidated(domain.get${f.name?cap_first}(),<#if f.nullable>0<#else>1</#if>,${(f.length?c)?default("65500")})){
			json = RenderUtils.getJsonSuccess();
			json.put(RenderUtils.KEY_ERROR,"${f.label}<#if !f.nullable>不能为空,且</#if>不能大于${(f.length?c)?default("65500")}字符！");
			return json;
	    }
		</#if>
		</#list>
		<#list domain.fileFields as f>
		json = this.upload(request,null,"${f.name}File",null,null,null,<#if !f.nullable>domain.get${domain.id.name?cap_first}() == null<#else>true</#if>);
		if(!RenderUtils.isSuccess(json)){
			return json;
		}
	    if(StringUtils.isNotBlank(RenderUtils.getResult(json))){
		    domain.set${f.name?cap_first}(RenderUtils.getResult(json));
	    }
		</#list>
		return RenderUtils.getJsonSuccess();
	}
	</#if>
	
	<#if domain.id.name != "id">
	@Override
	protected String getIdName() {
		return "${domain.id.name}";
	}
	</#if>
	
}
