package ${project.org}.web.controller;

import javax.servlet.http.HttpServletRequest;

import ${project.org}.common.dao.SqlFilter;
import ${project.org}.common.dao.SqlSort;
import ${project.org}.domain.Menu;
import ${project.org}.service.MenuService;
import ${project.org}.common.security.SecurityCacheService;
import ${project.org}.support.UserContext;
import ${project.org}.util.BeanHelper;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 菜单action
 */
@Controller
@RequestMapping("/security/menu")
public class MenuAction extends PageAction{

	private static final long serialVersionUID = 1L;

    @Autowired
    private MenuService menuService;
    @Autowired
    private SecurityCacheService securityCacheService;

    /**
     * 修改
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/input") 
    public String input(HttpServletRequest request,Menu menu,ModelMap modelMap) throws Exception {
    	if(null != menu && menu.getId() != null){
    		modelMap.put("id", menu.getId());
    		Menu old = this.menuService.get(menu.getId());
    		BeanHelper.copyNotNullProperties(menu, old);
    		modelMap.put("menu", old);
    	}
        return "admin/menu/input";
    }
    /**
     * 添加
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/save") 
    public String save(HttpServletRequest request,Menu menu,ModelMap modelMap) {
    	try {
			modelMap.put("menu", menu);
			SqlFilter filter = new SqlFilter();
			if (null == menu.getId()) {
				if (null != menu.getName()
						&& StringUtils.isNotEmpty(menu.getName())) {
					filter.addFilter("name", menu.getName());
				}
				int asize = this.menuService.count(filter);
				if (asize >= 1) {
					UserContext.saveMessage(request, "菜单标示重复");
					return "admin/menu/input";
				}
			} else {
				Menu old = this.menuService.get(menu.getId());
				if (!old.getName().equals(menu.getName())) {
					if (null != menu.getName()
							&& StringUtils.isNotEmpty(menu.getName())) {
						filter.addFilter("name", menu.getName());
					}
					int asize = this.menuService.count(filter);
					if (asize >= 1) {
						UserContext.saveMessage(request, "菜单标示重复");
						return "admin/menu/input";
					}
				}
				BeanHelper.copyNotNullProperties(menu, old);
				menu = old;
			}
			if (null == menu.getParentMenuItem()
					|| null == menu.getParentMenuItem().getId()
					|| StringUtils.isBlank(menu.getParentMenuItem().getId()
							.toString())) {
				menu.setParentMenuItem(null);
			}
			if (null == menu.getLocation()
					|| StringUtils.isBlank(menu.getLocation().toString())) {
				menu.setLocation(null);
			}
			this.menuService.save(menu);
			this.securityCacheService.modifyMenuInCache(menu, menu.getName());
    	} catch (Exception e) {
			e.printStackTrace();
			UserContext.saveMessage(request,"菜单保存出错");
			return "admin/menu/input";
		}
    	Long paId = null;
    	if(null != menu && null != menu.getParentMenuItem() ){
    		paId = menu.getParentMenuItem().getId();
    	}
        return "redirect:list?parentMenuItem.id="+(null != paId?paId:"");
    }

    /**
     * 删除
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/remove") 
    public String remove(HttpServletRequest request,Long id,ModelMap modelMap) {
    	Long paId = null;
        try{
        	Menu menu = menuService.get(id);
        	if(null != menu && null != menu.getParentMenuItem() ){
        		paId = menu.getParentMenuItem().getId();
        	}
    		if(hasChild(id)){
    			UserContext.saveMessage(request,"该菜单有子菜单，不允许被删除！");
    	        return "redirect:list?parentMenuItem.id="+(null != paId?paId:"");
    		}
    		this.menuService.removeById(id);
    		UserContext.saveMessage(request,"删除成功");
    	} catch (Exception e) {
	        UserContext.saveMessage(request,"删除失败");
	    }
    	return "redirect:list?parentMenuItem.id="+(null != paId?paId:"");
    }
    /**
     * 根据传递的batchIds数组中记录的公会活动id批量删除公会活动信息
     * 
     * @return
     */
    @RequestMapping(value="/removeMore") 
    public String removeMore(HttpServletRequest request,Long[] ids,ModelMap modelMap) {
    	Long paId = null;
    	if(ids != null){
    		 try {
	    		for(Long i:ids){
	    			if(hasChild(i)){
	        			UserContext.saveMessage(request,"该菜单有子菜单，不允许被删除！");
	        			continue;
	        		}
	    			Menu m=this.menuService.get(i);
	    			if(null == paId){
	    				if(null != m && null != m.getParentMenuItem() ){
	    	        		paId = m.getParentMenuItem().getId();
	    	        	}
	    			}
	    			this.menuService.remove(m);
	    		}
	    		UserContext.saveMessage(request,"删除成功");
    		 } catch (Exception e) {
 	            UserContext.saveMessage(request,"删除失败！");
 	        }
    	}
    	return "redirect:list?parentMenuItem.id="+(null != paId?paId:"");
    }

    /**
     * 查询
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/list") 
	public String list(HttpServletRequest request,String forwardpagename,Menu menu,Integer pageSize, ModelMap modelMap) throws Exception {
    	//查找当前页
    	String rpname = new org.displaytag.util.ParamEncoder("menu").encodeParameterName(org.displaytag.tags.TableTagParameters.PARAMETER_PAGE);
    	if (request.getParameter(rpname) != null) {
    		pageNo = Integer.parseInt(request.getParameter(rpname));
    	} else {
    		pageNo = 1;
    	}
    	if(null == pageSize){
        	pageSize = super.pageSize ;
		}
    	SqlFilter filter = new SqlFilter();
    	if (null != menu.getName() && StringUtils.isNotEmpty(menu.getName())) {
    		filter.addFilter("name", menu.getName(),SqlFilter.OP.like);
    	}
    	if (null != menu.getTitle() && StringUtils.isNotEmpty(menu.getTitle())) {
    		filter.addFilter("title", menu.getTitle(),SqlFilter.OP.like);
    	}
    	if (null != menu  && null != menu.getParentMenuItem() && null != menu.getParentMenuItem().getId()) {
    		filter.addFilter("parentMenuItem.id", menu.getParentMenuItem().getId());
    	}
    	SqlSort sort = new SqlSort();
    	sort.addSort("id", "desc");
    	modelMap.put("menu", menu);
    	modelMap.put("menus", this.menuService.list(filter, sort, pageNo, pageSize));
        modelMap.put("size", this.menuService.count(filter));
        modelMap.put("pageSize", pageSize);
        modelMap.put("forwardpagename", forwardpagename);
        return "admin/menu/list";
    }
      
    private boolean hasChild(Long id) throws Exception{
    	boolean hasChild = false;
    	SqlFilter filter = new SqlFilter();
    		filter.addFilter("parentMenuItem.id", id);
    	int s = this.menuService.count(filter);
    	if(s > 0){
    		hasChild = true;
    	}
    	return hasChild;
    }
}