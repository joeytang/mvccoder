package ${project.org}.security.web.action;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import ${project.org}.security.dao.SqlFilter;
import ${project.org}.security.dao.SqlSort;
import ${project.org}.security.domain.Menu;
import ${project.org}.security.domain.MenuTreeRoot;
import ${project.org}.security.domain.Resource;
import ${project.org}.security.domain.Role;
import ${project.org}.security.domain.TreeJson;
import ${project.org}.security.manager.MenuManager;
import ${project.org}.security.manager.ResourceManager;
import ${project.org}.security.manager.RoleManager;
import ${project.org}.security.service.SecurityCacheManager;
import ${project.org}.security.service.UserContext;
import ${project.org}.util.RenderUtils;
import ${project.org}.util.StrutsMenuHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

/**
 * User:joeytang
 * Date: ${project.currentTime}
 * 角色action
 */
@Controller
@Scope("prototype")
public class RoleAction extends PageAction implements ModelDriven<Role>, Preparable {
 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long id;
    private Long[] ids = new Long[0];
    private Role role;
    private List<Role> roles;
    private List<Resource> selectResources = new ArrayList<Resource>(0);
    private List<Menu> selectMenus = new ArrayList<Menu>(0);
    private MenuTreeRoot menuTreeRoot;

    @Autowired
    private SecurityCacheManager securityCacheManager;
    @Autowired
    private RoleManager roleManager;
    @Autowired
    private ResourceManager resourceManager;
    @Autowired
    private MenuManager menuManager;

    private String searchAuthorize;

    private String searchResourceName;
    private String searchResourceType;

    private String searchMenuName;
    private String searchMenuTitle;
    private String needAuth;


    public Role getModel() {
        return role;
    }

    /**
     * 初始化加载
     *
     * @throws Exception
     */
    public void prepare() throws Exception {
        if (null != this.id) {
            this.role = this.roleManager.get(this.id);
        } else {
            this.role = new Role();
        }

        if (null == this.role) {
            this.role = new Role();
        } else {
            this.id = this.role.getId();
        }
    }

    /**
     * 查询
     *
     * @return
     * @throws Exception
     */
    public String list() throws Exception {
        return SUCCESS;
    }
    /**
     * 查询
     * @return
     * @throws Exception
     */
    public void loadTableData() throws Exception {
    	JSONObject json = RenderUtils.getJsonFailed();
		try {
	        SqlFilter filter = new SqlFilter();
	        if(StringUtils.isNotBlank(searchName) && StringUtils.isNotBlank(searchValue)){
				filter.addFilter(searchName, searchValue,SqlFilter.OP.like);
			}
	        SqlSort sort = new SqlSort();
	        sort.addSort("id", "desc");
	        this.roles = this.roleManager.list(filter, sort, page, rows);
	        this.total = this.roleManager.count(filter);
			json = RenderUtils.getJsonSuccess();
			JsonConfig c = new JsonConfig();
			c.setExcludes(new String[]{"users","resources","menus"});
			json.put("rows", JSONArray.fromObject(roles, c));
			json.put("total", this.total);
		} catch (Exception e) {
			e.printStackTrace();
            json = RenderUtils.getJsonFailed();
            json.put("rows", "");
			json.put("total", 0);
            json.put("error", e.getMessage());
        }
        RenderUtils.renderJson(ServletActionContext.getResponse(), json);
    }
    /**
     * 保存
     *
     * @return
     * @throws Exception
     */
    public void save() throws Exception {
    	JSONObject json = null;
    	try{
    		Long oldId = null;
        	SqlFilter filter = new SqlFilter();
        	filter.addFilter("title", this.role.getTitle().trim());
        	List<Role> rs = this.roleManager.list(filter, null, -1, -1);
        	if(null != rs && rs.size() > 0){
        		oldId = rs.get(0).getId();
        	}
            if (oldId != null) {
                 if (this.id != null) {
                    if (oldId.intValue() != this.id.intValue()) {
                    	json = RenderUtils.getJsonFailed();
            			json.put("error","角色名称重复！");
            			RenderUtils.renderText(ServletActionContext.getResponse(), json.toString());
            			return ;
                    }
                } else {
                	json = RenderUtils.getJsonFailed();
                	json.put("error","角色名称重复！");
                	RenderUtils.renderText(ServletActionContext.getResponse(), json.toString());
                    return ;
                }
            }
            role.setTitle(role.getTitle().trim());
            this.roleManager.save(this.role);
            this.securityCacheManager.modifyRoleInCache(this.role);
            json = RenderUtils.getJsonSuccess();
    		RenderUtils.renderText(ServletActionContext.getResponse(), json.toString());
    		return ;
    	}catch (Exception e) {
    		json = RenderUtils.getJsonFailed();
    		json.put("error", e.getMessage());
    		RenderUtils.renderText(ServletActionContext.getResponse(), json.toString());
		}
    	return ;
    	
    }

    /**
     * 修改
     *
     * @return
     * @throws Exception
     */
    public String input() throws Exception {
        return INPUT;
    }


    /**
     * 删除角色集合
     *
     * @return
     * @throws Exception
     */
    public String removeSelected() throws Exception {
        if (null != ids && 0 != ids.length) {
            for (Long id : ids) {
                this.roleManager.removeById(id);
            }
        }

        return SUCCESS;
    }
    /**
     * 批量角色用户，如果全部都正常删除则提示“删除成功”，否则提示“部分记录删除出错！”
     *
     * @return
     */
    public void removeMore() throws Exception {
    	JSONObject json = RenderUtils.getJsonSuccess();
    	if(this.ids != null){
    		try {
    			for(Long i:ids){
    				this.roleManager.removeById(i);
    			}
    			json.put("msg", "删除成功");
    		} catch (Exception e) {
    			json = RenderUtils.getJsonFailed();
    			json.put("error", "部分记录删除出错！");
    		}
    	}
    	RenderUtils.renderJson(ServletActionContext.getResponse(), json);
    }

