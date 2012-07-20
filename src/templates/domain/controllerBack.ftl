package ${project.org}.web.controller<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>.back</#if>;

<#list domain.controllerImportFieldTypes as t>
import ${t};
</#list>

/**
 * @author joeytang
 * Date: 2011-11-21 10:42
 * ${domain.label}action
 */
@Controller<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>("back${domain.name}Action")</#if>
@RequestMapping("<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/security</#if>/${domain.name?uncap_first}")
public class ${domain.name}Controller  extends MvcControllerTemplate<${domain.name},<#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>${domain.id.entityName}<#else>${domain.id.primaryType}</#if>,${domain.name}Service>  {

	<#if !domain.disabledControllers?? || domain.disabledControllers?index_of("save") == -1>
	<#if domain.isMultipart>
	@Autowired
	private MvcUploadSupport mvcUploadSupport;
	</#if>
	</#if>
	<#list domain.many2ManyRelationFields as f>
	@Autowired
	private ${domain.name}${f.entityName}KeyService ${domain.lowerFirstName}${f.entityName}KeyService;
	</#list>
	<#if !domain.disabledControllers?? || domain.disabledControllers?index_of("input") == -1>
	/**
	 * 添加对象
	 * 
	 * @return 返回到模块下input.jsp
	 * @throws Exception
	 */
	@RequestMapping(value = "/input")
	public String input(HttpServletRequest request,HttpServletResponse response<#if domain.many2OneOtherRelationField??>, ${domain.name} ${domain.lowerFirstName}</#if>, ModelMap modelMap) {
		<#if domain.many2OneOtherRelationField??>
		modelMap.put(StringUtil.lowerFirstChar(className), ${domain.lowerFirstName});
		</#if>
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
	public String update(HttpServletRequest request,HttpServletResponse response, @PathVariable <#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>String<#else>${domain.id.primaryType}</#if> id, ModelMap modelMap) {
		return super.update(request,response,<#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>${domain.id.entityName}.convert(id)<#else>id</#if>,modelMap);
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
	public String view(HttpServletRequest request,HttpServletResponse response, @PathVariable <#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>String<#else>${domain.id.primaryType}</#if> id, ModelMap modelMap) {
		return super.view(request,response,<#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>${domain.id.entityName}.convert(id)<#else>id</#if>,modelMap);
	}
	</#if>
	
	<#if !(domain.disabledControllers??) || domain.disabledControllers?index_of("remove") == -1>
	/**
	 * 删除对象
	 * 
	 * @return
	 */
	@RequestMapping(value = "/remove/{id}")
	public void remove(HttpServletRequest request,HttpServletResponse response,  @PathVariable <#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>String<#else>${domain.id.primaryType}</#if> id, ModelMap modelMap) {
		super.remove(request, response,<#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>${domain.id.entityName}.convert(id)<#else>id</#if>, modelMap);
	}
	</#if>
	
	<#if !(domain.disabledControllers??) || domain.disabledControllers?index_of(",removeMore,") == -1>
	/**
	 * 批量删除对象
	 * 
	 * @return
	 */
	@RequestMapping(value = "/removeMore")
	public void removeMore(HttpServletRequest request,HttpServletResponse response, <#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>String<#else>${domain.id.primaryType}</#if>[] ids, ModelMap modelMap) {
		<#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>
		if(null != ids && ids.length > 0){
			${domain.id.entityName}[] ${domain.id.entityName?uncap_first}s = new ${domain.id.entityName}[ids.length];
			int i = 0 ;
			for(String id:ids){
				${domain.id.entityName?uncap_first}s[i++] = ${domain.id.entityName}.convert(id);
			}
			super.removeMore(request, response, ${domain.id.entityName?uncap_first}s, modelMap);
		}
		<#else>
		super.removeMore(request, response, ids, modelMap);
		</#if>
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
	public String main(HttpServletRequest request,HttpServletResponse response, ${domain.name} ${domain.lowerFirstName},Boolean nobtn, ModelMap modelMap) {
		return super.main(request,response, ${domain.lowerFirstName},nobtn, modelMap);
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
		<#if (domain.searchSortField?? && (domain.searchSortField?size>0)) || (domain.one2ManyRelationFields?? && (domain.one2ManyRelationFields?size>0))>
		String statusText = null;
		try {
			// 查找当前页
			if (null == pageSize) {
				pageSize = this.pageSize;
			}
			if (null == pageNo) {
				pageNo = 1;
			}
			pageNo = Math.max(1, pageNo);
			StringBuffer sBuf = new StringBuffer();
			SqlFilter filter = new SqlFilter();
			<#list domain.one2ManyRelationFields as f>
			if(null != ${domain.lowerFirstName} && null != ${domain.lowerFirstName}.get${f.name?cap_first}() && null != ${domain.lowerFirstName}.get${f.name?cap_first}().get${project.domainMap[f.entityName].id.name?cap_first}()){
				filter.addFilter("${f.name}.${project.domainMap[f.entityName].id.name}", ${domain.lowerFirstName}.get${f.name?cap_first}().get${project.domainMap[f.entityName].id.name?cap_first}());
				sBuf.append("&${f.name}.${project.domainMap[f.entityName].id.name}"+${domain.lowerFirstName}.get${f.name?cap_first}().get${project.domainMap[f.entityName].id.name?cap_first}());
			}
			</#list>
			<#if domain.searchSortField??>
			<#list domain.searchSortField as f>
			<#if (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_STRING)>
			if(StringUtils.isNotBlank(${domain.lowerFirstName}.get${f.name?cap_first}())){
				filter.addFilter("${f.name}", ${domain.lowerFirstName}.get${f.name?cap_first}(),SqlFilter.OP.like);
				sBuf.append("&${f.name}="+${domain.lowerFirstName}.get${f.name?cap_first}());
			}		
			<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_TEXT)>
			if(StringUtils.isNotBlank(${domain.lowerFirstName}.get${f.name?cap_first}())){
				filter.addFilter("${f.name}", ${domain.lowerFirstName}.get${f.name?cap_first}(),SqlFilter.OP.like);
				sBuf.append("&${f.name}="+${domain.lowerFirstName}.get${f.name?cap_first}());
			}		
			<#else>
			if(null != ${domain.lowerFirstName}.get${f.name?cap_first}()){
				filter.addFilter("${f.name}", ${domain.lowerFirstName}.get${f.name?cap_first}());
				sBuf.append("&${f.name}="+${domain.lowerFirstName}.get${f.name?cap_first}());
			}
			</#if>
			</#list>
			</#if>
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
			commonList.setSearchStr(sBuf.toString());
			modelMap.put("commonList", commonList);
			return StringUtil.lowerFirstChar( className)+"/list";
		} catch (Exception e) {
			statusText = RenderUtils.getStatusSystem().toString();
		}
		RenderUtils.renderHtml(response, statusText);
		return null;
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
		<#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>
		if(null == domain.get${domain.id.name?cap_first}() && null != this.baseService.get(new ${domain.id.entityName}(<#assign ii=0><#list project.domainMap[domain.id.entityName].fields as f><#if (ii!=0)>,</#if>domain.get${f.name?cap_first}()<#assign ii=ii+1> </#list>))){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"当前唯一标识的记录已经存在");
			return json;
		}
		</#if>
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
        try {
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
        } catch (Exception e) {
        	json = RenderUtils.getStatusSystem();
        	json.put(RenderUtils.KEY_ERROR,"用户保存出错！");
            return json;
        }
	}
	</#if>
	</#if>
	<#if domain.isMany2OneRelationBean>
	/**
	 * 列出所有记录主键与名称映射
	 * 
	 */
	@RequestMapping(value = "/list${domain.name}")
	public void listField(HttpServletRequest request,HttpServletResponse response,String key, ModelMap modelMap) {
		SqlFilter filter = new SqlFilter();
		pageSize = 15;
		if( StringUtils.isNotBlank(key)){
			pageSize = -1;
		}
		filter.addFilter("${domain.many2OneRelationBeanFieldName}", key,SqlFilter.OP.ilike);
		SqlSort sort = new SqlSort();
		sort.addSort("${domain.id.name}", "desc");
		List<${domain.name}> ts = this.baseService.list(filter, sort, 1, pageSize);
		RenderUtils.renderJson(response,RenderUtils.getJsonIncludePro(ts, new String[]{"${domain.id.name}","${domain.many2OneRelationBeanFieldName}"}));
		return ;
	}
	</#if>
	<#list domain.many2ManyRelationFields as f>
	/**
	 * 进入关联的${f.label}管理页面
	 * 
	 */
	@RequestMapping(value = "/main${f.name?cap_first}")
	public String main${f.name?cap_first}(HttpServletRequest request,HttpServletResponse response,${domain.name} ${domain.lowerFirstName},ModelMap modelMap) {
		modelMap.put("${domain.lowerFirstName}", ${domain.lowerFirstName});
		return StringUtil.lowerFirstChar( className)+"/main${f.name?cap_first}";
	}
	/**
	 * 列出该对象关联的${f.label}
	 * 
	 */
	@RequestMapping(value = "/list${f.name?cap_first}")
	public String list${f.name?cap_first}(HttpServletRequest request,HttpServletResponse response,${domain.name} ${domain.lowerFirstName},
			Integer pageNo, Integer pageSize, ModelMap modelMap) {
		// 查找当前页
		if (null == pageSize) {
			pageSize = this.pageSize;
		}
		if (null == pageNo) {
			pageNo = 1;
		}
		pageNo = Math.max(1, pageNo);
		List<${project.domainMap[f.entityName].name}> ts = this.baseService.list${f.entityName}By${domain.name}Id(${domain.lowerFirstName}.get${domain.id.name?cap_first}(), pageNo, pageSize);
		int size = baseService.count${f.entityName}By${domain.name}Id(${domain.lowerFirstName}.get${domain.id.name?cap_first}());
		modelMap.put("${project.domainMap[f.entityName].lowerFirstName}s", ts);
		CommonList commonList = new CommonList(size, pageNo, pageSize);
		modelMap.put("commonList", commonList);
		return StringUtil.lowerFirstChar( className)+"/list${f.name?cap_first}";
	}
	/**
	 * 添加该对象关联的${f.label}
	 * 
	 */
	@RequestMapping(value = "/add${f.name?cap_first}")
	public void add${f.name?cap_first}(HttpServletRequest request,HttpServletResponse response,${domain.name} ${domain.lowerFirstName},${domain.id.primaryType}[] ids, ModelMap modelMap) {
		JSONObject json = null;
		if (ids != null) {
			int c = 0;
			List<Integer> failIds = new ArrayList<Integer>();
			try {
				for (Integer i : ids) {
					${domain.name}${project.domainMap[f.entityName].name}Key ${domain.lowerFirstName}${project.domainMap[f.entityName].name}Key = new ${domain.name}${project.domainMap[f.entityName].name}Key(${domain.lowerFirstName}.get${domain.id.name?cap_first}(),i);
					${domain.lowerFirstName}${project.domainMap[f.entityName].name}KeyService.save(${domain.lowerFirstName}${project.domainMap[f.entityName].name}Key);
					logger.info("add ${domain.name}${project.domainMap[f.entityName].name}Key:(" +${domain.lowerFirstName}.getId() +","+ i+")");
					c++;
				}
				json = RenderUtils.getStatusOk();
			} catch (Exception e) {
				failIds.add(ids[c]);
			}
			if(failIds.size() > 0){
				json = RenderUtils.getStatusSystem();
				json.put(RenderUtils.KEY_ERROR, failIds);
			}
			json.put(RenderUtils.KEY_RESULT, ids);
		}else{
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR, "请选择一条记录");
		}
		RenderUtils.renderJson(response, json);
		return ;
	}
	/**
	 * 删除该对象关联的${f.label}
	 * 
	 */
	 @RequestMapping(value = "/remove${f.name?cap_first}")
	public void remove${f.name?cap_first}(HttpServletRequest request,HttpServletResponse response,${domain.name} ${domain.lowerFirstName},${domain.id.primaryType}[] ids, ModelMap modelMap) {
		JSONObject json = null;
		if (ids != null) {
			int c = 0;
			List<Integer> failIds = new ArrayList<Integer>();
			for (Integer i : ids) {
				${domain.name}${project.domainMap[f.entityName].name}Key ${domain.lowerFirstName}${project.domainMap[f.entityName].name}Key = new ${domain.name}${project.domainMap[f.entityName].name}Key(${domain.lowerFirstName}.get${domain.id.name?cap_first}(),i);
				try {
					logger.info("begin remove ${domain.name}${project.domainMap[f.entityName].name}Key:(" +${domain.lowerFirstName}.getId() +","+ i+")");
					${domain.lowerFirstName}${project.domainMap[f.entityName].name}KeyService.removeById(${domain.lowerFirstName}${project.domainMap[f.entityName].name}Key);
					logger.info("end remove ${domain.name}${project.domainMap[f.entityName].name}Key:(" +${domain.lowerFirstName}.getId() +","+ i+")");
				} catch (Exception e) {
					failIds.add(ids[c]);
				}
				c++;
			}
			json = RenderUtils.getStatusOk();
			if(failIds.size() > 0){
				json = RenderUtils.getStatusSystem();
				json.put(RenderUtils.KEY_ERROR, "部分记录操作失败:"+StringUtils.join(failIds,","));
			}
			json.put(RenderUtils.KEY_RESULT, ids);
		}else{
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR, "请选择一条记录");
		}
		RenderUtils.renderJson(response, json);
		return ;
	}
	</#list>
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
		}catch(Exception e){
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
		} catch (Exception e) {
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
		} catch (Exception e) {
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
			} catch (Exception e) {
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
