package ${project.org}.cache;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.DataRetrievalFailureException;
import net.sf.ehcache.Cache;
import net.sf.ehcache.Element;
import net.sf.ehcache.CacheException;

import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

import ${project.org}.domain.ResourceDetails;
import ${project.org}.domain.Resource;
import ${project.org}.domain.helper.ResourceHelper;

/**
 * User: joeytang
 * Date: 2011-11-21 10:42
 * 获得系统资源
 */
public class ResourceCache {
    
    private static final Log LOGGER = LogFactory.getLog(ResourceCache.class);
    /**
     * 资源cache
     */
    private Cache cache;

    public void setCache(Cache cache) {
        this.cache = cache;
    }

    public Cache getCache() {
        return this.cache;
    }

    /**
     * 得到授权资源
     * @param resString
     * @return
     */
    public ResourceDetails getAuthorityFromCache(String resString) {
        Element element = null;

        try {
            element = cache.get(resString);
        } catch (CacheException cacheException) {
            throw new DataRetrievalFailureException("Cache failure: " + cacheException.getMessage(), cacheException);
        }

        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug("Cache hit: " + (element != null) + "; resString: " + resString);
        }

        if (element == null) {
            return null;
        } else {
            return (ResourceDetails) element.getValue();
        }
    }

    /**
     * 添加资源
     * @param resourceDetails
     */
    public void putAuthorityInCache(ResourceDetails resourceDetails) {
        Element element = new Element(resourceDetails.getResourceString(), resourceDetails);

        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug("Cache put: " + element.getKey());
        }

        this.cache.put(element);
    }

    /**
     * 删除资源
     * @param resString
     */
    public void removeAuthorityFromCache(String resString) {

        if (LOGGER.isDebugEnabled()) {
            LOGGER.debug("Cache remove: " + resString);
        }

        this.cache.remove(resString);
    }

    /**
     * 得到资源集合
     * @return
     */
    public List<String> getUrlResStrings() {
        return getResourcesByType(ResourceHelper.TYPE_URL);
    }

    /**
     * 得到方法集合
     * @return
     */
    public List<String> getFunctions() {
        return getResourcesByType(ResourceHelper.TYPE_FUNCTION);
    }

    /**
     * 得到
     * @return
     */
    public List<String> getComponents() {
        return getResourcesByType(ResourceHelper.TYPE_COMPONENT);
    }

    /**
     * 得到资源类型
     * @param type
     * @return
     */
    @SuppressWarnings("unchecked")
	private List<String> getResourcesByType(String type) {
        List<String> resources;

        List<String> resclist = new ArrayList<String>();

        try {
            resources = this.cache.getKeys();
        } catch (IllegalStateException e) {
            throw new IllegalStateException(e.getMessage(), e);
        } catch (CacheException e) {
            throw new UnsupportedOperationException(e.getMessage(), e);
        }

        for (Iterator<String> iter = resources.iterator(); iter.hasNext();) {
            String resString = iter.next();
            ResourceDetails resourceDetails = getAuthorityFromCache(resString);
            if (resourceDetails != null && resourceDetails.getResourceType().equals(type)) {
                resclist.add(resString);
            }
        }

        return resclist;
    }
}
