package ${project.org}.common.security;

import ${project.org}.cache.MenuCache;
import ${project.org}.cache.ResourceCache;
import ${project.org}.dao.MenuDao;
import ${project.org}.dao.ResourceDao;
import ${project.org}.dao.UserDao;
import ${project.org}.domain.Menu;
import ${project.org}.domain.Resource;
import ${project.org}.domain.ResourceDetails;
import ${project.org}.domain.Role;
import ${project.org}.domain.User;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserCache;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by IntelliJ IDEA.
 * User:joeytang
 * Date: ${project.currentTime}
 * cache操作
 */
@Service
public class SecurityCacheManager implements InitializingBean {

    private static final Log LOGGER = LogFactory.getLog(SecurityCacheManager.class);
    /**
     * 用户Dao
     */
    @Autowired
    private UserDao userDao;
    /**
     * 资源Dao
     */
    @Autowired
    private ResourceDao resourceDao;
    /**
     * 菜单Dao
     */
    @Autowired
    private MenuDao menuDao;
    /**
     * 资源cache
     */
    @Autowired
    private ResourceCache resourceCache;
    /**
     * 用户cache
     */
    @Autowired
    private UserCache userCache;
    /**
     * 菜单
     */
    @Autowired
    private MenuCache menuCache;

    private boolean cacheInitialized = false;

    /**
     * 初始化设置
     * @throws Exception
     */
    public void afterPropertiesSet() throws Exception {
        this.initResourceCache();
        this.initMenuCache();
        this.initUserCache();
    }

    /**
     * 修改用户 cache
     * @param user
     * @param orgUsername
     */
    public void modifyUserInCache(User user, String orgUsername) {
        UserDetails ud = userCache.getUserFromCache(orgUsername);
        if (ud != null)
            userCache.removeUserFromCache(orgUsername);
        userDetailsInCache(user);
    }

    /**
     * 修改资源cache
     * @param resourceDetails
     * @param orgResourcename
     */
    public void modifyResourceInCache(ResourceDetails resourceDetails, String orgResourcename) {
        ResourceDetails r = resourceCache.getAuthorityFromCache(orgResourcename);
        if (r != null) {
            resourceCache.removeAuthorityFromCache(orgResourcename);
        }

        resourceDetailsInCache(resourceDetails);

    }

    /**
     * 修改菜单cache
     * @param menu
     * @param menuName
     */
    public void modifyMenuInCache(Menu menu, String menuName) {

        Menu cachedMenu = this.menuCache.getMenuFromCache(menuName);

        if (cachedMenu != null) {
            this.menuCache.removeMenuInCache(menuName);
        }

        this.menuInCache(menu);
    }

    /**
     * 修改角色cache
     * @param role
     */
    public void modifyRoleInCache(Role role) {
        Set<User> users = role.getUsers();
        if(null != users){
        	for (Iterator<User> iter = users.iterator(); iter.hasNext();) {
        		User user = iter.next();
        		userDetailsInCache(user);
        	}
        }
        if(null != role){
        	for (Iterator<Resource> iter = role.getResources().iterator(); iter.hasNext();) {
        		Resource resource = iter.next();
        		resourceDetailsInCache(resource);
        	}
        }
    }

    /**
     * 用户资源授权
     * @param user
     */

    public void authRoleInCache(User user) {
        userDetailsInCache(user);
    }

    /**
     * 资源 cache
     * @param role
     */
    public void authResourceInCache(Role role) {
    	if(null != role){
    		for (Iterator<Resource> iter = role.getResources().iterator(); iter.hasNext();) {
    			Resource resource = iter.next();
    			resourceDetailsInCache(resource);
    		}
    	}
    }

    /**
     * 菜单cache
     * @param role
     */
    public void authMenuInCache(Role role) {
    	if(null != role){
    		for (Iterator<Menu> iter = role.getMenus().iterator(); iter.hasNext();) {
    			Menu menu = iter.next();
    			menuInCache(menu);
    		}
    	}
    }

    /**
     * 初始化用户cache
     * @throws Exception 
     */
    @Transactional(readOnly = true)
    private void initUserCache() throws Exception {
        List<User> users = this.userDao.findAll();
        if(null != users){
        	for (Iterator<User> iter = users.iterator(); iter.hasNext();) {
        		User user = iter.next();
        		authRoleInCache(user);
        	}
        }
    }

    /**
     *初始化菜单cache
     * @throws Exception 
     */
    @Transactional(readOnly = true)
    private void initResourceCache() throws Exception {
        if (!cacheInitialized) {
            synchronized (this) {
                List<Resource> resources = this.resourceDao.findAll();
                if(null != resources){
                	for (Iterator<Resource> iter = resources.iterator(); iter.hasNext();) {
                		Resource resource = iter.next();
                		resourceDetailsInCache(resource);
                	}
                }
                cacheInitialized = true;
            }
        }
    }

    /**
     * 初始化菜单cache
     * @throws Exception 
     */
    @Transactional(readOnly = true)
    private void initMenuCache() throws Exception {
        List<Menu> menus = this.menuDao.findAll();
        if(null != menus){
        	for (Iterator<Menu> iter = menus.iterator(); iter.hasNext();) {
        		Menu menu = iter.next();
        		menuInCache(menu);
        	}
        }
    }

    /**
     * 刷新资源cache
     *  applicationContext-quartz.xml cacheTrigger
     * @throws Exception 
     */
    public void refreshResourceCache() throws Exception {
        cacheInitialized = false;
        try {
            resourceCache.getCache().removeAll();
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
        }
        initResourceCache();
    }

    /**
     * 刷新菜单cache
     * @throws Exception 
     */
    public void refreshMenuCache() throws Exception {
        cacheInitialized = false;
        try {
            this.menuCache.getCache().removeAll();
        } catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
        }
        initMenuCache();
    }

    /**
     * 得到用户资源连接
     * @return
     */
    public List<String> getUrlResStrings() {
        return resourceCache.getUrlResStrings();
    }

    /**
     * 得到用户方法
     * @return
     */
    public List<String> getFunctions() {
        return resourceCache.getFunctions();
    }

    /**
     * 得到其他
     * @return
     */
    public List<String> getComponents() {
        return resourceCache.getComponents();
    }

    /**
     * 用户资源cache
     * @param resString
     * @return
     */
    public ResourceDetails getAuthorityFromCache(String resString) {
        return resourceCache.getAuthorityFromCache(resString);
    }

    /**
     * 用户cache
     * @param user
     */
    private void userDetailsInCache(User user) {
    	Collection<GrantedAuthority> authorities = role2authorities(user.getRoles());
        UserDetails ud = new org.springframework.security.core.userdetails.User(user.getLoginid(), user.getPasswd(), user.isEnabled(), true, true, true, authorities);
        userCache.putUserInCache(ud);
    }

    /**
     * 菜单加载
     * @param menu
     */
    private void menuInCache(Menu menu) {
        menuCache.putMenuInCache(menu);
    }

    /**
     * 资源加载
     * @param resourceDetails
     */
    private void resourceDetailsInCache(ResourceDetails resourceDetails) {
        resourceCache.putAuthorityInCache(resourceDetails);
    }

    /**
     * 容器加载
     * @param roles
     * @return
     */
    @Transactional(readOnly = true)
    private Collection<GrantedAuthority> role2authorities(Collection<Role> roles) {
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        if(null != authorities){
        	for (Iterator<Role> iter = roles.iterator(); iter.hasNext();) {
        		Role role =  iter.next();
        		GrantedAuthority g = new SimpleGrantedAuthority(role.getName());
        		authorities.add(g);
        	}
        }
        return authorities;
    }
}
