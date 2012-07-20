package ${project.org}.security.web.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import ${project.org}.security.dao.SqlFilter;
import ${project.org}.security.dao.SqlSort;
import ${project.org}.security.domain.Role;
import ${project.org}.security.domain.User;
import ${project.org}.security.manager.RoleManager;
import ${project.org}.security.manager.UserManager;
import ${project.org}.security.service.SecurityCacheManager;
import ${project.org}.security.service.UserContext;
import ${project.org}.util.RenderUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;
/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 用户action
 */
@Controller
@Scope("prototype")
public class UserAction extends PageAction implements ModelDriven<User>, Preparable {
/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long id;
    private Long[] ids = new Long[0];
    private User user;
    private List<User> users = new ArrayList<User>(0);
    private List<Role> selectRoles = new ArrayList<Role>(0);

    private String needAuth;
    private String authorize;

    private String searchRoleName;
    private String searchRoleDesccn;
    private String searchAuthorize;

    @Autowired
    private SecurityCacheManager securityCacheManager;
    @Autowired
    private UserManager userManager;
    @Autowired
    private RoleManager roleManager;


    public User getModel() {
        return user;
    }

    /**
     * 初始化加载
     * @throws Exception
     */
    public void prepare() throws Exception {
        if (null != this.id) {
            this.user = this.userManager.get(this.id);
        } else {
            this.user = new User();
        }

        if (null == this.user) {
            this.user = new User();
        } else {
            this.id = this.user.getId();
        }

    }

    public String execute() throws Exception {
        return this.list();
    }


    /**
     * 添加
     * @return
     */
    public void save() {
    	JSONObject json = null;
    	try{
    		if (null != this.user.getLoginid() && 0 != this.user.getLoginid().trim().length()) {
        		User existUser = null;
        		try {
        			SqlFilter filter = new SqlFilter();
        			filter.addFilter("loginid", this.user.getLoginid().trim());
        			List<User> us = this.userManager.list(filter, null, -1, -1);
        			if(null != us && us.size() > 0){
        				existUser = us.get(0);
        			}
        		} catch (Exception e) {
        			json = RenderUtils.getJsonFailed();
        			json.put("error","该帐号已经存在！");
        			RenderUtils.renderText(ServletActionContext.getResponse(), json.toString());
        			return ;
        		}
        		
        		if (null == this.user.getId()) {
        			if (null != existUser) {
        				if (existUser.isDisabled()) {
        					existUser.setDisabled(false);
        					existUser.setName(this.user.getName());
        					try {
        						this.userManager.save(existUser);
        						json = RenderUtils.getJsonSuccess();
        		        		RenderUtils.renderText(ServletActionContext.getResponse(), json.toString());
        					} catch (Exception e) {
        						json = RenderUtils.getJsonFailed();
        						RenderUtils.renderText(ServletActionContext.getResponse(), json.toString());
        	        			json.put("error","该帐号已经存在,保存出错！");
        					}
        					return ;
        				} else {
        					json = RenderUtils.getJsonFailed();
    	        			json.put("error","该帐号已经存在！");
    	        			RenderUtils.renderText(ServletActionContext.getResponse(), json.toString());
        					return ;
        				}
        			}
        			this.user.setLoginid(this.user.getLoginid().trim());
        			this.user.setDisabled(false);
        			
        			this.user.setCreateDate(new Date());
        		}
        		
        		try {
        			this.userManager.save(this.user);
        		} catch (Exception e) {
        			json = RenderUtils.getJsonFailed();
        			json.put("error","该帐号保存出错！");
        			RenderUtils.renderText(ServletActionContext.getResponse(), json.toString());
        			return ;
        		}
        		
        		this.securityCacheManager.modifyUserInCache(this.user, this.user.getLoginid());
        		json = RenderUtils.getJsonSuccess();
        		RenderUtils.renderText(ServletActionContext.getResponse(), json.toString());
        		return ;
        	} else {
        		json = RenderUtils.getJsonFailed();
    			json.put("error","用户名为空！");
    			RenderUtils.renderText(ServletActionContext.getResponse(), json.toString());
        		return ;
        	}
    	}catch (Exception e) {
    		json = RenderUtils.getJsonFailed();
    		json.put("error", e.getMessage());
    		RenderUtils.renderText(ServletActionContext.getResponse(), json.toString());
		}
    	return ;
    }
    /**
     * 修改密码
     * @return
     */
    public void changePwd() {
    	JSONObject json = RenderUtils.getJsonFailed();
    	User user = UserContext.getBackUser();
    	try{
    		if(user != null){
    			user.setPasswd(this.user.getPasswd());
    			this.userManager.save(user);
    			json = RenderUtils.getJsonSuccess();
    		}
    	}catch(Exception e){
    		json = RenderUtils.getJsonFailed();
    	}
    	RenderUtils.renderJson(ServletActionContext.getResponse(), json);
    }

