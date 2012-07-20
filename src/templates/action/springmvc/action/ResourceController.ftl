package ${project.org}.web.controller;

import javax.servlet.http.HttpServletRequest;

import ${project.org}.common.dao.SqlFilter;
import ${project.org}.common.dao.SqlSort
import ${project.org}.domain.Resource;
import ${project.org}.service.ResourceService;
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
 * 资源action
 */
@Controller
@RequestMapping("/security/resource")
public class ResourceAction extends PageAction {

	private static final long serialVersionUID = 1L;

	@Autowired
	private SecurityCacheService securityCacheService;
	@Autowired
	private ResourceService resourceService;

	/**
	 * 修改
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/input")
	public String input(HttpServletRequest request, Resource resource, ModelMap modelMap)
			throws Exception {
		if (null != resource && resource.getId() != null) {
			modelMap.put("id", resource.getId());
			Resource old = this.resourceService.get(resource.getId());
			BeanHelper.copyNotNullProperties(resource, old);
			modelMap.put("resource", old);
		}
		return "admin/resource/input";
	}

	/**
	 * 添加
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public String save(HttpServletRequest request, Resource resource, ModelMap modelMap) {
		try {
			modelMap.put("resource", resource);
			if (null != resource.getId()) {
				Resource old = this.resourceService.get(resource.getId());
				BeanHelper.copyNotNullProperties(resource, old);
				resource = old;
			} 
			this.resourceService.save(resource);
			this.securityCacheService.modifyResourceInCache(resource, resource.getName());
		} catch (Exception e) {
			e.printStackTrace();
			UserContext.saveMessage(request, "菜单保存出错");
			return "admin/resource/input";
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
			this.resourceService.removeById(id);
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
					this.resourceService.removeById(i);
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
			Resource resource, Integer pageSize, ModelMap modelMap) throws Exception {
		// 查找当前页
		String rpname = new org.displaytag.util.ParamEncoder("resource")
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
		if (null != resource.getName() && StringUtils.isNotEmpty(resource.getName())) {
			filter.addFilter("name", resource.getName(), SqlFilter.OP.like);
		}
		SqlSort sort = new SqlSort();
		sort.addSort("id", "desc");
		modelMap.put("resource", resource);
		modelMap.put("resources",
				this.resourceService.list(filter, sort, pageNo, pageSize));
		modelMap.put("size", this.resourceService.count(filter));
		modelMap.put("pageSize", pageSize);
		modelMap.put("forwardpagename", forwardpagename);
		return "admin/resource/list";
	}
}