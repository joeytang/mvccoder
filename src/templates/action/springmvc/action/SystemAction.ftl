package ${project.org}.security.web.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import ${project.org}.security.dao.SqlFilter;
import ${project.org}.security.dao.SqlSort;
import ${project.org}.security.domain.Role;
import ${project.org}.security.domain.User;
import ${project.org}.security.service.RoleService;
import ${project.org}.security.service.UserService;
import ${project.org}.security.service.SecurityCacheService;
import ${project.org}.util.BeanHelper;
import ${project.org}.security.service.UserContext;
/**
 * User: joeytang
 * Date: 2011-06-03 14:24
 * 用户action
 */
@Controller
@RequestMapping("/security/sys")
public class UserAction extends PageAction {

   
/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

    @Autowired
    private SecurityCacheService securityCacheService;
    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;


   

    /**
     * 添加
     * @return
     */
    @RequestMapping(value="/readlog") 
    public String save(HttpServletRequest request,User user,ModelMap modelMap) {
    	modelMap.put("user", user);
        if (null != user.getLoginid() && 0 != user.getLoginid().trim().length()) {
            User existUser = null;
            try {
            	SqlFilter filter = new SqlFilter();
            	filter.addFilter("loginid", user.getLoginid().trim());
            	List<User> us = userService.list(filter, null, -1, -1);
            	if(null != us && us.size() > 0){
            		existUser = us.get(0);
            	}
            } catch (Exception e) {
                UserContext.saveMessage(request,"该帐号已经存在！");
                return "admin/user/input";
            }

            if (null == user.getId()) {
                if (null != existUser) {
                    if (existUser.isDisabled()) {
                        existUser.setDisabled(false);
                        existUser.setName(user.getName());
                        try {
							userService.save(existUser);
						} catch (Exception e) {
							UserContext.saveMessage(request,"该帐号帐号已经存在,保存出错！");
			                return "admin/user/input";
						}
                        return "redirect:list?pageNo=1";
                    } else {
                        UserContext.saveMessage(request,"该用户已经存在！");
                        return "admin/user/input";
                    }
                }
                user.setLoginid(user.getLoginid().trim());
                user.setDisabled(false);
                user.setCreateDate(new Date());
                user.setPasswd("1");
                try {
    				userService.save(user);
    			} catch (Exception e) {
    				UserContext.saveMessage(request,"该帐号保存出错！");
                    return "admin/user/input";
    			}
            }else{
            	try {
            		User old = userService.get(user.getId());
            		BeanHelper.copyNotNullProperties(user, old);
    				userService.save(old);
    				user = old;
    			} catch (Exception e) {
    				UserContext.saveMessage(request,"该帐号修改出错！");
                    return "admin/user/input";
    			}
            }
            this.securityCacheService.modifyUserInCache(user, user.getLoginid());
            return "redirect:list?pageNo=1";
        } else {
            UserContext.saveMessage(request,"用户名为空！");
            return "admin/user/input";
        }
    }
    /**
     * 删除
     * @return
     */
    @RequestMapping(value="/remove") 
    public String remove(HttpServletRequest request,Long id,ModelMap modelMap){
        try {
            userService.removeById(id);
        } catch (Exception e) {
            UserContext.saveMessage(request,"该用户正在使用，不允许被删除！");
        }
        return "redirect:list?pageNo=1";

    }
    /**
     * 删除集合
     * @return
     */
    @RequestMapping(value="/removeMore") 
    public String removeMore(HttpServletRequest request,Long[] ids,ModelMap modelMap){
        if (null != ids && 0 != ids.length) {
            for (Long id : ids) {
                try {
					userService.removeById(id);
				} catch (Exception e) {
					UserContext.saveMessage(request,"删除出错");
				}
            }
        }
        return "redirect:list?pageNo=1";
    }

    /**
     * 查询
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/list") 
	public String list(HttpServletRequest request,String forwardpagename,User user,Integer pageSize, ModelMap modelMap) throws Exception {
        //查找当前页
        String rpname = new org.displaytag.util.ParamEncoder("user").encodeParameterName(org.displaytag.tags.TableTagParameters.PARAMETER_PAGE);
        forwardpagename = rpname;
        if (request.getParameter(rpname) != null) {
            try {
                pageNo = Integer.parseInt(request.getParameter(rpname));
            } catch (NumberFormatException e) {
                pageNo = 1;
            }
        } else {
            pageNo = 1;
        }
        if(null == pageSize){
        	pageSize = super.pageSize ;
		}
        SqlFilter filter = new SqlFilter();
        if (null != user.getLoginid() && StringUtils.isNotEmpty(user.getLoginid().trim())) {
            filter.addFilter("loginid", user.getLoginid().trim(),SqlFilter.OP.like);
        }
        if (null != user.getName() && StringUtils.isNotEmpty(user.getName().trim())) {
            filter.addFilter("name", user.getName().trim(),SqlFilter.OP.like);
        }
        filter.addFilter("disabled", false);
        SqlSort sort = new SqlSort();

        sort.addSort("id", "desc");
        modelMap.put("user", user);
        modelMap.put("users", userService.list(filter, sort, pageNo, pageSize));
        modelMap.put("size", userService.count(filter));
        modelMap.put("pageSize", pageSize);
        modelMap.put("forwardpagename", forwardpagename);
        return "admin/user/list";
    }

    /**
     * 查询角色
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/selectRoles") 
    public String selectRoles(HttpServletRequest request,Long id, String authorize,String needAuth,ModelMap modelMap) throws Exception {
    	User user = userService.get(id);
    	modelMap.put("selectRoles", userService.findUsersByParameters(id, authorize));
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
    public String authRoles(HttpServletRequest request,Long id,Long[] ids,String needAuth,ModelMap modelMap) throws Exception {
        if (null != ids && 0 != ids.length) {
            for (Long roleId : ids) {
                if (null == roleId) {
                    continue;
                }

                Role role = this.roleService.get(roleId);
                if (null == role) {
                    continue;
                }
                userService.saveRoles(id, roleId, "true".equalsIgnoreCase(needAuth));
            }
        }
        User user = userService.get(id);
        this.securityCacheService.authRoleInCache(user);

        return "redirect:selectRoles?id="+id;
    }

    /**
     * 修改
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/input") 
    public String input(HttpServletRequest request,Long id,ModelMap modelMap) throws Exception {
    	if(null != id){
    		modelMap.put("id", id);
    		modelMap.put("user", this.userService.get(id));
    	}
        return "admin/user/input";
    }
}