    public String list() throws Exception {
    	return SUCCESS;
    }
    /**
     * 删除集合
     * @return
     */
    public String removeSelected() {
        if (null != ids && 0 != ids.length) {
            for (Long id : ids) {
                try {
					this.userManager.disable(id);
				} catch (Exception e) {
				}
            }
        }
        return SUCCESS;
    }
    /**
     * 删除用户，操作成功则提示“删除成功”，否则提示“删除失败！”
     *
     * @return
     */
    public void remove() throws Exception {
    	JSONObject json = RenderUtils.getJsonSuccess();
        try {
        	this.userManager.disable(id);
            json.put("msg", "删除成功");
        } catch (Exception e) {
        	json = RenderUtils.getJsonFailed();
            json.put("error", "删除失败");
        }
        RenderUtils.renderJson(ServletActionContext.getResponse(), json);
    }

    /**
     * 批量删除用户，如果全部都正常删除则提示“删除成功”，否则提示“部分记录删除出错！”
     *
     * @return
     */
    public void removeMore() throws Exception {
    	JSONObject json = RenderUtils.getJsonSuccess();
    	if(this.ids != null){
    		try {
    			for(Long i:ids){
    				this.userManager.removeById(i);
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
     * 批量启用用户，如果全部都正常删除则提示“启用成功”，否则提示“部分记录启用出错！”
     *
     * @return
     */
    public void enableMore() throws Exception {
    	JSONObject json = RenderUtils.getJsonSuccess();
    	if(this.ids != null){
    		try {
    			for(Long i:ids){
    				this.userManager.enable(i);
    			}
    			json.put("msg", "启用成功");
    		} catch (Exception e) {
    			json = RenderUtils.getJsonFailed();
    			json.put("error", "部分记录启用出错！");
    		}
    	}
    	RenderUtils.renderJson(ServletActionContext.getResponse(), json);
    }
   /**
     * 批量禁用用户，如果全部都正常删除则提示“禁用成功”，否则提示“部分记录禁用出错！”
     *
     * @return
     */
    public void disableMore() throws Exception {
    	JSONObject json = RenderUtils.getJsonSuccess();
    	if(this.ids != null){
    		try {
    			for(Long i:ids){
    				this.userManager.disable(i);
    			}
    			json.put("msg", "禁用成功");
    		} catch (Exception e) {
    			json = RenderUtils.getJsonFailed();
                json.put("error", "部分记录禁用出错！");
    		}
    	}
    	RenderUtils.renderJson(ServletActionContext.getResponse(), json);
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
//			filter.addFilter("disabled", false);
			SqlSort sort = new SqlSort();
			if(StringUtils.isNotBlank(sortName) ){
				sort.addSort(sortName, order);
			}
			sort.addSort("id", "desc");
			this.users = this.userManager.list(filter, sort, page, rows);
			this.total = this.userManager.count(filter);
			json = RenderUtils.getJsonSuccess();
//			json.put("rows", users);
			JsonConfig c = new JsonConfig();
			c.setExcludes(new String[]{"roles","authorities","menus"});
			json.put("rows", JSONArray.fromObject(users, c));
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
     * 查询角色
     * @return
     * @throws Exception
     */
    public void selectRoles() throws Exception {
    	JSONObject json = RenderUtils.getJsonFailed();
		try {
			this.selectRoles = this.userManager.findUsersByParameters(this.id, authorize);
			JsonConfig c = new JsonConfig();
			c.setExcludes(new String[]{"resources","users","menus"});
			json = RenderUtils.getJsonSuccess();
			json.put("rows", JSONArray.fromObject(selectRoles, c));
		} catch (Exception e) {
			e.printStackTrace();
            json = RenderUtils.getJsonFailed();
            json.put("rows", "");
            json.put("error", e.getMessage());
        }
        RenderUtils.renderJson(ServletActionContext.getResponse(), json);
    }

    /**
     * 角色授权
     * @return
     * @throws Exception
     */
    public void authRoles() throws Exception {
        JSONObject json = RenderUtils.getJsonFailed();
		try {
			if (null != ids && 0 != ids.length) {
	            for (Long roleId : ids) {
	                if (null == roleId) {
	                    continue;
	                }
	                Role role = this.roleManager.get(roleId);
	                if (null == role) {
	                    continue;
	                }
	                this.userManager.saveRoles(this.id, roleId, "true".equalsIgnoreCase(this.needAuth));
	            }
	        }
			json = RenderUtils.getJsonSuccess();
			json.put("msg", "角色分配成功");
	        this.securityCacheManager.authRoleInCache(user);
		} catch (Exception e) {
			e.printStackTrace();
            json = RenderUtils.getJsonFailed();
            json.put("error", e.getMessage());
        }
        RenderUtils.renderJson(ServletActionContext.getResponse(), json);
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


    public List<User> getUsers() {
        return users;
    }

    public String getNeedAuth() {
        return needAuth;
    }

    public void setNeedAuth(String needAuth) {
        this.needAuth = needAuth;
    }

    public String getAuthorize() {
        return authorize;
    }

    public void setAuthorize(String authorize) {
        this.authorize = authorize;
    }

    public List<Role> getSelectRoles() {
        return selectRoles;
    }

    public String getSearchRoleName() {
        return searchRoleName;
    }

    public void setSearchRoleName(String searchRoleName) {
        this.searchRoleName = searchRoleName;
    }

    public String getSearchRoleDesccn() {
        return searchRoleDesccn;
    }

    public void setSearchRoleDesccn(String searchRoleDesccn) {
        this.searchRoleDesccn = searchRoleDesccn;
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
}
