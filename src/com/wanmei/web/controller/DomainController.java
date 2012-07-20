package com.wanmei.web.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wanmei.common.controller.MvcControllerTemplate;
import com.wanmei.common.dao.SqlFilter;
import com.wanmei.common.dao.SqlSort;
import com.wanmei.domain.Domain;
import com.wanmei.service.DomainService;
import com.wanmei.support.SortBean;
import com.wanmei.tool.paging.CommonList;
import com.wanmei.util.RenderUtils;
import com.wanmei.util.StringUtil;
import com.wanmei.util.ValidateUtils;
/**
 * @author joeytang
 * Date: 2011-11-21 10:42
 * 模块action
 */
@Controller
@RequestMapping("/domain")
public class DomainController  extends MvcControllerTemplate<Domain,Integer,DomainService>  {
	
	/**
	 * 搜索模块
	 * @param request
	 * @param response
	 * @param key
	 * @param modelMap
	 */
	@RequestMapping(value = "/listDomain")
	public void listDomain(HttpServletRequest request,HttpServletResponse response,String key, ModelMap modelMap) {
		SqlFilter filter = new SqlFilter();
		pageSize = 15;
		if( StringUtils.isNotBlank(key)){
			pageSize = -1;
		}
		filter.addFilter("name", key,SqlFilter.OP.ilike);
		SqlSort sort = new SqlSort();
		sort.addSort("idkey", "desc");
		List<Domain> ts = this.baseService.list(filter, sort, 1, pageSize);
		RenderUtils.renderJson(response,RenderUtils.getJsonIncludePro(ts, new String[]{"idkey","name","packageName"}));
		return ;
	}
	/**
	 * 搜索模块包名
	 * @param request
	 * @param response
	 * @param key
	 * @param modelMap
	 */
	@RequestMapping(value = "/listDomainPackageName")
	public void listDomainPackageName(HttpServletRequest request,HttpServletResponse response,String key, ModelMap modelMap) {
		SqlFilter filter = new SqlFilter();
		pageSize = 15;
		if( StringUtils.isNotBlank(key)){
			pageSize = -1;
		}
		filter.addFilter("name", key,SqlFilter.OP.ilike);
		SqlSort sort = new SqlSort();
		sort.addSort("idkey", "desc");
		List<Domain> ts = this.baseService.list(filter, sort, 1, pageSize);
		List<JSONObject> jss = new ArrayList<JSONObject>();
		Set<String> set = new HashSet<String>();
		if(null !=ts){
			for(Domain d:ts){
				set.add(d.getPackageName());
			}
		}
		for(String s:set){
			JSONObject j = new JSONObject();
			j.put("packageName", s);
			jss.add(j);
		}
		RenderUtils.renderJson(response,jss);
		return ;
	}
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
	/**
	 * 修改对象
	 * 
	 * @return 返回到模块下input.jsp
	 * @throws Exception
	 */
	@RequestMapping(value = "/update/{id}")
	public String update(HttpServletRequest request,HttpServletResponse response, @PathVariable Integer id, ModelMap modelMap) {
		return super.update(request,response,id,modelMap);
	}
	
	/**
	 * 查看对象
	 * 
	 * @return 返回到模块下view.jsp
	 * @throws Exception
	 */
	@RequestMapping(value = "/view/{id}")
	public String view(HttpServletRequest request,HttpServletResponse response, @PathVariable Integer id, ModelMap modelMap) {
		return super.view(request,response,id,modelMap);
	}
	
	/**
	 * 删除对象
	 * 
	 * @return
	 */
	@RequestMapping(value = "/remove/{id}")
	public void remove(HttpServletRequest request,HttpServletResponse response,  @PathVariable Integer id, ModelMap modelMap) {
		super.remove(request, response,id, modelMap);
	}
	
