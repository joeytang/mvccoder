package ${project.org}.web.controller<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>.back</#if>;

import ${project.org}.common.controller.MvcControllerTemplate;
import ${domain.packageName}.${domain.name};
<#if domain.isUser>
import ${domain.packageName}.helper.${domain.name}Helper;
import ${project.org}.util.BeanHelper;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.ArrayList;
</#if>
import ${project.org}.support.SortBean;
import ${project.org}.service.${domain.name}Service;
<#if domain.searchSortField??>
import ${project.org}.common.dao.SqlFilter;
import ${project.org}.common.dao.SqlSort;
import ${project.org}.util.StringUtil;
import ${project.org}.tool.paging.CommonList;
import java.util.List;
</#if>
<#if domain.isMultipart || !domain.disabledControllers?? || domain.disabledControllers?index_of("save") == -1>
import net.sf.json.JSONObject;
import ${project.org}.util.RenderUtils;
</#if>
<#if ( !domain.disabledControllers?? || domain.disabledControllers?index_of("save") == -1 ) && domain.editableFields?size gt 0>
import ${project.org}.util.ValidateUtils;
</#if>
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
<#if !domain.disabledControllers?? || domain.disabledControllers?index_of("save") == -1>
<#if domain.isMultipart>
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import ${project.org}.support.MvcUploadSupport;
</#if>
</#if>
import org.apache.commons.lang.StringUtils;
/**
 * @author joeytang
 * Date: 2011-11-21 10:42
 * ${domain.label}action
 */
@Controller("back${domain.name}Action")
@RequestMapping("<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/security</#if>/${domain.name?uncap_first}")
public class ${domain.name}Action  extends MvcControllerTemplate<${domain.name},${domain.id.primaryType},${domain.name}Service>  {

	<#if !domain.disabledControllers?? || domain.disabledControllers?index_of("save") == -1>
	<#if domain.isMultipart>
	@Autowired
	MvcUploadSupport mvcUploadSupport;
	</#if>
	</#if>
	<#if !domain.disabledControllers?? || domain.disabledControllers?index_of("input") == -1>
	/**
	 * 添加对象
	 * 
	 * @return 返回到模块下input.jsp
	 * @throws Exception
	 */
	@RequestMapping(value = "/input")
	public String input(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap) {
		return super.input(request,response,modelMap);
	}
	</#if>
	<#if !domain.disabledControllers?? || domain.disabledControllers?index_of("update") == -1>
	/**
	 * 修改对象
	 * 
	 * @return 返回到模块下input.jsp
	 * @throws Exception
	 */
	@RequestMapping(value = "/update/{id}")
	public String update(HttpServletRequest request,HttpServletResponse response, @PathVariable ${domain.id.primaryType} id, ModelMap modelMap) {
		return super.update(request,response,id,modelMap);
	}
	</#if>
	
	<#if !domain.disabledControllers?? || domain.disabledControllers?index_of("view") == -1>
	/**
	 * 查看对象
	 * 
	 * @return 返回到模块下view.jsp
	 * @throws Exception
	 */
	@RequestMapping(value = "/view/{id}")
	public String view(HttpServletRequest request,HttpServletResponse response, @PathVariable ${domain.id.primaryType} id, ModelMap modelMap) {
		return super.view(request,response,id,modelMap);
	}
	</#if>
	
	<#if !(domain.disabledControllers??) || domain.disabledControllers?index_of("remove") == -1>
	/**
	 * 删除对象
	 * 
	 * @return
	 */
	@RequestMapping(value = "/remove/{id}")
	public void remove(HttpServletRequest request,HttpServletResponse response,  @PathVariable ${domain.id.primaryType} id, ModelMap modelMap) {
		super.remove(request, response,id, modelMap);
	}
	</#if>
	
