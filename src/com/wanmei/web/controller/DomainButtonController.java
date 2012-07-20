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
import com.wanmei.domain.Button;
import com.wanmei.domain.Domain;
import com.wanmei.domain.DomainButton;
import com.wanmei.service.ButtonService;
import com.wanmei.service.DomainButtonService;
import com.wanmei.service.DomainService;
import com.wanmei.support.SortBean;
import com.wanmei.tool.paging.CommonList;
import com.wanmei.util.RenderUtils;
import com.wanmei.util.StringUtil;
/**
 * @author joeytang
 * Date: 2011-11-21 10:42
 * 模块与按钮映射action
 */
@Controller
@RequestMapping("/domainButton")
public class DomainButtonController  extends MvcControllerTemplate<DomainButton,Integer,DomainButtonService>  {
	@Autowired
	private DomainService domainService;
	@Autowired
	private ButtonService buttonService;
	/**
	 * 添加所有按钮
	 * 
	 * @return 返回到模块下input.jsp
	 * @throws Exception
	 */
	@RequestMapping(value = "/addAll/{id}")
	public void addAll(HttpServletRequest request,HttpServletResponse response, @PathVariable Integer id, ModelMap modelMap) {
		Domain d = domainService.get(id);
		DomainButton domainButton = new DomainButton();
		domainButton.setDomain(d);
		List<Button> buttons = buttonService.list(null, null, -1, -1);
		if(null != buttons){
			for(Button b:buttons){
				domainButton.setButton(b);
				this.baseService.save(domainButton);
			}
		}
		RenderUtils.renderJson(response, RenderUtils.getStatusOk());
		return ;
	}
	/**
	 * 添加对象
	 * 
	 * @return 返回到模块下input.jsp
	 * @throws Exception
	 */
	@RequestMapping(value = "/input/{id}")
	public String input(HttpServletRequest request,HttpServletResponse response, @PathVariable Integer id, ModelMap modelMap) {
		DomainButton domainButton = new DomainButton();
		domainButton.setDomain(domainService.get(id));
		modelMap.put("domainButton",domainButton);
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
	public String main(HttpServletRequest request,HttpServletResponse response, @PathVariable Integer id, DomainButton domainButton,
			Integer pageNo, Integer pageSize, ModelMap modelMap) {
		modelMap.put("id", id);
		return super.main(request,response, domainButton,pageNo,pageSize, modelMap);
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
	public String list(HttpServletRequest request,HttpServletResponse response, @PathVariable Integer id, DomainButton domainButton,SortBean sort,
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
			filter.addFilter("domain.idkey", id);
			SqlSort sqlSort = new SqlSort();
			if(null == sort || StringUtils.isBlank(sort.getSortProperty())){
				sqlSort.addSort(this.getIdName(), "desc");
			}else{
				sqlSort.addSort(sort.getSortProperty(), sort.getSortOrder());
				sBuf.append("&sortProperty="+sort.getSortProperty());
				sBuf.append("&sortOrder="+sort.getSortOrder());
			}
			List<DomainButton> ts = baseService.list(filter, sqlSort, pageNo, pageSize);
			int size = baseService.count(filter);
			modelMap.put(StringUtil.lowerFirstChar(className), domainButton);
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
	public void save(HttpServletRequest request,HttpServletResponse response, DomainButton domainButton,
			ModelMap modelMap) {
		super.save(request,response,domainButton, modelMap);
	}
	@Override
	public JSONObject preSave(HttpServletRequest request, DomainButton domain,
			ModelMap modelMap) {
		JSONObject json = null;
		if(null == domain){
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR,"请求出错，重新提交");
			return json;
		}
		return RenderUtils.getStatusOk();
	}
	
	@Override
	protected String[] getExclude(){
		return new String[]{"domain","controller"};
	}
	
}
