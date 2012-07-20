package com.wanmei.web.controller;

import com.wanmei.common.controller.MvcControllerTemplate;
import com.wanmei.domain.User;
import com.wanmei.domain.helper.UserHelper;
import com.wanmei.util.BeanHelper;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.ArrayList;
import com.wanmei.support.SortBean;
import com.wanmei.service.UserService;
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
 * 用户action
 */
@Controller
@RequestMapping("/user")
public class UserController  extends MvcControllerTemplate<User,Integer,UserService>  {

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
	public String main(HttpServletRequest request,HttpServletResponse response, User user,
			Integer pageNo, Integer pageSize, ModelMap modelMap) {
		return super.main(request,response, user,pageNo,pageSize, modelMap);
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
	public String list(HttpServletRequest request,HttpServletResponse response, User user,SortBean sort,
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
			if(StringUtils.isNotBlank(user.getUsername())){
				filter.addFilter("username", user.getUsername(),SqlFilter.OP.like);
				searchStr.append("&username="+user.getUsername());
			}		
			if(StringUtils.isNotBlank(user.getNickname())){
				filter.addFilter("nickname", user.getNickname(),SqlFilter.OP.like);
				searchStr.append("&nickname="+user.getNickname());
			}		
			SqlSort sqlSort = new SqlSort();
			if(null == sort || StringUtils.isBlank(sort.getSortProperty())){
				sqlSort.addSort(this.getIdName(), "desc");
			}else{
				sqlSort.addSort(sort.getSortProperty(), sort.getSortOrder());
			}
			List<User> ts = baseService.list(filter, sqlSort, pageNo, pageSize);
			int size = baseService.count(filter);
			modelMap.put(StringUtil.lowerFirstChar(className), user);
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
	public void save(HttpServletRequest request,HttpServletResponse response, User user,
			ModelMap modelMap) {
		super.save(request,response,user, modelMap);
	}
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
	
	
}
