package ${project.org}.util;

import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.ui.WebAuthenticationDetails;

import ${project.org}.security.domain.User;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * SpringSecurity工具类
 */
public class SecurityUserHolder {
    /**
     * 获取当前用户
     *
     * @return user
     */
    public static User getCurrentUser() {
        return (SecurityContextHolder.getContext() == null || SecurityContextHolder.getContext().getAuthentication() == null) ? null : (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    }

    /**
     * 获取当前ip
     *
     * @return String
     */
    public static String getUserIP() {
        return (SecurityContextHolder.getContext() == null || SecurityContextHolder.getContext().getAuthentication() == null || SecurityContextHolder.getContext().getAuthentication().getDetails() == null) ? "unknown" : ((WebAuthenticationDetails) SecurityContextHolder.getContext().getAuthentication().getDetails()).getRemoteAddress();
    }
}
