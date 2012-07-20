package ${project.org}.util;

import ${project.org}.security.domain.BaseDomain;
import org.apache.commons.lang.StringUtils;

import java.util.Collection;
import java.util.HashSet;
/**
 * User:joeytang
 * Date: ${project.currentTime}
 * 用户角色权限帮助类
 */
@SuppressWarnings("unchecked")
public class AuthHelper {
    /**
     * 保存设置
     * @param authSet
     * @param authObj
     * @param isAuth
     */
      @SuppressWarnings("rawtypes")
    public static void saveAuth(Collection authSet, BaseDomain authObj, boolean isAuth) {
        if (isAuth) {
            if (!authSet.contains(authObj)) {
                authSet.add(authObj);
            }
        } else {
            if (authSet.contains(authObj)) {
                authSet.remove(authObj);
            }
        }
    }

    /**
     * 用户登录设置
     * @param list
     * @param filterlist
     * @param authorize
     * @throws Exception
     */
      @SuppressWarnings("rawtypes")
     public static void judgeAuth(Collection list, Collection filterlist, String authorize) throws Exception {

        Collection removeResources = new HashSet<BaseDomain>();

        authorize = StringUtils.defaultString(authorize);

         for (Object aList : list) {
             BaseDomain securityBaseDomain = (BaseDomain) aList;
             if (filterlist.contains(securityBaseDomain)) {
                 securityBaseDomain.setAuthorize("1"); //已授权
                 if ("0".equals(authorize)) {
                     removeResources.add(securityBaseDomain);
                 }
             } else {
                 securityBaseDomain.setAuthorize("0"); // 未授权
                 if ("1".equals(authorize)) {
                     removeResources.add(securityBaseDomain);
                 }
             }
         }

        list.removeAll(removeResources);
    }
}
