package com.wanmei.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wanmei.common.controller.MvcControllerTemplate;
import com.wanmei.common.dao.SqlFilter;
import com.wanmei.common.dao.SqlSort;
import com.wanmei.domain.Security;
import com.wanmei.service.SecurityService;
import com.wanmei.support.SortBean;
import com.wanmei.util.RenderUtils;
/**
 * @author joeytang
 * Date: 2011-11-21 10:42
 * SpringSecurity全局配置action
 */
@Controller
@RequestMapping("/security")
public class SecurityController  extends MvcControllerTemplate<Security,Integer,SecurityService>  {
	@RequestMapping(value = "/listSecurity")
	public void listDb(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap) {
		SqlFilter filter = new SqlFilter();
		SqlSort sort = new SqlSort();
		sort.addSort("id", "desc");
		List<Security> ts = baseService.list(filter, sort, -1, -1);
		RenderUtils.renderJson(response,RenderUtils.getJsonIncludePro(ts, new String[]{"id","typeName"}));
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
	public String main(HttpServletRequest request,HttpServletResponse response, Security security,
			Integer pageNo, Integer pageSize, ModelMap modelMap) {
		return super.main(request,response, security,pageNo,pageSize, modelMap);
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
	public String list(HttpServletRequest request,HttpServletResponse response, Security security,SortBean sort,
			Integer pageNo, Integer pageSize, ModelMap modelMap) {
		return super.list(request,response, security,sort,pageNo,pageSize, modelMap);
	}
	
	/**
	 * 保存对象
	 * 
	 * @return {模块名：保存的对象}
	 */
	@RequestMapping(value = "/save")
	public void save(HttpServletRequest request,HttpServletResponse response, Security security,
			ModelMap modelMap) {
		super.save(request,response,security, modelMap);
	}
	@Override
	public JSONObject preSave(HttpServletRequest request, Security domain,
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
		return new String[]{"project"};
	}
	
}
