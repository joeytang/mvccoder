<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE struts PUBLIC
        "-//Apache Software Foundation//DTD Struts Configuration 2.0//EN"
        "http://struts.apache.org/dtds/struts-2.0.dtd">

<struts>
	<package name="security" namespace="/security" extends="comm">
        <default-interceptor-ref name="paramsPrepareParamsStack"/>
     </package>
     
    <package name="securityUser" namespace="/security/user" extends="security">
        <!--user actions-->
        <action name="list" class="userAction" method="list">
            <result name="success">/WEB-INF/back/admin/user/list.jsp</result>
        </action>

        <action name="remove" class="userAction" method="remove">
            <result name="input">/WEB-INF/back/admin/user/input.jsp</result>
            <result name="success" type="redirectAction">list</result>
        </action>

        <action name="input" class="userAction" method="input">
            <result name="success">/WEB-INF/back/admin/user/input.jsp</result>
            <result name="input">/WEB-INF/back/admin/user/input.jsp</result>
        </action>

        <action name="save" class="userAction" method="save">
            <result name="input">/WEB-INF/back/admin/user/input.jsp</result>
            <result name="success" type="redirectAction">list</result>
        </action>

        <action name="selectRoles" class="userAction" method="selectRoles">
            <result name="success">/WEB-INF/back/admin/user/selectRoles.jsp</result>
        </action>

        <action name="authRoles" class="userAction" method="authRoles">
            <result name="success">/WEB-INF/back/admin/user/selectRoles.jsp</result>
        </action>
        <action name="changePwd" class="userAction" method="changePwd">
        </action>
    </package>
    <package name="securityRole" namespace="/security/role" extends="security">
        <!--role actions-->
        <action name="list" class="roleAction" method="list">
            <result name="success">/WEB-INF/back/admin/role/list.jsp</result>
        </action>

        <action name="input" class="roleAction" method="input">
            <result name="success">/WEB-INF/back/admin/role/input.jsp</result>
            <result name="input">/WEB-INF/back/admin/role/input.jsp</result>
        </action>

        <action name="save" class="roleAction" method="save">
            <result name="input">/WEB-INF/back/admin/role/input.jsp</result>
            <result name="success" type="redirectAction">list</result>
        </action>

        <action name="remove" class="roleAction" method="remove">
            <result name="input" type="redirectAction">list</result>
            <result name="success" type="redirectAction">list</result>
        </action>

        <action name="selectMenus" class="roleAction" method="selectMenus">
            <result name="success">/WEB-INF/back/admin/role/selectMenus.jsp</result>
        </action>

        <action name="authMenus" class="roleAction" method="authMenus">
            <result name="success">/WEB-INF/back/admin/role/selectMenus.jsp</result>
        </action>

        <action name="selectResources" class="roleAction" method="selectResources">
            <result name="success">/WEB-INF/back/admin/role/selectResources.jsp</result>
        </action>

        <action name="authResources" class="roleAction" method="authResources">
            <result name="success">/WEB-INF/back/admin/role/selectResources.jsp</result>
        </action>
    </package>
    <package name="securityResource" namespace="/security/resource" extends="security">
        <!--resource actions-->
        <action name="list" class="resourceAction" method="list">
            <result name="success">/WEB-INF/back/admin/resource/list.jsp</result>
        </action>

        <action name="input" class="resourceAction" method="input">
            <result name="success">/WEB-INF/back/admin/resource/input.jsp</result>
            <result name="input">/WEB-INF/back/admin/resource/input.jsp</result>
        </action>

        <action name="save" class="resourceAction" method="save">
            <result name="input">/WEB-INF/back/admin/resource/input.jsp</result>
            <result name="success" type="redirectAction">list</result>
        </action>

        <action name="remove" class="resourceAction" method="remove">
            <result name="input">/WEB-INF/back/admin/resource/input.jsp</result>
            <result name="success" type="redirectAction">list</result>
        </action>
    </package>
    <package name="securityMenu" namespace="/security/menu" extends="security">
        <!--menu actions-->
        <action name="list" class="menuAction" method="list">
            <result name="success">/WEB-INF/back/admin/menu/list.jsp</result>
        </action>

        <action name="input" class="menuAction" method="input">
            <result name="success">/WEB-INF/back/admin/menu/input.jsp</result>
            <result name="input">/WEB-INF/back/admin/menu/input.jsp</result>
        </action>

        <action name="remove" class="menuAction" method="remove">
            <result name="input">/WEB-INF/back/admin/menu/input.jsp</result>
            <result name="success" type="redirectAction">
				<param name="actionName">list</param>
				<#noparse><param name="parentMenuItem.id">${parentMenuItem.id}</param></#noparse>
			</result>
        </action>
        
        <action name="removeMore" class="menuAction" method="removeMore">
            <result name="input">/WEB-INF/back/admin/menu/input.jsp</result>
            <result name="success" type="redirectAction">
				<param name="actionName">list</param>
				<#noparse><param name="parentMenuItem.id">${parentMenuItem.id}</param></#noparse>
			</result>
        </action>

        <action name="save" class="menuAction" method="save">
            <result name="input">/WEB-INF/back/admin/menu/input.jsp</result>
            <result name="success" type="redirectAction">
				<param name="actionName">list</param>
				<#noparse><param name="parentMenuItem.id">${parentMenuItem.id}</param></#noparse>
			</result>
        </action>
        
        <action name="userMenu" class="menuAction" method="loadUserMenu">
            <result name="success">/WEB-INF/back/admin/menu/menu.jsp</result>
        </action>
        <action name="userTree" class="menuAction" method="loadUserMenu">
            <result name="success">/admin/tree.jsp</result>
        </action>
        <action name="menu" class="menuAction" method="loadMenu">
            <result name="success">/WEB-INF/back/admin/menu/menu.jsp</result>
        </action>
        <action name="tree" class="menuAction" method="loadMenu">
            <result name="success">/admin/tree.jsp</result>
        </action>
        <action name="loadMenuJson" class="menuAction" method="loadMenuJson">
        </action>
    </package>
</struts>