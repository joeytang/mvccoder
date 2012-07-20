package com.wanmei.web.controller;

import com.wanmei.common.controller.MvcControllerTemplate;
import com.wanmei.domain.Button;
import com.wanmei.domain.Field;
import com.wanmei.domain.FieldHelper;
import com.wanmei.support.SortBean;
import com.wanmei.service.ButtonService;
import com.wanmei.common.dao.SqlFilter;
import com.wanmei.common.dao.SqlSort;
import com.wanmei.util.StringUtil;
import com.wanmei.tool.paging.CommonList;
import java.util.List;
import net.sf.json.JSONObject;
import com.wanmei.util.RenderUtils;
import com.wanmei.util.ValidateUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
/**
 * @author joeytang
 * Date: 2011-11-21 10:42
 * 按钮action
 */
@Controller
@RequestMapping("/button")
public class ButtonController  extends MvcControllerTemplate<Button,Integer,ButtonService>  {

	/**
	 * 列出所有按钮
	 * 
	 */
	@RequestMapping(value = "/listButton")
	public void listIdField(HttpServletRequest request,HttpServletResponse response,String key, ModelMap modelMap) {
		SqlFilter filter = new SqlFilter();
		pageSize = 15;
		if( StringUtils.isNotBlank(key)){
			pageSize = -1;
		}
		filter.addFilter("label", key,SqlFilter.OP.ilike);
		SqlSort sort = new SqlSort();
		sort.addSort("id", "desc");
		List<Button> ts = this.baseService.list(filter, sort, 1, pageSize);
		RenderUtils.renderJson(response,RenderUtils.getJsonIncludePro(ts, new String[]{"id","label"}));
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
	public String main(HttpServletRequest request,HttpServletResponse response, Button button,
			Integer pageNo, Integer pageSize, ModelMap modelMap) {
		return super.main(request,response, button,pageNo,pageSize, modelMap);
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
	public String list(HttpServletRequest request,HttpServletResponse response, Button button,SortBean sort,
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
			if(StringUtils.isNotBlank(button.getLabel())){
				filter.addFilter("label", button.getLabel(),SqlFilter.OP.like);
				searchStr.append("&label="+button.getLabel());
			}		
			SqlSort sqlSort = new SqlSort();
			if(null == sort || StringUtils.isBlank(sort.getSortProperty())){
				sqlSort.addSort(this.getIdName(), "desc");
			}else{
				sqlSort.addSort(sort.getSortProperty(), sort.getSortOrder());
			}
			List<Button> ts = baseService.list(filter, sqlSort, pageNo, pageSize);
			int size = baseService.count(filter);
			modelMap.put(StringUtil.lowerFirstChar(className), button);
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
	public void save(HttpServletRequest request,HttpServletResponse response, Button button,
			ModelMap modelMap) {
		super.save(request,response,button, modelMap);
	}
	@Override
	public JSONObject preSave(HttpServletRequest request, Button domain,
			ModelMap modelMap) {
		JSONObject json = null;
		if(null == domain){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"请求出错，重新提交");
			return json;
		}
	    if(!ValidateUtils.isStringLengthValidated(domain.getLabel(),1,20)){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"项目中文名不能为空,且不能大于20字符！");
			return json;
	    }
		return RenderUtils.getStatusOk();
	}
	
	@Override
	protected String[] getExclude(){
		return new String[]{"domain"};
	}
	
}
