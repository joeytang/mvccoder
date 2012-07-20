package ${project.org}.util;

import java.util.List;

import javax.servlet.ServletContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import ${project.org}.security.domain.Menu;
import ${project.org}.security.domain.MenuTreeRoot;
import ${project.org}.security.service.MenuService;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
/**
 *
 * User: joeytang
 * Date: ${project.currentTime}
 * strutsmenu工具类
 */
public class StrutsMenuHelper {

    protected static final String REPOSITORY = "repository";

    private static final Log logger = LogFactory.getLog(StrutsMenuHelper.class);
    public static synchronized void initMenuRespository(ServletContext servletContext) {
    	WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(servletContext);
    	MenuService menuService = (MenuService) wac.getBean("menuService");
    	MenuTreeRoot menuTreeRoot = new MenuTreeRoot();
    	List<Menu> menus;
    	try {
    		menus = menuService.list(null,null,-1,-1);
    		if (null == menus || menus.isEmpty()) {
    			return;
    		}
    		for (int i = 0, size = menus.size(); i < size; i++) {
    			Menu menu = menus.get(i);
    			menuTreeRoot.addOrUpdateMenu(menu); //将所有的菜单按照树形结构保存
    			String location = (null != menu.getLocation() && 0 != menu.getLocation().trim().length()) ? menu.getLocation().trim() : null;
    			logger.info("localtion:"+servletContext.getContextPath()+location);
    		}
    		servletContext.setAttribute(MenuTreeRoot.MENU_TREE_ROOT_KEY,menuTreeRoot);//将所有的菜单按照树形结构保存
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    }
    
    public static synchronized void addMenu(ServletContext servletContext,Menu m) {
    	MenuTreeRoot menuTreeRoot = (MenuTreeRoot) servletContext.getAttribute(MenuTreeRoot.MENU_TREE_ROOT_KEY);
    	if(null == menuTreeRoot){
    		menuTreeRoot = new MenuTreeRoot();
    	}
    	menuTreeRoot.addOrUpdateMenu(m);
    	servletContext.setAttribute(MenuTreeRoot.MENU_TREE_ROOT_KEY,menuTreeRoot);//将更新后的菜单保存
    }
    
    public static synchronized void deleteMenu(ServletContext servletContext,Long id) {
        MenuTreeRoot menuTreeRoot = (MenuTreeRoot) servletContext.getAttribute(MenuTreeRoot.MENU_TREE_ROOT_KEY);
        if(null == menuTreeRoot){
        	menuTreeRoot = new MenuTreeRoot();
        }
        try {
			menuTreeRoot.deleteMenu(id);
			servletContext.setAttribute(MenuTreeRoot.MENU_TREE_ROOT_KEY,menuTreeRoot);//将更新后的菜单保存
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    
    public static MenuTreeRoot getMenuTreeRoot(ServletContext servletContext){
    	return (MenuTreeRoot) servletContext.getAttribute(MenuTreeRoot.MENU_TREE_ROOT_KEY);
    }
}
