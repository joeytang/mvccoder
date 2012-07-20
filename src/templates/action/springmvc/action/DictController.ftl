package ${project.org}.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import ${project.org}.util.RenderUtils;
<#list project.domains as domain>
<#if (domain.dictEditFields?size > 0 ) >
import ${project.org}.domain.helper.${domain.name}Helper;
</#if>
</#list>
/**
 * @author joeytang
 * Date: 2011-11-21 10:42
 * Url映射action
 */
@Controller 
@RequestMapping("/dict")
public class DictController {

	<#list project.domains as domain>
	<#list domain.dictEditFields as f>
	/**
	 * ${domain.label}${f.label}
	 * 
	 * @return
	 */
	@RequestMapping(value = "/${domain.lowerFirstName}${f.name?cap_first}")
	public void ${domain.lowerFirstName}${f.name?cap_first}(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap)
			throws Exception{
		RenderUtils.renderJson(response, ${domain.name}Helper.${f.name}Map.entrySet());
	}
	</#list>
	</#list>
	
	
}
