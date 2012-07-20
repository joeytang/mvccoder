package ${domain.domainPackage}.web.action.view;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import ${domain.domainRealPackage}.${domain.domainName};
import ${domain.domainPackage}.manager.${domain.domainName}Manager;
import ${project.org}.security.dao.SqlFilter;
import ${project.org}.security.dao.SqlSort;
import ${project.org}.security.web.action.BaseViewAction;
import ${project.org}.util.RenderUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

/**
 * @author joeytang
 * Date: ${project.currentTime}
 * "${domain.domainCnName}"模块前台action
 */
@Controller("view${domain.domainName}Action")
@Scope("prototype")
public class ${domain.domainName}Action extends BaseViewAction implements ModelDriven<${domain.domainName}>, Preparable {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ${domain.idClass.simpleName} ${domain.idName};
    private ${domain.idClass.simpleName}[] ids = new ${domain.idClass.simpleName}[0];
	private ${domain.domainName} ${domain.domainName?uncap_first};
    private List<${domain.domainName}> ${domain.domainName?uncap_first}s = new ArrayList<${domain.domainName}>(0);
    
    @Autowired
    private ${domain.domainName}Manager ${domain.domainName?uncap_first}Manager;

    public ${domain.domainName} getModel() {
        return ${domain.domainName?uncap_first};
    }

    /**
     * 初始化加载
     *
     * @throws Exception
     */
	public void prepare() throws Exception {
        if (null != this.${domain.idName}) {
            this.${domain.domainName?uncap_first} = this.${domain.domainName?uncap_first}Manager.get(this.${domain.idName});
        } 

        if (null == this.${domain.domainName?uncap_first}) {
            this.${domain.domainName?uncap_first} = new ${domain.domainName}();
        } else {
            this.${domain.idName} = this.${domain.domainName?uncap_first}.get${domain.idName?cap_first}();
        }

    }

    /**
     * 页面初始化,用于准备添加和修改
     *
     * @return
     */
    public String input() throws Exception {
        return SUCCESS;
    }
    public void loadOneData(){
        RenderUtils.renderJson(ServletActionContext.getResponse(), ${domain.domainName?uncap_first});
    }
    /**
     * 添加${domain.domainCnName}
     *
     * @return
     */
     public void save() throws Exception {
    	JSONObject json = null;
    	try{
    		/**if(null != temp){
    			String fileName = new Date().getTime() + getExtention(tempFileName);
    			String fDri = FileUtil.UPLOAD_ROOT+ DateUtils.format(new Date(), "yyyyMMdd")+"/";
    			String fPath = fDri + fileName;
    			FileUtil.copy(temp,new File(ConfigUtil.defaultHomePath() + fPath));
    			this.${domain.domainName?uncap_first}.setAtt(fPath);
    		}*/
    		this.${domain.domainName?uncap_first}Manager.save(this.${domain.domainName?uncap_first});
    		json = RenderUtils.getJsonSuccess();
    	}catch (Exception e) {
    		json = RenderUtils.getJsonFailed();
    		json.put("error", e.getMessage());
		}
        RenderUtils.renderText(ServletActionContext.getResponse(), json.toString());
    }
    /**
     * 删除${domain.domainCnName}，操作成功则提示“删除成功”，否则提示“删除失败！”
     *
     * @return
     */
    public void remove() throws Exception {
    	JSONObject json = RenderUtils.getJsonSuccess();
        try {
            this.${domain.domainName?uncap_first}Manager.remove(this.${domain.domainName?uncap_first});
            json.put("msg", "删除成功");
        } catch (Exception e) {
            json.put("msg", "删除成功");
        }
        RenderUtils.renderJson(ServletActionContext.getResponse(), json);
    }

   /**
     * 批量删除${domain.domainCnName}，如果全部都正常删除则提示“删除成功”，否则提示“部分记录删除出错！”
     *
     * @return
     */
    public void removeMore() throws Exception {
    	JSONObject json = RenderUtils.getJsonSuccess();
    	if(this.ids != null){
    		try {
    			for(${domain.idClass.simpleName} i:ids){
    				${domain.domainName} o = this.${domain.domainName?uncap_first}Manager.get(i);
    				this.${domain.domainName?uncap_first}Manager.remove(o);
    			}
    			json.put("msg", "删除成功");
    		} catch (Exception e) {
    			json.put("msg", "部分记录删除出错！");
    		}
    	}
    	RenderUtils.renderJson(ServletActionContext.getResponse(), json);
    }
    
	/**
     * 列表跳转页面
     * @return
     * @throws Exception
     */
	public String list() throws Exception {
    	return SUCCESS;
    }
     /**
     * 列出所有的${domain.domainCnName}信息
     *
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
			if(StringUtils.isNotBlank(sortName) ){
				sort.addSort(sortName, order);
			}
			sort.addSort("id", "desc");
			this.${domain.domainName?uncap_first}s = this.${domain.domainName?uncap_first}Manager.list(filter, sort, page, rows);
			this.total = this.${domain.domainName?uncap_first}Manager.count(filter);
			json = RenderUtils.getJsonSuccess();
			json.put("rows", ${domain.domainName?uncap_first}s);
			json.put("total", this.total);
		} catch (Exception e) {
			e.printStackTrace();
            json = RenderUtils.getJsonFailed();
            json.put("error", e.getMessage());
        }
		RenderUtils.renderJson(ServletActionContext.getResponse(), json);
    }

    public ${domain.domainName} get${domain.domainName}() {
        return ${domain.domainName?uncap_first};
    }

    public void set${domain.domainName}(${domain.domainName} ${domain.domainName?uncap_first}) {
        this.${domain.domainName?uncap_first} = ${domain.domainName?uncap_first};
    }

    public List<${domain.domainName}> get${domain.domainName}s() {
        return ${domain.domainName?uncap_first}s;
    }

    public void set${domain.domainName}s(List<${domain.domainName}> ${domain.domainName?uncap_first}s) {
        this.${domain.domainName?uncap_first}s = ${domain.domainName?uncap_first}s;
    }
    
    /**
	 * @return the id
	 */
	public ${domain.idClass.simpleName} get${domain.idName?cap_first}() {
		return ${domain.idName};
	}

	/**
	 * @param id the id to set
	 */
	public void set${domain.idName?cap_first}(${domain.idClass.simpleName} ${domain.idName}) {
		this.${domain.idName} = ${domain.idName};
	}

	/**
	 * @return the ids
	 */
	public ${domain.idClass.simpleName}[] getIds() {
		return ids;
	}

	/**
	 * @param ids the ids to set
	 */
	public void setIds(${domain.idClass.simpleName}[] ids) {
		this.ids = ids;
	}
}
