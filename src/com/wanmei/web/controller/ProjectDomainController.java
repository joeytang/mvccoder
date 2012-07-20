package com.wanmei.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wanmei.common.controller.MvcControllerTemplate;
import com.wanmei.common.dao.SqlFilter;
import com.wanmei.common.dao.SqlSort;
import com.wanmei.domain.DomainField;
import com.wanmei.domain.ProjectDomain;
import com.wanmei.service.ProjectDomainService;
import com.wanmei.service.ProjectService;
import com.wanmei.support.SortBean;
import com.wanmei.tool.paging.CommonList;
import com.wanmei.util.RenderUtils;
import com.wanmei.util.StringUtil;
import com.wanmei.util.ValidateUtils;
/**
 * @author joeytang
 * Date: 2011-11-21 10:42
 * 项目与模块映射action
 */
@Controller
@RequestMapping("/projectDomain")
public class ProjectDomainController  extends MvcControllerTemplate<ProjectDomain,Integer,ProjectDomainService>  {
	@Autowired
	private ProjectService projectService;
	/**
	 * 添加对象
	 * 
	 * @return 返回到模块下input.jsp
	 * @throws Exception
	 */
	@RequestMapping(value = "/input/{id}")
	public String input(HttpServletRequest request,HttpServletResponse response, @PathVariable Integer id, ModelMap modelMap) {
		ProjectDomain projectDomain = new ProjectDomain();
		projectDomain.setProject(projectService.get(id));
		modelMap.put("projectDomain",projectDomain);
		SqlFilter filter = new SqlFilter();
		filter.addFilter("domain.id", id);
		int count = this.baseService.count(filter);
		count = (count + 1)*5;
		modelMap.put("count", count);
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
	@RequestMapping(value = "/main/{id}")
	public String main(HttpServletRequest request,HttpServletResponse response,  @PathVariable Integer id, ProjectDomain projectDomain,
			Integer pageNo, Integer pageSize, ModelMap modelMap) {
		modelMap.put("id", id);
		return super.main(request,response, projectDomain,pageNo,pageSize, modelMap);
	}
	/**
	 * 列出所有的对象
	 * 
	 * @param request
	 * @param modelMap
	 * @return 返回到模块下list.jsp
	 * @throws Exception
	 */
	@RequestMapping(value = "/list/{id}")
	public String list(HttpServletRequest request,HttpServletResponse response,  @PathVariable Integer id, ProjectDomain projectDomain,SortBean sort,
			Integer pageNo, Integer pageSize, ModelMap modelMap) {
		// 查找当前页
			if (null == pageSize) {
				pageSize = this.pageSize;
			}
			if (null == pageNo) {
				pageNo = 1;
			}
			pageNo = Math.max(1, pageNo);
			SqlFilter filter = new SqlFilter();
			StringBuffer sBuf = new StringBuffer();
			filter.addFilter("project.id", id);
			SqlSort sqlSort = new SqlSort();
			if(null == sort || StringUtils.isBlank(sort.getSortProperty())){
				sqlSort.addSort(this.getIdName(), "desc");
			}else{
				sqlSort.addSort(sort.getSortProperty(), sort.getSortOrder());
				sBuf.append("&sortProperty="+sort.getSortProperty());
				sBuf.append("&sortOrder="+sort.getSortOrder());
			}
			List<ProjectDomain> ts = baseService.list(filter, sqlSort, pageNo, pageSize);
			int size = baseService.count(filter);
			modelMap.put(StringUtil.lowerFirstChar(className), projectDomain);
			modelMap.put(StringUtil.lowerFirstChar(className) + "s", ts);
			if(null != sort && StringUtils.isNotBlank(sort.getSortProperty())){
				modelMap.put("sort", sort);
			}
			CommonList commonList = new CommonList(size, pageNo, pageSize);
			modelMap.put("commonList", commonList);
			modelMap.put("id", id);
			return StringUtil.lowerFirstChar( className)+"/list";
	}
	
	/**
	 * 保存对象
	 * 
	 * @return {模块名：保存的对象}
	 */
	@RequestMapping(value = "/save")
	public void save(HttpServletRequest request,HttpServletResponse response, ProjectDomain projectDomain,
			ModelMap modelMap) {
		super.save(request,response,projectDomain, modelMap);
	}
	@Override
	public JSONObject preSave(HttpServletRequest request, ProjectDomain domain,
			ModelMap modelMap) {
		JSONObject json = null;
		if(null == domain){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"请求出错，重新提交");
			return json;
		}
		if(!ValidateUtils.isValidateDeci(domain.getMenuOrder(),4,0,0,10000,true)){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"菜单排序在0-10000之间！");
			return json;
	    }
		return RenderUtils.getStatusOk();
	}
	
	@Override
	protected String[] getExclude(){
		return new String[]{"project","domain"};
	}
	
}