    /**
     * 菜单授权
     *
     * @return
     * @throws Exception
     */
    public void authMenus() throws Exception {
    	JSONObject json = RenderUtils.getJsonFailed();
		try {
			if (null != ids && 0 != ids.length) {
	            for (Long menuId : ids) {
	                if (null == menuId) {
	                    continue;
	                }
	                Menu menu = this.menuManager.get(menuId);
	                if (null == menu) {
	                    continue;
	                }
	                this.roleManager.saveMenus(this.id, menuId, "true".equalsIgnoreCase(this.needAuth));
	            }
	        }
	        this.securityCacheManager.refreshMenuCache();
	        StrutsMenuHelper.initMenuRespository(ServletActionContext.getServletContext());
	        
	        json = RenderUtils.getJsonSuccess();
			json.put("msg", "菜单分配成功");
		} catch (Exception e) {
			e.printStackTrace();
            json = RenderUtils.getJsonFailed();
            json.put("error", e.getMessage());
        }
        RenderUtils.renderJson(ServletActionContext.getResponse(), json);
    }

    /**
     * 资源授权
     *
     * @return
     * @throws Exception
     */

    public void authResources() throws Exception {
    	JSONObject json = RenderUtils.getJsonFailed();
		try {
	        if (null != ids && 0 != ids.length) {
	            for (Long resourceId : ids) {
	                if (null == resourceId) {
	                    continue;
	                }
	
	                Resource resource = this.resourceManager.get(resourceId);
	                if (null == resource) {
	                    continue;
	                }
	
	                this.roleManager.saveResources(this.id, resourceId, "true".equalsIgnoreCase(this.needAuth));
	            }
	        }
	        this.securityCacheManager.refreshResourceCache();
	        json = RenderUtils.getJsonSuccess();
			json.put("msg", "权限分配成功");
		} catch (Exception e) {
			e.printStackTrace();
	        json = RenderUtils.getJsonFailed();
	        json.put("error", e.getMessage());
	    }
	    RenderUtils.renderJson(ServletActionContext.getResponse(), json);
    }

    /**
     * 查询菜单
     *
     * @return
     * @throws Exception
     */
    public void selectMenus() throws Exception {
        this.selectMenus = this.roleManager.findMenusByParameters(this.id, searchAuthorize);
        menuTreeRoot = new MenuTreeRoot();
        if(null != this.selectMenus){
        	for(Menu m:this.selectMenus){
        		menuTreeRoot.addOrUpdateMenu(m);
        	}
        }
        List<TreeJson> treeJson = new ArrayList<TreeJson>();
        List<Menu> menus = menuTreeRoot.getMenuTree();
        if(null != menus){
        	for(Menu m:menus){
        		treeJson.add(TreeJson.fromMenu(m));
        	}
        }
        RenderUtils.renderJson(ServletActionContext.getResponse(), treeJson);
    }

    /**
     * 查询角色
     *
     * @return
     * @throws Exception
     */
    public void selectResources() throws Exception {
    	JSONObject json = RenderUtils.getJsonFailed();
		try {
			this.selectResources = this.roleManager.findResourcesByParameters(this.id, searchAuthorize);
			JsonConfig c = new JsonConfig();
			c.setExcludes(new String[]{"roles","authorities"});
			json = RenderUtils.getJsonSuccess();
			json.put("rows", JSONArray.fromObject(selectResources, c));
		} catch (Exception e) {
			e.printStackTrace();
            json = RenderUtils.getJsonFailed();
            json.put("rows", "");
            json.put("error", e.getMessage());
        }
        RenderUtils.renderJson(ServletActionContext.getResponse(), json);
    }


    public List<Role> getRoles() {
        return roles;
    }

    public List<Resource> getSelectResources() {
        return selectResources;
    }

    public List<Menu> getSelectMenus() {
        return selectMenus;
    }

    public String getSearchResourceName() {
        return searchResourceName;
    }

    public void setSearchResourceName(String searchResourceName) {
        this.searchResourceName = searchResourceName;
    }

    public String getSearchResourceType() {
        return searchResourceType;
    }

    public void setSearchResourceType(String searchResourceType) {
        this.searchResourceType = searchResourceType;
    }

    public String getSearchMenuName() {
        return searchMenuName;
    }

    public void setSearchMenuName(String searchMenuName) {
        this.searchMenuName = searchMenuName;
    }

    public String getSearchMenuTitle() {
        return searchMenuTitle;
    }

    public void setSearchMenuTitle(String searchMenuTitle) {
        this.searchMenuTitle = searchMenuTitle;
    }


    public String getNeedAuth() {
        return needAuth;
    }

    public void setNeedAuth(String needAuth) {
        this.needAuth = needAuth;
    }

    public String getSearchAuthorize() {
        return searchAuthorize;
    }

    public void setSearchAuthorize(String searchAuthorize) {
        this.searchAuthorize = searchAuthorize;
    }
    
    /**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * @return the ids
	 */
	public Long[] getIds() {
		return ids;
	}

	/**
	 * @param ids the ids to set
	 */
	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	public MenuTreeRoot getMenuTreeRoot() {
		return menuTreeRoot;
	}

	public void setMenuTreeRoot(MenuTreeRoot menuTreeRoot) {
		this.menuTreeRoot = menuTreeRoot;
	}
	

}
