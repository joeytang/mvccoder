package ${project.org}.web.controller;

import java.util.Date;
import java.util.List;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
<#if project.security.type == statics["com.wanmei.domain.SecurityHelper"].TYPE_COMPLEX>
import org.springframework.beans.factory.annotation.Autowired;

import ${project.org}.domain.Role;
import ${project.org}.service.RoleService;
import ${project.org}.common.security.SecurityCacheService;
</#if>
import ${project.org}.common.controller.MvcControllerTemplate;
import ${project.org}.common.dao.SqlFilter;
import ${project.org}.domain.User;
import ${project.org}.domain.helper.UserHelper;
import ${project.org}.service.UserService;
import ${project.org}.util.BeanHelper;
import ${project.org}.util.RenderUtils;
import ${project.org}.support.UserContext;


/**
 * User: joeytang
 * Date: 2011-06-03 14:24
 * 用户action
 */
@Controller
@RequestMapping("/user")
public class UserAction extends MvcControllerTemplate<User,${project.security.idType2ShortJavaType},UserService> {

    
    <#if project.security.type == statics["com.wanmei.domain.SecurityHelper"].TYPE_COMPLEX>
    @Autowired
    private SecurityCacheService securityCacheService;
    @Autowired
    private RoleService roleService;
	</#if>
	/**
	 * 检查账号是否有重复
	 * 
	 * @return
	 */
	@RequestMapping(value = "/checkAccount")
	public void checkUrl(HttpServletRequest request,HttpServletResponse response,Integer id,@RequestParam String account, ModelMap modelMap)
			throws Exception{
		JSONObject json = null;
		try{
			if(null != id){
				User oldUser = baseService.get(id);
				if(null != oldUser && null != oldUser.getAccount() && null != account && oldUser.getAccount().equals(account)){
					json = RenderUtils.getJsonSuccess();
					RenderUtils.renderJson(response, json);
					return;
				}
			}
			SqlFilter filter = new SqlFilter();
			if(StringUtils.isNotBlank(account)){
				filter.addFilter("account", account);
			}
			int count = baseService.count(filter);
			if(count > 0){
				json = RenderUtils.getJsonFailed();
				json.put(RenderUtils.KEY_ERROR, "该账号已经存在");
			}else{
				json = RenderUtils.getJsonSuccess();
			}
		}catch(Exception e){
			json = RenderUtils.getJsonFailed();
			json.put(RenderUtils.KEY_ERROR, "查询错误");
		}
		RenderUtils.renderJson(response, json);
	}
	/**
	 * 添加或修改对象
	 * 
	 * @return 返回到模块下input.jsp
	 * @throws Exception
	 */
	@RequestMapping(value = "/input")
	public String input(HttpServletRequest request, User user, ModelMap modelMap)
			throws Exception {
		return super.input(request,user,modelMap);
	}
	
	/**
	 * 删除对象
	 * 
	 * @return
	 */
	@RequestMapping(value = "/remove")
	public void remove(HttpServletRequest request,HttpServletResponse response, User user, ModelMap modelMap)
			throws Exception{
		super.remove(request, response, user, modelMap);
	}
	
