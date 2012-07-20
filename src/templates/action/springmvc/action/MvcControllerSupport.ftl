package ${project.org}.common.controller;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

import ${project.org}.common.dao.BaseDao;
import ${project.org}.common.service.BaseService;

import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

 /**
 * User: joeytang
 * Date: ${project.currentTime}
 * 模板action类
 * 返回的json对象中都包含status属性，表示是否成功。error表示错误信息，msg为提示信息.对象名称表示当前操作的对象
 */
public class MvcControllerSupport<T extends Serializable,PK extends Serializable,M extends BaseService<T,PK, ? extends BaseDao<T,PK>> > extends ActionSupport<T> {
	
	protected M baseService;
	@Autowired
	protected void setBaseService(M baseService){
		this.baseService = baseService;
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

	/**
	 * 绑定属性编辑器
	 * 
	 * @param binder
	 */
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat(getDatePattern());
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new MyDateConverter());
	}

	/**
	 * 获取日期转换格式 默认为yyyy-MM-dd hh:mm:ss 子类可以根据自己需要重写该方法
	 * 
	 * @return
	 */
	protected String getDatePattern() {
		return "yyyy-MM-dd hh:mm:ss";
	}
}