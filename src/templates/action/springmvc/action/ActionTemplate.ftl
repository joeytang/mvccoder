package ${project.org}.common.controller;

import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import ${project.org}.support.UserContext;
import ${project.org}.util.RenderUtils;
import ${project.org}.util.StringUtil;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

 /**
 * User: joeytang
 * Date: ${project.currentTime}
 * 模板action类
 */
public class ActionTemplate<T extends Serializable, PK extends Serializable> extends ActionSupport<T,PK> {
	/**
	 * 添加或修改对象
	 * 
	 * @return 返回到模块下input.jsp
	 * @throws Exception
	 */
	@RequestMapping(value = "/input")
	public String input(HttpServletRequest request, T domain, ModelMap modelMap)
			throws Exception {
		if(isDisabledController("input")){
			return "redirect:/common/accessDenied.jsp";
		}
		PK id = getId(domain);
		if(null != id){
			super.doInput(request, id, modelMap);
		}
		return StringUtil.lowerFirstChar( className)+"/input";
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
	public String list(HttpServletRequest request, T t,
			Integer pageNo, Integer pageSize, ModelMap modelMap)
			throws Exception {
		if(isDisabledController("list")){
			return "redirect:/common/accessDenied.jsp";
		}
		try {
			super.doList(request, modelMap, t, pageNo, pageSize);
		} catch (Exception e) {
			e.printStackTrace();
			UserContext.saveMessage(request, "列表出错");
		}
		return StringUtil.lowerFirstChar( className)+"/list";
	}
	/**
	 * 保存对象
	 * 
	 * @return {模块名：保存的对象}
	 */
	@RequestMapping(value = "/save")
	public void save(HttpServletRequest request,HttpServletResponse response, T domain,
			ModelMap modelMap) throws Exception {
		if(isDisabledController("save")){
			JSONObject json = RenderUtils.getJsonFailed();
			json.put(RenderUtils.KEY_ERROR, "拒绝访问");
			RenderUtils.renderJson(response, json);
			return ;
		}
		JSONObject json = null;
		json = super.doSave(request, domain, modelMap);
		json.put(StringUtil.lowerFirstChar(className), domain);
		RenderUtils.renderJson(response, json);
	}

	/**
	 * 删除对象
	 * 
	 * @return
	 */
	@RequestMapping(value = "/remove")
	public void remove(HttpServletRequest request,HttpServletResponse response, T domain, ModelMap modelMap)
			throws Exception {
		if(isDisabledController("remove")){
			JSONObject json = RenderUtils.getJsonFailed();
			json.put(RenderUtils.KEY_ERROR, "拒绝访问");
			RenderUtils.renderJson(response, json);
			return ;
		}
		PK id = super.getId(domain);
		JSONObject json = super.doRemove(request, id, modelMap);
		RenderUtils.renderJson(response, json);
	}

	/**
	 * 批量删除对象
	 * 
	 * @return
	 */
	@RequestMapping(value = "/removeMore")
	public void removeMore(HttpServletRequest request,HttpServletResponse response, PK[] ids, ModelMap modelMap)
			throws Exception {
		if(isDisabledController("removeMore")){
			JSONObject json = RenderUtils.getJsonFailed();
			json.put(RenderUtils.KEY_ERROR, "拒绝访问");
			RenderUtils.renderJson(response, json);
			return ;
		}
		JSONObject json = super.doRemoveMore(request, ids, modelMap);
		RenderUtils.renderJson(response, json);
	}
}
