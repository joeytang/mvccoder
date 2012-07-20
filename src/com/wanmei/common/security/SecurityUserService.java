package com.wanmei.common.security;

import java.util.List;

import com.wanmei.dao.UserDao;
import com.wanmei.common.dao.SqlFilter;
import com.wanmei.common.dao.SqlSort;
import com.wanmei.domain.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * 用户权限管理类
 */
@Service("securityUserService")
public class SecurityUserService implements UserDetailsService {
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
    public UserDetails loadUserByUsername(final String username) throws UsernameNotFoundException, DataAccessException {
    	SqlFilter filter = new SqlFilter();
    	filter.addFilter("username", username);
    	SqlSort sort = new SqlSort();
    	sort.addSort("id", "desc");
        List<User> users = null;
		try {
			users = this.userDao.listByFilter(filter, sort);
			if(null != users && users.size() > 0){
				return users.get(0);
			}
			throw new UsernameNotFoundException( "Username "+username+" not found");
		} catch (Exception e) {
			throw new UsernameNotFoundException("Username "+username+" not found");
		}
    }
}