	<#if !(domain.disabledControllers??) || domain.disabledControllers?index_of(",removeMore,") == -1>
	/**
	 * 批量删除对象
	 * 
	 * @return
	 */
	@RequestMapping(value = "/removeMore")
	public void removeMore(HttpServletRequest request,HttpServletResponse response, ${domain.id.primaryType}[] ids, ModelMap modelMap) {
		super.removeMore(request, response, ids, modelMap);
	}
	</#if>
	
	
	<#if !(domain.disabledControllers??) || domain.disabledControllers?index_of("list") == -1>
	/**
	 * 进入模块管理页面
	 * 
	 * @param request
	 * @param modelMap
	 * @return 返回到模块下main.jsp
	 * @throws Exception
	 */
	@RequestMapping(value = "/main")
	public String main(HttpServletRequest request,HttpServletResponse response, ${domain.name} ${domain.lowerFirstName},
			Integer pageNo, Integer pageSize, ModelMap modelMap) {
		return super.main(request,response, ${domain.lowerFirstName},pageNo,pageSize, modelMap);
	}
	/**
	 * 列出所有的对象
	 * 
	 * @param request
	 * @param modelMap
	 * @return 返回到模块下list.jsp
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request,HttpServletResponse response, ${domain.name} ${domain.lowerFirstName},SortBean sort,
			Integer pageNo, Integer pageSize, ModelMap modelMap) {
		<#if domain.searchSortField??>
		// 查找当前页
		if (null == pageSize) {
			pageSize = this.pageSize;
		}
		if (null == pageNo) {
			pageNo = 1;
		}
		pageNo = Math.max(1, pageNo);
		SqlFilter filter = new SqlFilter();
		StringBuffer searchStr = new StringBuffer();
		<#list domain.searchSortField as f>
		<#if (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_STRING)>
		if(StringUtils.isNotBlank(${domain.lowerFirstName}.get${f.name?cap_first}())){
			filter.addFilter("${f.name}", ${domain.lowerFirstName}.get${f.name?cap_first}(),SqlFilter.OP.like);
			searchStr.append("&${f.name}="+${domain.lowerFirstName}.get${f.name?cap_first}());
		}		
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_TEXT)>
		if(StringUtils.isNotBlank(${domain.lowerFirstName}.get${f.name?cap_first}())){
			filter.addFilter("${f.name}", ${domain.lowerFirstName}.get${f.name?cap_first}(),SqlFilter.OP.like);
			searchStr.append("&${f.name}="+${domain.lowerFirstName}.get${f.name?cap_first}());
		}		
		<#else>
		if(null != ${domain.lowerFirstName}.get${f.name?cap_first}()){
			filter.addFilter("${f.name}", ${domain.lowerFirstName}.get${f.name?cap_first}());
			searchStr.append("&${f.name}="+${domain.lowerFirstName}.get${f.name?cap_first}());
		}
		</#if>
		</#list>
		SqlSort sqlSort = new SqlSort();
		if(null == sort || StringUtils.isBlank(sort.getSortProperty())){
			sqlSort.addSort(this.getIdName(), "desc");
		}else{
			sqlSort.addSort(sort.getSortProperty(), sort.getSortOrder());
		}
		List<${domain.name}> ts = baseService.list(filter, sqlSort, pageNo, pageSize);
		int size = baseService.count(filter);
		modelMap.put(StringUtil.lowerFirstChar(className), ${domain.lowerFirstName});
		modelMap.put(StringUtil.lowerFirstChar(className) + "s", ts);
		if(null != sort && StringUtils.isNotBlank(sort.getSortProperty())){
			modelMap.put("sort", sort);
		}
		CommonList commonList = new CommonList(size, pageNo, pageSize);
		commonList.setSearchStr(searchStr.toString());
		modelMap.put("commonList", commonList);
		return StringUtil.lowerFirstChar( className)+"/list";
		<#else>
		return super.list(request,response, ${domain.lowerFirstName},sort,pageNo,pageSize, modelMap);
		</#if>
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
			ModelMap modelMap) {
		super.save(request,response,${domain.lowerFirstName}, modelMap);
	}
	<#if !domain.isUser>
	@Override
	public JSONObject preSave(HttpServletRequest request, ${domain.name} domain,
			ModelMap modelMap) {
		JSONObject json = null;
		if(null == domain){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"请求出错，重新提交");
			return json;
		}
		<#list domain.editableFields as f>
		<#if f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_INT ||  f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_LONG >
		if(!ValidateUtils.isValidateDeci(domain.get${f.name?cap_first}(),4,0,0,10000,<#if f.nullable>true<#else>false</#if>)){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"${f.label}<#if !f.nullable>不能为空,且</#if>在0-10000之间！");
			return json;
	    }
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_FLOAT) || (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_DOUBLE)>	
	    if(!ValidateUtils.isValidateDeci(domain.get${f.name?cap_first}(),4,2,0,10000,<#if f.nullable>true<#else>false</#if>)){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"${f.label}<#if !f.nullable>不能为空,且</#if>在0-10000之间！");
			return json;
	    }
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_STRING)>		
	    if(!ValidateUtils.isStringLengthValidated(domain.get${f.name?cap_first}(),<#if f.nullable>0<#else>1</#if>,${(f.length?c)?default("250")})){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"${f.label}<#if !f.nullable>不能为空,且</#if>不能大于${(f.length?c)?default("250")}字符！");
			return json;
	    }
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_BOOLEAN)>		
	    <#if (!f.nullable) >
	    if(domain.get${f.name?cap_first}() == null){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"${f.label}必须选择！");
			return json;
	    }
	    </#if>
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_TEXT)>
		if(!ValidateUtils.isStringLengthValidated(domain.get${f.name?cap_first}(),<#if f.nullable>0<#else>1</#if>,${(f.length?c)?default("65500")})){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"${f.label}<#if !f.nullable>不能为空,且</#if>不能大于${(f.length?c)?default("65500")}字符！");
			return json;
	    }
		</#if>
		</#list>
		<#if domain.isMultipart>
		MultipartHttpServletRequest mReq = (MultipartHttpServletRequest)request;
		<#list domain.fileFields as f>
		json = mvcUploadSupport.upload(mReq,null,"${f.name}File",null,null,null,<#if !f.nullable>domain.get${domain.id.name?cap_first}() == null<#else>true</#if>);
		if(!RenderUtils.isSuccess(json)){
			return json;
		}
	    if(StringUtils.isNotBlank(RenderUtils.getResult(json))){
		    domain.set${f.name?cap_first}(RenderUtils.getResult(json));
	    }
		</#list>
		</#if>
		return RenderUtils.getStatusOk();
	}
	<#else>
	@Override
	public JSONObject preSave(HttpServletRequest request, User user,
			ModelMap modelMap) {
		modelMap.put("user", user);
		JSONObject json = null;
		if(null == user){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"请求出错，重新提交");
			return json;
		}
		if(!ValidateUtils.isStringLengthValidated(user.getUsername(),1,50)){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"用户名在1-50个字符！");
			return json;
	    }
        User existUser = null;
    	SqlFilter filter = new SqlFilter();
    	filter.addFilter("username", user.getUsername().trim());
    	List<User> us = this.baseService.list(filter, null, -1, -1);
    	if(null != us && us.size() > 0){
    		existUser = us.get(0);
    	}
        if (null == user.getId()) {
        	if(null != existUser){
        		json = RenderUtils.getStatusValidParam();
            	json.put(RenderUtils.KEY_ERROR,"该帐号已经存在！");
                return json;
        	}
            user.setStatus(UserHelper.STATUS_OK);
            if(StringUtils.isBlank(user.getRole())){
            	user.setRole(UserHelper.ROLE_ADMIN);
            }
            user.setPassword(StringUtils.isBlank(user.getPassword())?"1":user.getPassword());
        }else{
    		User old = this.baseService.get(user.getId());
    		if(!old.getUsername().equals(user.getUsername()) && null != existUser ){
    			json = RenderUtils.getStatusValidParam();
            	json.put(RenderUtils.KEY_ERROR,"该帐号已经存在！");
                return json;
    		}
    		BeanHelper.copyNotNullProperties(user, old);
    		BeanHelper.copyNotNullProperties(old, user);
        }
        json = RenderUtils.getStatusOk();
		return json;
	}
	</#if>
	</#if>
<#if domain.isUser>
	/**
	 * 检查账号是否有重复
	 * 
	 * @return
	 */
	@RequestMapping(value = "/checkUsername")
	public void checkUsername(HttpServletRequest request,HttpServletResponse response,Integer id,@RequestParam String username, ModelMap modelMap)
			throws Exception{
		JSONObject json = null;
		try{
			if(null != id){
				User oldUser = baseService.get(id);
				if(null != oldUser && null != oldUser.getUsername() && null != username && oldUser.getUsername().equals(username)){
					json = RenderUtils.getStatusOk();
					RenderUtils.renderJson(response, json);
					return;
				}
			}
			SqlFilter filter = new SqlFilter();
			if(StringUtils.isNotBlank(username)){
				filter.addFilter("username", username);
			}
			int count = baseService.count(filter);
			if(count > 0){
				json = RenderUtils.getStatusValidParam();
				json.put(RenderUtils.KEY_ERROR, "该账号已经存在");
			}else{
				json = RenderUtils.getStatusOk();
			}
		}catch(RuntimeException e){
			json = RenderUtils.getStatusSystem();
			json.put(RenderUtils.KEY_ERROR, "查询错误");
		}
		RenderUtils.renderJson(response, json);
	}
	/**
	 * 批量禁用对象
	 * 
	 * @return
	 */
	@RequestMapping(value = "/disableMore")
	public void disableMore(HttpServletRequest request,HttpServletResponse response, Integer[] ids, ModelMap modelMap)
			throws Exception{
		JSONObject json = null;
		try {
			json = updateStatus(request,ids,modelMap,UserHelper.STATUS_DELETED);
		} catch (RuntimeException e) {
			json = RenderUtils.getStatusSystem();
		}
		RenderUtils.renderJson(response, json);
	}
	/**
	 * 批量启用对象
	 * 
	 * @return
	 */
	@RequestMapping(value = "/enableMore")
	public void enableMore(HttpServletRequest request,HttpServletResponse response, Integer[] ids, ModelMap modelMap)
			throws Exception{
		JSONObject json = null;
		try {
			json = updateStatus(request,ids,modelMap,UserHelper.STATUS_OK);
		} catch (RuntimeException e) {
			json = RenderUtils.getStatusSystem();
		}
		RenderUtils.renderJson(response, json);
	}
	
	private JSONObject updateStatus(HttpServletRequest request, Integer[] ids,
			ModelMap modelMap,byte status){
		JSONObject json = null;
		if (ids != null) {
			int c = 0;
			List<Integer> failIds = new ArrayList<Integer>();
			try {
				for (Integer i : ids) {
					logger.info("disable " + className + ":" + i);
					User u = this.baseService.get(i);
					if(null != u && u.getStatus() != status){
						u.setStatus(status);
						this.baseService.save(u);
					}
					c++;
				}
				json = RenderUtils.getStatusOk();
			} catch (RuntimeException e) {
				failIds.add(ids[c]);
			}
			if(failIds.size() > 0){
				json = RenderUtils.getStatusSystem();
				json.put(RenderUtils.KEY_ERROR, failIds);
			}
			json.put(RenderUtils.KEY_RESULT, ids);
		}
		return json;
	} 
</#if>
	
	<#if domain.id.name != "id">
	@Override
	protected String getIdName() {
		return "${domain.id.name}";
	}
	</#if>
	<#if (domain.refFields?size > 0) >
	@Override
	protected String[] getExclude(){
		return new String[]{${domain.refFieldStr}};
	}
	</#if>
	
}