	/**
	 * 批量删除对象
	 * 
	 * @return
	 */
	@RequestMapping(value = "/removeMore")
	public void removeMore(HttpServletRequest request,HttpServletResponse response, Integer[] ids, ModelMap modelMap) {
		super.removeMore(request, response, ids, modelMap);
	}
	
	
	/**
	 * 进入模块管理页面
	 * 
	 * @param request
	 * @param modelMap
	 * @return 返回到模块下main.jsp
	 * @throws Exception
	 */
	@RequestMapping(value = "/main")
	public String main(HttpServletRequest request,HttpServletResponse response, Domain domain,
			Integer pageNo, Integer pageSize, ModelMap modelMap) {
		return super.main(request,response, domain,pageNo,pageSize, modelMap);
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
	public String list(HttpServletRequest request,HttpServletResponse response, Domain domain,SortBean sort,
			Integer pageNo, Integer pageSize, ModelMap modelMap) {
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
			SqlFilter filter = new SqlFilter();
			StringBuffer searchStr = new StringBuffer();
			if(StringUtils.isNotBlank(domain.getName())){
				filter.addFilter("name", domain.getName(),SqlFilter.OP.like);
				searchStr.append("&name="+domain.getName());
			}		
			if(StringUtils.isNotBlank(domain.getLabel())){
				filter.addFilter("label", domain.getLabel(),SqlFilter.OP.like);
				searchStr.append("&label="+domain.getLabel());
			}		
			SqlSort sqlSort = new SqlSort();
			if(null == sort || StringUtils.isBlank(sort.getSortProperty())){
				sqlSort.addSort(this.getIdName(), "desc");
			}else{
				sqlSort.addSort(sort.getSortProperty(), sort.getSortOrder());
			}
			List<Domain> ts = baseService.list(filter, sqlSort, pageNo, pageSize);
			int size = baseService.count(filter);
			modelMap.put(StringUtil.lowerFirstChar(className), domain);
			modelMap.put(StringUtil.lowerFirstChar(className) + "s", ts);
			if(null != sort && StringUtils.isNotBlank(sort.getSortProperty())){
				modelMap.put("sort", sort);
			}
			CommonList commonList = new CommonList(size, pageNo, pageSize);
			commonList.setSearchStr(searchStr.toString());
			modelMap.put("commonList", commonList);
			return StringUtil.lowerFirstChar( className)+"/list";
		} catch (Exception e) {
			statusText = RenderUtils.getStatusSystem().toString();
		}
		RenderUtils.renderHtml(response, statusText);
		return null;
	}
	
	/**
	 * 保存对象
	 * 
	 * @return {模块名：保存的对象}
	 */
	@RequestMapping(value = "/save")
	public void save(HttpServletRequest request,HttpServletResponse response, Domain domain,
			ModelMap modelMap) {
		super.save(request,response,domain, modelMap);
	}
	@Override
	public JSONObject preSave(HttpServletRequest request, Domain domain,
			ModelMap modelMap) {
		JSONObject json = null;
		if(null == domain){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"请求出错，重新提交");
			return json;
		}
	    if(!ValidateUtils.isStringLengthValidated(domain.getName(),1,20)){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"模块英文名不能为空,且不能大于20字符！");
			return json;
	    }
	    if(!ValidateUtils.isStringLengthValidated(domain.getLabel(),1,20)){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"模块中文名不能为空,且不能大于20字符！");
			return json;
	    }
	    if(!ValidateUtils.isStringLengthValidated(domain.getTable(),0,20)){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"对应表名不能大于20字符！");
			return json;
	    }
	    if(!ValidateUtils.isStringLengthValidated(domain.getDescription(),0,250)){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"模块描述不能大于250字符！");
			return json;
	    }
	    if(!ValidateUtils.isStringLengthValidated(domain.getPackageName(),1,20)){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"模块包名不能为空,且不能大于20字符！");
			return json;
	    }
	    if(!ValidateUtils.isStringLengthValidated(domain.getDisabledControllers(),0,250)){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"禁用的Controller不能大于250字符！");
			return json;
	    }
		return RenderUtils.getStatusOk();
	}
	
	@Override
	protected String getIdName() {
		return "idkey";
	}
	
}