	/**
	 * 批量禁用对象
	 * 
	 * @return
	 */
	@RequestMapping(value = "/removeMore")
	public void removeMore(HttpServletRequest request,HttpServletResponse response, Integer[] ids, ModelMap modelMap)
			throws Exception{
		super.removeMore(request, response, ids, modelMap);
	}
	/**
	 * 批量启用对象
	 * 
	 * @return
	 */
	@RequestMapping(value = "/enableMore")
	public void enableMore(HttpServletRequest request,HttpServletResponse response, Integer[] ids, ModelMap modelMap)
			throws Exception{
		JSONObject json = doEnableMore(request, ids, modelMap);
		RenderUtils.renderJson(response, json);
	}
	@Override
	public JSONObject doRemoveMore(HttpServletRequest request, Integer[] ids,
			ModelMap modelMap){
		return updateStatus(request,ids,modelMap,UserHelper.STATUS_DELETED);
	}
	public JSONObject doEnableMore(HttpServletRequest request, Integer[] ids,
			ModelMap modelMap){
		return updateStatus(request,ids,modelMap,UserHelper.STATUS_OK);
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
				json = RenderUtils.getJsonSuccess();
			} catch (Exception e) {
				json = RenderUtils.getJsonFailed();
				failIds.add(ids[c]);
			}
			if(failIds.size() > 0){
				json = RenderUtils.getJsonFailed();
				modelMap.put("failIds", failIds);
				json.put("failIds", failIds);
			}
			json.put("ids", ids);
		}
		return json;
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
	public String main(HttpServletRequest request, User user,
			Integer pageNo, Integer pageSize, ModelMap modelMap)
			throws Exception{
		return super.main(request, user,pageNo,pageSize, modelMap);
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
	public String list(HttpServletRequest request, User user,
			Integer pageNo, Integer pageSize, ModelMap modelMap)
			throws Exception{
		return super.list(request, user,pageNo,pageSize, modelMap);
	}
	@Override
	public SqlFilter customListSqlFilter(HttpServletRequest request, User User)
			throws Exception{
		SqlFilter filter = super.customListSqlFilter(request, User);
		if(StringUtils.isNotBlank(User.getAccount())){
			filter.addFilter("account", User.getAccount(),SqlFilter.OP.like);
		}
		if(StringUtils.isNotBlank(User.getUserName())){
			filter.addFilter("userName", User.getUserName(),SqlFilter.OP.like);
		}
		return filter;
	}
	@Override
	public JSONObject preSave(HttpServletRequest request, User user,
			ModelMap modelMap) {
			modelMap.put("user", user);
			JSONObject json = null;
        if (null != user.getAccount() && 0 != user.getAccount().trim().length()) {
            User existUser = null;
            try {
            	SqlFilter filter = new SqlFilter();
            	filter.addFilter("account", user.getAccount().trim());
            	List<User> us = this.baseService.list(filter, null, -1, -1);
            	if(null != us && us.size() > 0){
            		existUser = us.get(0);
            	}
            } catch (Exception e) {
            	json = RenderUtils.getJsonFailed();
            	json.put(RenderUtils.KEY_ERROR,"该帐号已经存在！");
                return json;
            }

            if (null == user.getId()) {
                if (null != existUser) {
                    if (!existUser.isEnabled()) {
                        existUser.setStatus(UserHelper.STATUS_OK);
                        existUser.setUserName(user.getUserName());
                        try {
							this.baseService.save(existUser);
						} catch (Exception e) {
							json = RenderUtils.getJsonFailed();
			            	json.put(RenderUtils.KEY_ERROR,"该帐号帐号已经存在,保存出错！");
			                return json;
						}
						json = RenderUtils.getJsonSuccess();
                        return json;
                    } else {
               	 		json = RenderUtils.getJsonFailed();
		            	json.put(RenderUtils.KEY_ERROR,"该用户已经存在！");
		                return json;
                    }
                }
                user.setAccount(user.getAccount().trim());
                user.setStatus(UserHelper.STATUS_OK);
                user.setCreateTime(new Date());
                if(StringUtils.isBlank(user.getRole())){
                	user.setRole(UserHelper.ROLE_ADMIN);
                }
                user.setPassword(StringUtils.isBlank(user.getPassword())?"1":user.getPassword());
                try {
    				this.baseService.save(user);
    			} catch (Exception e) {
    				json = RenderUtils.getJsonFailed();
	            	json.put(RenderUtils.KEY_ERROR,"该帐号保存出错！");
	                return json;
    			}
            }else{
            	try {
            		User old = this.baseService.get(user.getId());
            		BeanHelper.copyNotNullProperties(user, old);
    				this.baseService.save(old);
    				user = old;
    			} catch (Exception e) {
                    json = RenderUtils.getJsonFailed();
	            	json.put(RenderUtils.KEY_ERROR,"该帐号修改出错！");
	                return json;
    			}
            }
            json = RenderUtils.getJsonSuccess();
    		return json;
        } else {
            json = RenderUtils.getJsonFailed();
        	json.put(RenderUtils.KEY_ERROR,"用户名为空！");
            return json;
        }
	}
    /**
     * 添加
     * @return
     */
    @RequestMapping(value="/save") 
    public void save(HttpServletRequest request,HttpServletResponse response,User user,ModelMap modelMap) {
    	JSONObject json = preSave(request, user, modelMap);
    	RenderUtils.renderJson(response, json);
    }
       /**
     * 修改密码
     * @return
     */
    public void changePwd(HttpServletRequest request,HttpServletResponse response,User user,ModelMap modelMap) {
    	JSONObject json = RenderUtils.getJsonFailed();
    	User userOld = UserContext.getSecurityUser();
    	try{
    		if(user != null){
    			userOld.setPassword(user.getPassword());
    			this.baseService.save(userOld);
    			json = RenderUtils.getJsonSuccess();
    		}
    	}catch(Exception e){
    		json = RenderUtils.getJsonFailed();
    	}
    	RenderUtils.renderJson(response, json);
    }
<#if project.security.type == statics["com.wanmei.domain.SecurityHelper"].TYPE_COMPLEX>
    /**
     * 查询角色
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/selectRoles") 
    public String selectRoles(HttpServletRequest request,${project.security.idType2ShortJavaType} id, String authorize,String needAuth,ModelMap modelMap) throws Exception {
    	User user = this.baseService.get(id);
    	modelMap.put("selectRoles", this.baseService.findUsersByParameters(id, authorize));
    	modelMap.put("authorize", authorize);
    	modelMap.put("needAuth", needAuth);
        modelMap.put("user", user);
        return "admin/user/selectRoles";
    }

    /**
     * 角色授权
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/authRoles") 
    public String authRoles(HttpServletRequest request,${project.security.idType2ShortJavaType} id,${project.security.idType2ShortJavaType}[] ids,String needAuth,ModelMap modelMap) throws Exception {
        if (null != ids && 0 != ids.length) {
            for (${project.security.idType2ShortJavaType} roleId : ids) {
                if (null == roleId) {
                    continue;
                }

                Role role = this.roleService.get(roleId);
                if (null == role) {
                    continue;
                }
                this.baseService.saveRoles(id, roleId, "true".equalsIgnoreCase(needAuth));
            }
        }
        User user = this.baseService.get(id);
        this.securityCacheService.authRoleInCache(user);

        return "redirect:selectRoles?id="+id;
    }
</#if>
}
