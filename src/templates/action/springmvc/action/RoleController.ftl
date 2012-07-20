package ${project.org}.security.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import ${project.org}.common.dao.SqlFilter;
import ${project.org}.common.dao.SqlSort;
import ${project.org}.domain.Menu;
import ${project.org}.domain.Resource;
import ${project.org}.domain.Role;
import ${project.org}.service.MenuService;
import ${project.org}.service.ResourceService;
import ${project.org}.service.RoleService;
import ${project.org}.common.security.SecurityCacheService;
import ${project.org}.support.UserContext;
import ${project.org}.util.BeanHelper;
import ${project.org}.util.StrutsMenuHelper;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 角色action
 */
@Controller
@RequestMapping("/security/role")
public class RoleAction extends PageAction {

	private static final long serialVersionUID = 1L;

	@Autowired
	private SecurityCacheService securityCacheService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private ResourceService resourceService;

	/**
	 * 修改
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/input")
	public String input(HttpServletRequest request, Role role, ModelMap modelMap)
			throws Exception {
		if (null != role && role.getId() != null) {
			modelMap.put("id", role.getId());
			Role old = this.roleService.get(role.getId());
			BeanHelper.copyNotNullProperties(role, old);
			modelMap.put("role", old);
		}
		return "admin/role/input";
	}

	/**
	 * 添加
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public String save(HttpServletRequest request, Role role, ModelMap modelMap) {
		try {
			modelMap.put("role", role);
			Long oldId = null;
	    	SqlFilter filter = new SqlFilter();
	    	filter.addFilter("title", role.getTitle().trim());
	    	List<Role> rs = this.roleService.list(filter, null, -1, -1);
	    	if(null != rs && rs.size() > 0){
	    		oldId = rs.get(0).getId();
	    	}
	        if (oldId != null) {
	             if (role.getId() != null) {
	                if (oldId.intValue() != role.getId().intValue()) {
	                	UserContext.saveMessage(request,"角色名称重复！！");
	                	return "admin/role/input";
	                }
	            } else {
	                UserContext.saveMessage(request,"角色名称重复！！");
	                return "admin/role/input";
	            }
	        }
	        
			if (null != role.getId()) {
				Role old = this.roleService.get(role.getId());
				BeanHelper.copyNotNullProperties(role, old);
				role = old;
			} 
			this.roleService.save(role);
			this.securityCacheService.modifyRoleInCache(role);
		} catch (Exception e) {
			e.printStackTrace();
			UserContext.saveMessage(request, "角色保存出错");
			return "admin/role/input";
		}
		return "redirect:list";
	}

	/**
	 * 删除
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/remove")
	public String remove(HttpServletRequest request, Long id, ModelMap modelMap) {
		try {
			Role role = this.roleService.get(id);
			if (null != role && 0 == role.getUsers().size() && 0 == role.getResources().size() && 0 == role.getMenus().size()) {
	            this.roleService.removeById(id);
	        }else{
	        	UserContext.saveMessage(request, "该角色在使用不能删除");
	        }
			UserContext.saveMessage(request, "删除成功");
		} catch (Exception e) {
			UserContext.saveMessage(request, "删除失败");
		}
		return "redirect:list" ;
	}

	/**
	 * 根据传递的batchIds数组中记录的公会活动id批量删除公会活动信息
	 * 
	 * @return
	 */
	@RequestMapping(value = "/removeMore")
	public String removeMore(HttpServletRequest request, Long[] ids,
			ModelMap modelMap) {
		if (ids != null) {
			try {
				for (Long i : ids) {
					this.roleService.removeById(i);
				}
				UserContext.saveMessage(request, "删除成功");
			} catch (Exception e) {
				UserContext.saveMessage(request, "删除失败！");
			}
		}
		return "redirect:list" ;
	}

	/**
	 * 查询
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request, String forwardpagename,
			Role role, Integer pageSize, ModelMap modelMap) throws Exception {
		// 查找当前页
		String rpname = new org.displaytag.util.ParamEncoder("role")
				.encodeParameterName(org.displaytag.tags.TableTagParameters.PARAMETER_PAGE);
		if (request.getParameter(rpname) != null) {
			pageNo = Integer.parseInt(request.getParameter(rpname));
		} else {
			pageNo = 1;
		}
		if (null == pageSize) {
			pageSize = super.pageSize;
		}
		SqlFilter filter = new SqlFilter();
		if (null != role.getTitle() && StringUtils.isNotEmpty(role.getTitle())) {
			filter.addFilter("title", role.getTitle(), SqlFilter.OP.like);
		}
		SqlSort sort = new SqlSort();
		sort.addSort("id", "desc");
		
		modelMap.put("role", role);
		modelMap.put("roles",
				this.roleService.list(filter, sort, pageNo, pageSize));
		modelMap.put("size", this.roleService.count(filter));
		modelMap.put("pageSize", pageSize);
		modelMap.put("forwardpagename", forwardpagename);
		return "admin/role/list";
	}
	
	/**
     * 菜单授权
     *
     * @return
     * @throws Exception
     */
	@RequestMapping(value="/authMenus") 
    public String authMenus(HttpServletRequest request,Long id,Long[] ids,String needAuth,ModelMap modelMap) throws Exception{
        if (null != ids && 0 != ids.length) {
            for (Long menuId : ids) {
                if (null == menuId) {
                    continue;
                }
                Menu menu = this.menuService.get(menuId);
                if (null == menu) {
                    continue;
                }

                this.roleService.saveMenus(id, menuId, "true".equalsIgnoreCase(needAuth));
            }
        }
        this.securityCacheService.refreshMenuCache();
        StrutsMenuHelper.initMenuRespository(request.getSession().getServletContext());
        return "redirect:selectMenus?id="+id;
    }

    /**
     * 资源授权
     *
     * @return
     * @throws Exception
     */
	@RequestMapping(value="/authResources") 
    public String authResources(HttpServletRequest request,Long id,Long[] ids,String needAuth,ModelMap modelMap) throws Exception{
        if (null != ids && 0 != ids.length) {
            for (Long resourceId : ids) {
                if (null == resourceId) {
                    continue;
                }
                Resource resource = this.resourceService.get(resourceId);
                if (null == resource) {
                    continue;
                }
                this.roleService.saveResources(id, resourceId, "true".equalsIgnoreCase(needAuth));
            }
        }
        this.securityCacheService.refreshResourceCache();
        return "redirect:selectResources?id="+id;

    }

    /**
     * 查询菜单
     *
     * @return
     * @throws Exception
     */
	@RequestMapping(value="/selectMenus") 
    public String selectMenus(HttpServletRequest request,Long id, String authorize,String needAuth,ModelMap modelMap) throws Exception {
        Role role = roleService.get(id);
    	modelMap.put("selectMenus", this.roleService.findMenusByParameters(id, authorize));
    	modelMap.put("authorize", authorize);
    	modelMap.put("needAuth", needAuth);
        modelMap.put("role", role);
        return "admin/role/selectMenus";
    }

    /**
     * 查询角色
     *
     * @return
     * @throws Exception
     */
	@RequestMapping(value="/selectResources") 
    public String selectResources(HttpServletRequest request,Long id, String authorize,String needAuth,ModelMap modelMap) throws Exception {
        Role role = roleService.get(id);
    	modelMap.put("selectResources", this.roleService.findResourcesByParameters(id, authorize));
    	modelMap.put("authorize", authorize);
    	modelMap.put("needAuth", needAuth);
        modelMap.put("role", role);
        return "admin/role/selectResources";
    }
}