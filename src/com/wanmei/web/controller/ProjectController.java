package com.wanmei.web.controller;

import java.io.File;
import java.util.List;

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
import com.wanmei.domain.Project;
import com.wanmei.export.ExporterTask;
import com.wanmei.export.ProjectExporter;
import com.wanmei.service.ProjectService;
import com.wanmei.support.SortBean;
import com.wanmei.tool.paging.CommonList;
import com.wanmei.util.FileUtil;
import com.wanmei.util.RenderUtils;
import com.wanmei.util.StringUtil;
import com.wanmei.util.ValidateUtils;
/**
 * @author joeytang
 * Date: 2011-11-21 10:42
 * 项目action
 */
@Controller
@RequestMapping("/project")
public class ProjectController  extends MvcControllerTemplate<Project,Integer,ProjectService>  {

	
       
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
	 * 生成模块代码
	 * 
	 * @return 返回到模块下input.jsp
	 * @throws Exception
	 */
	@RequestMapping(value = "/gencode/{id}")
	public String gencode(HttpServletRequest request,HttpServletResponse response, @PathVariable Integer id, ModelMap modelMap) {
		Project project = this.baseService.wireProject(id);
		if(null != project){
			project.setOutput(this.getWebRoot(request) + "output/");
		}
		ExporterTask task = new ExporterTask();
		task.addExport(new ProjectExporter(project));
		task.execute();
		File pFoder = new File(project.getProjectDir()+"/");
		File pOut = new File(project.getProjectDir()+".zip");
		FileUtil.zip(pFoder, pOut, null);
		modelMap.put("url", "xxx.zip");
		return  StringUtil.lowerFirstChar( className)+"/download";
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
	public String main(HttpServletRequest request,HttpServletResponse response, Project project,
			Integer pageNo, Integer pageSize, ModelMap modelMap) {
		return super.main(request,response, project,pageNo,pageSize, modelMap);
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
	public String list(HttpServletRequest request,HttpServletResponse response, Project project,SortBean sort,
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
			if(StringUtils.isNotBlank(project.getName())){
				filter.addFilter("name", project.getName(),SqlFilter.OP.like);
				searchStr.append("&name="+project.getName());
			}		
			if(StringUtils.isNotBlank(project.getLabel())){
				filter.addFilter("label", project.getLabel(),SqlFilter.OP.like);
				searchStr.append("&label="+project.getLabel());
			}		
			SqlSort sqlSort = new SqlSort();
			if(null == sort || StringUtils.isBlank(sort.getSortProperty())){
				sqlSort.addSort(this.getIdName(), "desc");
			}else{
				sqlSort.addSort(sort.getSortProperty(), sort.getSortOrder());
			}
			List<Project> ts = baseService.list(filter, sqlSort, pageNo, pageSize);
			int size = baseService.count(filter);
			modelMap.put(StringUtil.lowerFirstChar(className), project);
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
	public void save(HttpServletRequest request,HttpServletResponse response, Project project,
			ModelMap modelMap) {
		super.save(request,response,project, modelMap);
	}
	@Override
	public JSONObject preSave(HttpServletRequest request, Project domain,
			ModelMap modelMap) {
		JSONObject json = null;
		if(null == domain){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"请求出错，重新提交");
			return json;
		}
	    if(!ValidateUtils.isStringLengthValidated(domain.getName(),1,20)){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"项目英文名不能为空,且不能大于20字符！");
			return json;
	    }
	    if(!ValidateUtils.isStringLengthValidated(domain.getLabel(),1,20)){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"项目中文名不能为空,且不能大于20字符！");
			return json;
	    }
	    if(!ValidateUtils.isStringLengthValidated(domain.getOrg(),1,20)){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"代码包组织不能为空,且不能大于20字符！");
			return json;
	    }
	    if(!ValidateUtils.isStringLengthValidated(domain.getTablePre(),0,20)){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"数据库表前缀不能大于20字符！");
			return json;
	    }
	    if(!ValidateUtils.isStringLengthValidated(domain.getOutput(),0,250)){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"代码导出路径不能大于250字符！");
			return json;
	    }
	    if(!ValidateUtils.isStringLengthValidated(domain.getVersion(),0,250)){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"版本号不能大于250字符！");
			return json;
	    }
	    if(!ValidateUtils.isStringLengthValidated(domain.getJdkVersion(),0,250)){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"JDK版本不能大于250字符！");
			return json;
	    }
		return RenderUtils.getStatusOk();
	}
	
	@Override
	protected String[] getExclude(){
		return new String[]{"db","action","dao","security"};
	}
	
}
