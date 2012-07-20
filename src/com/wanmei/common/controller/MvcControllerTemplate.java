package com.wanmei.common.controller;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wanmei.common.dao.BaseDao;
import com.wanmei.common.dao.SqlFilter;
import com.wanmei.common.dao.SqlSort;
import com.wanmei.common.service.BaseService;
import com.wanmei.support.SortBean;
import com.wanmei.tool.paging.CommonList;
import com.wanmei.util.BeanHelper;
import com.wanmei.util.RenderUtils;
import com.wanmei.util.StringUtil;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.ui.ModelMap;

 /**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * 模板action类
 */
public class MvcControllerTemplate<T extends Serializable,PK extends Serializable,M extends BaseService<T,PK, ? extends BaseDao<T,PK>> > extends MvcControllerSupport<T,PK,M> {
	
	/**
	 * 添加对象
	 * 
	 * @return 返回到模块下input.jsp
	 * @throws Exception
	 */
	public String input(HttpServletRequest request,HttpServletResponse response , ModelMap modelMap) {
		return StringUtil.lowerFirstChar( className)+"/input";
	}
	/**
	 * 修改对象
	 * 
	 * @return 返回到模块下input.jsp
	 * @throws Exception
	 */
	public String update(HttpServletRequest request,HttpServletResponse response, PK id, ModelMap modelMap) {
		T old = this.baseService.get(id);
		modelMap.put(StringUtil.lowerFirstChar(className), old);
		return StringUtil.lowerFirstChar( className)+"/input";
	}
	/**
	 * 查看对象
	 * 
	 * @return 返回到模块下view.jsp
	 * @throws Exception
	 */
	public String view(HttpServletRequest request,HttpServletResponse response, PK id, ModelMap modelMap) {
		if(null != id){
			T old = this.baseService.get(id);
			modelMap.put(StringUtil.lowerFirstChar(className), old);
		}
		return StringUtil.lowerFirstChar( className)+"/view";
	}
	/**
	 * 进入模块管理
	 * 
	 * @param request
	 * @param modelMap
	 * @return 返回到模块下main.jsp
	 * @throws Exception
	 */
	public String main(HttpServletRequest request,HttpServletResponse response, T t,
			Integer pageNo, Integer pageSize, ModelMap modelMap) {
		return StringUtil.lowerFirstChar( className)+"/main";
	}
	/**
	 * 列出所有的对象
	 * 
	 * @param request
	 * @param modelMap
	 * @return 返回到模块下list.jsp
	 * @throws Exception
	 */
	public String list(HttpServletRequest request,HttpServletResponse response, T t,SortBean sort,
			Integer pageNo, Integer pageSize, ModelMap modelMap) {
		// 查找当前页
		if (null == pageSize) {
			pageSize = this.pageSize;
		}
		if (null == pageNo) {
			pageNo = 1;
		}
		pageNo = Math.max(1, pageNo);
		SqlFilter filter = new SqlFilter();
		SqlSort sqlSort = new SqlSort();
		StringBuffer sBuf = new StringBuffer();
		if(null == sort || StringUtils.isBlank(sort.getSortProperty())){
			sqlSort.addSort(this.getIdName(), "desc");
		}else{
			sqlSort.addSort(sort.getSortProperty(), sort.getSortOrder());
			sBuf.append("&sortProperty="+sort.getSortProperty());
			sBuf.append("&sortOrder="+sort.getSortOrder());
		}
		List<T> ts = baseService.list(filter, sqlSort, pageNo, pageSize);
		int size = baseService.count(filter);
		modelMap.put(StringUtil.lowerFirstChar(className), t);
		modelMap.put(StringUtil.lowerFirstChar(className) + "s", ts);
		if(null != sort && StringUtils.isNotBlank(sort.getSortProperty())){
			modelMap.put("sort", sort);
		}
		CommonList commonList = new CommonList(size, pageNo, pageSize);
		modelMap.put("commonList", commonList);
		return StringUtil.lowerFirstChar( className)+"/list";
	}
	/**
	 * 保存对象
	 * 
	 * @return {模块名：保存的对象}
	 */
	public void save(HttpServletRequest request,HttpServletResponse response, T domain,
			ModelMap modelMap){
		JSONObject json = null;
		json = preSave(request, domain, modelMap);
		if (null != json
				&& RenderUtils.isSuccess(json)) {
			modelMap.put(StringUtil.lowerFirstChar(className), domain);
			PK id = getId(domain);
			if (null != id) {
				logger.info("edit " + className + ":" + id);
				T old = baseService.get(id);
				BeanHelper.copyNotNullProperties(domain, old);
				domain = old;
			}
			domain = baseService.save(domain);
			logger.info("save " + className + ":" + domain);
			json.put(StringUtil.lowerFirstChar(className), RenderUtils.getJsonExcludePro(domain, getExclude()));
		}
		String contentType = request.getContentType();
		if(contentType!=null && contentType.indexOf("multipart/form-data") != -1){
			RenderUtils.renderJsonInTextarea(response, json);
		}else{
			RenderUtils.renderJson(response, json);
		}
	}

	/**
	 * 删除对象
	 * 
	 * @return
	 */
	public void remove(HttpServletRequest request,HttpServletResponse response, PK id, ModelMap modelMap) {
		JSONObject json = null;
		logger.info("remove " + className + ":" + id);
		this.baseService.removeById(id);
		json = RenderUtils.getStatusOk();
		json.put(this.getIdName(), id);
		RenderUtils.renderJson(response, json);
	}

	/**
	 * 批量删除对象
	 * 
	 * @return
	 */
	public void removeMore(HttpServletRequest request,HttpServletResponse response, PK[] ids, ModelMap modelMap) {
		JSONObject json = null;
		if (ids != null) {
			int c = 0;
			List<PK> failIds = new ArrayList<PK>();
				for (PK i : ids) {
					logger.info("remove " + className + ":" + i);
					try {
						this.baseService.removeById(i);
					} catch (Exception e) {
						failIds.add(ids[c]);
					}
					c++;
				}
				json = RenderUtils.getStatusOk();
			if(failIds.size() > 0){
				json = RenderUtils.getStatusSystem();
				json.put(RenderUtils.KEY_ERROR, "部分记录操作失败:"+StringUtils.join(failIds,","));
			}
			json.put(RenderUtils.KEY_RESULT, ids);
		}else{
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR, "请选择一条记录");
		}
		RenderUtils.renderJson(response, json);
		return ;
	}
	/**
	 * 对象转换成json串，需要排除的属性，如：一对多、多对多、多对一的属性
	 * @return
	 */
	protected String[] getExclude(){
		return new String[]{""};
	}
	/**
	 * 保存对象前的处理，如：保存对象是创建时间列的设置，各字段合法性检验
	 * 
	 * @param request
	 * @param domain
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	protected JSONObject preSave(HttpServletRequest request, T domain,
			ModelMap modelMap) {
		return RenderUtils.getStatusOk();
	}
}
