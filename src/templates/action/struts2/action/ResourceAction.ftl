package ${project.org}.security.web.action;

import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import ${project.org}.security.dao.SqlFilter;
import ${project.org}.security.dao.SqlSort;
import ${project.org}.security.domain.Resource;
import ${project.org}.security.manager.ResourceManager;
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
 * 资源action
 */
@Controller
@Scope("prototype")
public class ResourceAction extends PageAction implements ModelDriven<Resource>, Preparable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long id;
    private Long[] ids = new Long[0];
    private Resource resource;
    private List<Resource> resources;
    
    @Autowired
    private SecurityCacheManager securityCacheManager;
    @Autowired
    private ResourceManager resourceManager;


    /**
     * 初始化
     * @throws Exception
     */
    public void prepare() throws Exception {
        if (null != this.id) {
            this.resource = this.resourceManager.get(this.id);
        } else {
            this.resource = new Resource();
        }

        if (null == this.resource) {
            this.resource = new Resource();
        } else {
            this.id = this.resource.getId();
        }
    }

    public Resource getModel() {
        return this.resource;
    }



    @Override
    public String execute() throws Exception {
        return this.list();
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
	        sort.addSort("id", "desc");
	        this.resources = this.resourceManager.list(filter, sort, page, rows);
	        this.total = this.resourceManager.count(filter);
	        JsonConfig c = new JsonConfig();
			c.setExcludes(new String[]{"roles","authorities"});
			json.put("rows", JSONArray.fromObject(resources, c));
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
     * 添加编辑
     * @return
     * @throws Exception
     */
    public String input() throws Exception {

        return INPUT;
    }

    /**
     * 保存
     * @return
     * @throws Exception
     */
    public void save() throws Exception {
    	JSONObject json = null;
    	try{
    		if (null != this.resource) {
    			this.resourceManager.save(this.resource);
    	    }
	        this.securityCacheManager.modifyResourceInCache(this.resource, this.resource.getName());
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
        try {
        	this.resourceManager.removeById(this.id);
            json.put("msg", "删除成功");
        } catch (Exception e) {
        	json = RenderUtils.getJsonFailed();
            json.put("error", "删除失败");
        }
        RenderUtils.renderJson(ServletActionContext.getResponse(), json);
    }
    /**
     * 批量删除
     *
     * @return
     */
    public void removeMore() throws Exception {
    	JSONObject json = RenderUtils.getJsonSuccess();
    	if(this.ids != null){
    		try {
    			for(Long i:ids){
    				this.resourceManager.removeById(i);
    			}
    			json.put("msg", "删除成功");
    		} catch (Exception e) {
    			json = RenderUtils.getJsonFailed();
    			json.put("error", "部分记录删除出错！");
    		}
    	}
    	RenderUtils.renderJson(ServletActionContext.getResponse(), json);
    }
    public void mapResourceType(){
//    	当输入关键字时查询条件以变量名q传递
//    	String q = ServletActionContext.getRequest().getParameter("q"); 
    	RenderUtils.renderJson(ServletActionContext.getResponse(), Resource.typeMap.entrySet());
    }
    
    public List<Resource> getResources() {
        return resources;
    }

	/**
	 * @return the resource
	 */
	public Resource getResource() {
		return resource;
	}

	/**
	 * @param resource the resource to set
	 */
	public void setResource(Resource resource) {
		this.resource = resource;
	}

	/**
	 * @param resources the resources to set
	 */
	public void setResources(List<Resource> resources) {
		this.resources = resources;
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

