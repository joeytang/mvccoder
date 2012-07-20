package ${project.org}.cache;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.DataRetrievalFailureException;
import net.sf.ehcache.Cache;
import net.sf.ehcache.Element;
import net.sf.ehcache.CacheException;
import ${project.org}.domain.Menu;

/**
 * User: joeytang
 * Date: 2011-11-21 10:42
 * To change this template use File | Settings | File Templates.
 */
public class MenuCache {
    /**
     * 日志变量初始化
     */
    private static final Log logger = LogFactory.getLog(MenuCache.class);

    /**
     * 定义cache
     */
    private Cache cache;

    public void setCache(Cache cache) {
        this.cache = cache;
    }

    public Cache getCache() {
        return this.cache;
    }

    /**
     * 添加菜单
     *
     * @param menu
     */
    public void putMenuInCache(Menu menu) {
        Element element = new Element(menu.getName(), menu);

        if (logger.isDebugEnabled()) {
            logger.debug("Cache put: " + element.getKey());
        }

        this.cache.put(element);
    }

    /**
     * 删除菜单
     *
     * @param menuName
     */
    public void removeMenuInCache(String menuName) {
        if (logger.isDebugEnabled()) {
            logger.debug("Cache remove: " + menuName);
        }

        this.cache.remove(menuName);
    }

    /**
     * 得到菜单
     *
     * @param menuName
     * @return
     */
    public Menu getMenuFromCache(String menuName) {
        Element element = null;

        try {
            element = cache.get(menuName);
        } catch (CacheException cacheException) {
            throw new DataRetrievalFailureException("Cache failure: " + cacheException.getMessage(), cacheException);
        }

        if (logger.isDebugEnabled()) {
            logger.debug("Cache hit: " + (element != null) + "; menu name: " + menuName);
        }

        if (element == null) {
            return null;
        } else {
            return (Menu) element.getValue();
        }
    }
}
