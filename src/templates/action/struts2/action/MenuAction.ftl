package ${project.org}.security.web.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import ${project.org}.security.dao.SqlFilter;
import ${project.org}.security.dao.SqlSort;
import ${project.org}.security.domain.Menu;
import ${project.org}.security.domain.MenuTreeRoot;
import ${project.org}.security.domain.Role;
import ${project.org}.security.domain.User;
import ${project.org}.security.manager.MenuManager;
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
 * User: joeytang
 * Date: ${project.currentTime}
 * 菜单action
 */
@Controller
@Scope("prototype")
public class MenuAction extends PageAction implements ModelDriven<Menu>, Preparable {

	private static final long serialVersionUID = 1L;
	private Long id;
    private Long[] ids = new Long[0];
    private Menu menu;
    private Menu parent;
    private List<Menu> menus;
    private String needAuth;
    private String authorize;
    private List<Role> selectRoles = new ArrayList<Role>(0);

    @Autowired
    private MenuManager menuManager;
    @Autowired
    private SecurityCacheManager securityCacheManager;

    public Menu getModel() {
        return this.menu;
    }

    public void prepare() throws Exception {
        if (null != this.id) {
            this.menu = this.menuManager.get(this.id);
        } else {
            this.menu = new Menu();
        }

        if (null == this.menu) {
            this.menu = new Menu();
        } else {
            this.id = this.menu.getId();
        }
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
     * 添加
     * @return
     * @throws Exception
     */
    public void save() throws Exception {
    	JSONObject json = null;
    	try{
    		SqlFilter filter = new SqlFilter();
        	if(null == this.menu.getId()){
    			if (null != this.menu.getName() && StringUtils.isNotEmpty(this.menu.getName())) {
    				filter.addFilter("name", this.menu.getName());
    			}
    			int asize = this.menuManager.count(filter);
    			if(asize >= 1){
    				json = RenderUtils.getJsonFailed();
        			json.put("error","菜单标示重复！");
        			RenderUtils.renderText(ServletActionContext.getResponse(), json.toString());
    				return ;
    			}
        	}else{
        		Menu old = this.menuManager.get(this.menu.getId());
        		if(!old.getName().equals(this.menu.getName())){
        			if (null != this.menu.getName() && StringUtils.isNotEmpty(this.menu.getName())) {
        				filter.addFilter("name", this.menu.getName());
        			}
        			int asize = this.menuManager.count(filter);
        			if(asize >= 1){
        				json = RenderUtils.getJsonFailed();
            			json.put("error","菜单标示重复！");
            			RenderUtils.renderText(ServletActionContext.getResponse(), json.toString());
        				return ;
        			}
        		}
        	}
            if(null == menu.getParent() || null == menu.getParent().getId() || StringUtils.isBlank(menu.getParent().getId().toString()) ){
            	menu.setParent(null);
            } 
            if(null == menu.getLocation() || StringUtils.isBlank(menu.getLocation().toString()) ){
            	menu.setLocation(null);
            }
            menu = this.menuManager.save(menu);
            menu.setParent(this.menuManager.get(menu.getParent().getId()));
            this.securityCacheManager.modifyMenuInCache(this.menu, this.menu.getName());
            StrutsMenuHelper.addMenu(ServletActionContext.getServletContext(),menu);
            json = RenderUtils.getJsonSuccess();
    		RenderUtils.renderText(ServletActionContext.getResponse(), json.toString());
    	}catch (Exception e) {
    		json = RenderUtils.getJsonFailed();
    		json.put("error", e.getMessage());
    		RenderUtils.renderText(ServletActionContext.getResponse(), json.toString());
		}
    	
        return ;
    }

    /**
     * 删除
     * @return
     * @throws Exception
     */
    public void remove() throws Exception {
    	JSONObject json = RenderUtils.getJsonSuccess();
        try{
    		if(hasChild(this.id)){
    			json.put("msg", "该菜单有子菜单，不允许被删除！");
    			RenderUtils.renderJson(ServletActionContext.getResponse(), json);
    			return ;
    		}
    		this.menuManager.removeById(this.id);
    		StrutsMenuHelper.deleteMenu(ServletActionContext.getServletContext(),this.id);
    		json.put("msg", "删除成功");
    	} catch (Exception e) {
    		json = RenderUtils.getJsonFailed();
			json.put("error", "删除失败！");
	    }
        RenderUtils.renderJson(ServletActionContext.getResponse(), json);
    }
    /**
     * 根据传递的batchIds数组中记录的公会活动id批量删除公会活动信息
     * 
     * @return
     */
    public void removeMore() throws Exception {
    	JSONObject json = RenderUtils.getJsonSuccess();
    	if(this.ids != null){
	   		try {
   			 	boolean isAll = true;
	    		for(Long i:ids){
	    			if(hasChild(i)){
	        			isAll = false;
	        			continue;
	        		}
	    			StrutsMenuHelper.deleteMenu(ServletActionContext.getServletContext(),i);
	    			this.menuManager.removeById(i);
	    		}
	    		if(isAll){
	    			json.put("msg", "删除成功");
	    		}else{
	    			json.put("msg", "包含子菜单的记录不允许删除！");
	    		}
	   		 } catch (Exception e) {
	   			json = RenderUtils.getJsonFailed();
    			json.put("error", "部分记录删除出错！");
		     }
	   	}
    	RenderUtils.renderJson(ServletActionContext.getResponse(), json);
    }
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
	    	sort.addSort("id", "asc");
	    	this.menus = this.menuManager.list(filter, sort, -1, -1);
	    	this.total = this.menuManager.count(filter);
	    	MenuTreeRoot menuTreeRoot = new MenuTreeRoot();
	        if(null != this.menus){
	        	for(Menu m:this.menus){
	        		menuTreeRoot.addOrUpdateMenu(m);
	        	}
	        }
	    	JsonConfig c = new JsonConfig();
			c.setExcludes(new String[]{"parent","roles"});
			json = RenderUtils.getJsonSuccess();
			json.put("rows", JSONArray.fromObject(menuTreeRoot.getMenuTree(), c));
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
     * 查询
     * @return
     * @throws Exception
     */
    public String loadMenu() throws Exception {
    	loadAllMenu();
    	return SUCCESS;
    }
    /**
     * 查询
     * @return
     * @throws Exception
     */
    public String loadUserMenu() throws Exception {
    	loadUserAllMenu();
    	return SUCCESS;
    }
    /**
     * 查询
     * @return
     * @throws Exception
     */
    public void loadMenuJson() throws Exception {
    	loadAllMenu();
    	JSONObject json = RenderUtils.getJsonSuccess();
    	json.put("data", this.menus);
    	RenderUtils.renderJson(ServletActionContext.getResponse(), json);
    }
    /**
     * 查询
     * @return
     * @throws Exception
     */
    private void loadAllMenu() throws Exception {
    	MenuTreeRoot menuTreeRoot = StrutsMenuHelper.getMenuTreeRoot(ServletActionContext.getServletContext());
    	if(menuTreeRoot != null){
    		if(parent == null || parent.getId() == null){
    			this.menus = menuTreeRoot.listMenuTree();
    		}else{
    			this.menus = menuTreeRoot.listMenuTree(parent.getId());
    		}
    	}
    }
    /**
     * 查询
     * @return
     * @throws Exception
     */
    private void loadUserAllMenu() throws Exception {
    	User user = UserContext.getBackUser();
    	Set<Role> userRoles = null;
    	MenuTreeRoot menuTreeRoot = StrutsMenuHelper.getMenuTreeRoot(ServletActionContext.getServletContext());
    	if(null != user && (userRoles = user.getRoles()) != null && userRoles.size() > 0 && menuTreeRoot != null){
    		if(parent == null || parent.getId() == null){
    			this.menus = menuTreeRoot.listMenuTree();
    		}else{
    			this.menus = menuTreeRoot.listMenuTree(parent.getId());
    		}
    		if(null != menus){
    			List<Menu> delMenus = new ArrayList<Menu>();
				for(Menu m:menus){
					if(!m.belongToUser(user)){
						delMenus.add(m);
					}else{
						m.authorizeUser(user);
					}
				}
				this.menus.removeAll(delMenus);
    		}
    	}
    }
      
    private boolean hasChild(Long id) throws Exception{
    	boolean hasChild = false;
    	SqlFilter filter = new SqlFilter();
    		filter.addFilter("parent.id", id);
    	int s = this.menuManager.count(filter);
    	if(s > 0){
    		hasChild = true;
    	}
    	return hasChild;
    }
    
    public List<Menu> getMenus() {
        return menus;
    }

	/**
	 * @return the needAuth
	 */
	public String getNeedAuth() {
		return needAuth;
	}

	/**
	 * @param needAuth the needAuth to set
	 */
	public void setNeedAuth(String needAuth) {
		this.needAuth = needAuth;
	}

	/**
	 * @return the authorize
	 */
	public String getAuthorize() {
		return authorize;
	}

	/**
	 * @param authorize the authorize to set
	 */
	public void setAuthorize(String authorize) {
		this.authorize = authorize;
	}

	/**
	 * @return the selectRoles
	 */
	public List<Role> getSelectRoles() {
		return selectRoles;
	}

	/**
	 * @param selectRoles the selectRoles to set
	 */
	public void setSelectRoles(List<Role> selectRoles) {
		this.selectRoles = selectRoles;
	}

	/**
	 * @param menus the menus to set
	 */
	public void setMenus(List<Menu> menus) {
		this.menus = menus;
	}

	public Menu getMenu() {
		return menu;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}
    
	public Menu getparent() {
		return parent;
	}

	public void setparent(Menu parent) {
		this.parent = parent;
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
}