package ${project.org}.com.action;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import ${project.org}.security.dao.SqlFilter;
import ${project.org}.security.dao.SqlSort;
import ${project.org}.security.manager.BaseManager;
import ${project.org}.tool.paging.CommonList;
import ${project.org}.util.BeanHelper;
import ${project.org}.util.ConfigUtil;
import ${project.org}.util.FileUtil;
import ${project.org}.util.RenderUtils;
import ${project.org}.util.StringUtil;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

 /**
 * User: joeytang
 * Date: ${project.currentTime}
 * 模板action类
 * 返回的json对象中都包含status属性，表示是否成功。error表示错误信息，msg为提示信息.对象名称表示当前操作的对象
 *
 */
public abstract class ActionSupport<T extends Serializable, PK extends Serializable> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private transient final Log logger = LogFactory.getLog(this.getClass());
	protected BaseManager<T, PK> baseManager;
	protected final Class<T> entityClass;
	protected String className;
	protected int pageNo = 1; // 当前页
	protected int size; // 总记录数
	protected int pageSize = 20;// 分页记录

	protected CommonList commonList;// 自定义分页对象

	@SuppressWarnings("unchecked")
	public ActionSupport() {
		this.entityClass = (Class<T>) ((ParameterizedType) getClass()
				.getGenericSuperclass()).getActualTypeArguments()[0];
		className = entityClass.getSimpleName();
	}

	/**
	 * 添加或修改对象
	 * 
	 * @return
	 * @throws Exception
	 */
	public void doInput(HttpServletRequest request, PK id, ModelMap modelMap)
			throws Exception {
		modelMap.put(this.getIdName(), id);
		T old = this.baseManager.get(id);
		modelMap.put(StringUtil.lowerFirstChar(className), old);
	}

	/**
	 * 列出所有的对象
	 * 
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	public void doList(HttpServletRequest request, ModelMap modelMap, T t,
			Integer pageNo, Integer pageSize) throws Exception {
		// 查找当前页
		if (null == pageSize) {
			pageSize = this.pageSize;
		}
		if (null == pageNo) {
			pageNo = 1;
		}
		pageNo = Math.max(1, pageNo);
		List<T> ts = customList(request, t, pageNo, pageSize);
		int size = customCount(request, t);
		modelMap.put(StringUtil.lowerFirstChar(className), t);
		modelMap.put(StringUtil.lowerFirstChar(className) + "s", ts);
		CommonList commonList = new CommonList(size, pageNo, pageSize);
		modelMap.put("commonList", commonList);
	}

	protected List<T> customList(HttpServletRequest request, T t,
			Integer pageNo, Integer pageSize) throws Exception {
		SqlFilter filter = new SqlFilter();
		SqlSort sort = new SqlSort();
		sort.addSort(this.getIdName(), "desc");
		List<T> ts = baseManager.list(filter, sort, pageNo, pageSize);
		return ts;
	}

	protected int customCount(HttpServletRequest request, T t) throws Exception {
		SqlFilter filter = new SqlFilter();
		int size = baseManager.count(filter);
		return size;
	}

	/**
	 * 保存选项
	 * 
	 * @return
	 */
	public JSONObject doSave(HttpServletRequest request, T domain,
			ModelMap modelMap) throws Exception {
		JSONObject json = customSave(request, domain, modelMap);
		if (null != json
				&& json.getString(RenderUtils.KEY_STATUS) == RenderUtils.VALUE_FAIL) {
			return json;
		}
		modelMap.put(StringUtil.lowerFirstChar(className), domain);
		PK id = getId(domain);
		if (null != id) {
			logger.info("edit " + className + ":" + id);
			T old = baseManager.get(id);
			BeanHelper.copyNotNullProperties(domain, old);
			domain = old;
		}
		domain = baseManager.save(domain);
		logger.info("edit " + className + ":" + domain);
		modelMap.put(StringUtil.lowerFirstChar(className), domain);
		return RenderUtils.getJsonSuccess();
	}

	public JSONObject customSave(HttpServletRequest request, T domain,
			ModelMap modelMap) {
		return RenderUtils.getJsonSuccess();
	}

	/**
	 * 删除对象
	 * 
	 * @return
	 */
	public JSONObject doRemove(HttpServletRequest request, PK id,
			ModelMap modelMap) {
		JSONObject json = null;
		try {
			logger.info("remove " + className + ":" + id);
			this.baseManager.removeById(id);
			json = RenderUtils.getJsonSuccess();
		} catch (Exception e) {
			json = RenderUtils.getJsonFailed();
		}
		json.put(this.getIdName(), id);
		return json;
	}

	/**
	 * 批量删除对象
	 * 
	 * @return
	 */
	public JSONObject doRemoveMore(HttpServletRequest request, PK[] ids,
			ModelMap modelMap) {
		JSONObject json = null;
		if (ids != null) {
			int c = 0;
			try {
				for (PK i : ids) {
					logger.info("remove " + className + ":" + i);
					this.baseManager.removeById(i);
					c++;
				}
				json = RenderUtils.getJsonSuccess();
			} catch (Exception e) {
				json = RenderUtils.getJsonFailed();
				if (c < ids.length) {
					List<PK> failIds = new ArrayList<PK>();
					for (int j = c; j < ids.length; j++) {
						failIds.add(ids[j]);
					}
					modelMap.put("failIds", failIds);
					json.put("failIds", failIds);
				}
			}
			json.put("ids", ids);
		}
		return json;
	}

	/**
	 * 上传文件 将上传的文件拷贝到/admin/upload目录下，
	 * 并返回拷贝后的文件的绝对路径
	 * 
	 * 
	 * @return 上传到服务器的文件的绝对路径
	 * @throws IOException
	 * @throws Exception
	 */
	protected JSONObject uploads(File upload, String uploadFileName,
			String ext, String fileDir) {
		JSONObject json = null;
		if (upload == null) {
			json = RenderUtils.getJsonFailed();
			json.put(RenderUtils.KEY_ERROR, "文件为空");
			return json;
		}
		String pos = FileUtil.getExtention(uploadFileName);
		if (null == ext || ext.toLowerCase().equals(pos.toLowerCase())) {
			String filename = new Date().getTime() + pos;
			String path = ConfigUtil.defaultHomePath() + fileDir;
			File newFile = new File(path);
			if (!newFile.isDirectory()) {
				newFile.mkdirs();
			}
			path = ConfigUtil.defaultHomePath() + fileDir + "/" + filename;
			newFile = new File(path);
			try {
				FileUtil.copy(upload, newFile);
			} catch (IOException e) {
				e.printStackTrace();
				json = RenderUtils.getJsonFailed();
				json.put(RenderUtils.KEY_ERROR, "文件拷贝出错");
				return json;
			}
			json = RenderUtils.getJsonSuccess();
			json.put(RenderUtils.KEY_RESULT, fileDir + "/" + filename);
		} else {
			json = RenderUtils.getJsonFailed();
			json.put(RenderUtils.KEY_ERROR, "扩展名有误");
		}
		return json;

	}

	/**
	 * 绑定属性编辑器
	 * 
	 * @param binder
	 */
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat(getDatePattern());
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(
				dateFormat, false));
	}

	/**
	 * 获取日期转换格式 默认为yyyy-MM-dd hh:mm:ss 子类可以根据自己需要重写该方法
	 * 
	 * @return
	 */
	protected String getDatePattern() {
		return "yyyy-MM-dd hh:mm:ss";
	}
	/**
	 * 获取模块主键名称
	 * 
	 * @return
	 */
	protected String getIdName() {
		return "id";
	}
	/**
	 * 根据模块对象获取模块主键值
	 * 
	 * @return
	 */
	protected PK getId(T domain) {
		BeanWrapper wrapper = new BeanWrapperImpl(domain);
		@SuppressWarnings("unchecked")
		PK id = (PK) wrapper.getPropertyValue(this.getIdName());
		return id;
	}
}
