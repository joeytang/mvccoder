package ${project.org}.security.service;

import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import ${project.org}.security.dao.SqlFilter;
import ${project.org}.security.dao.SqlSort;
import ${project.org}.security.dao.UserDao;
import ${project.org}.security.dao.impl.IbatisSqlFilter;
import ${project.org}.security.domain.User;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 用户权限管理类
 */
@Service("securityManagerSupport")
public class SecurityManagerSupport implements UserDetailsService {
	@Autowired
	private UserDao userDao;
    /**+
     * 用户登录返回结果
     * @param userName
     * @return
     * @throws UsernameNotFoundException
     * @throws DataAccessException
     */
    @Override
    public UserDetails loadUserByUsername(final String userName) throws UsernameNotFoundException, DataAccessException {
    	SqlFilter filter = new SqlFilter();
    	filter.addFilter("loginid", userName);
    	SqlSort sort = new SqlSort();
    	sort.addSort("id", "desc");
        List<User> users = null;
		try {
			users = this.userDao.listDynamic(new IbatisSqlFilter(filter, sort), -1, -1);
			return users.get(0);
		} catch (Exception e) {
			e.printStackTrace();
		}
        if (null == users || users.isEmpty()) {
            throw new UsernameNotFoundException("User " + userName + " has no GrantedAuthority");
        }
        return null;
    }

    /**
     * 用户的角色判断处理
     * @param roleName
     * @return
     */
    public static boolean isAllGranted(final String roleName) {
        Authentication currentUser = SecurityContextHolder.getContext().getAuthentication();
        final Collection<? extends GrantedAuthority> granted ;
        if(null == currentUser || null == currentUser.getAuthorities()){
        	granted = Collections.emptyList();
        }else{
        	granted = currentUser.getAuthorities();
        }
        final Set<GrantedAuthority> requiredAuthorities = new HashSet<GrantedAuthority>();
        requiredAuthorities.addAll(AuthorityUtils.commaSeparatedStringToAuthorityList(roleName));

        if (granted.containsAll(requiredAuthorities)) {
            return true;
        }

        return false;
    }
}

