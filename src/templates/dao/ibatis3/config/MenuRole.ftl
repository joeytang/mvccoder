<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${project.org}.security.domain.MenuRole">
    <!-- 二级缓存 -->
    <cache eviction="LRU"
           flushInterval="60000"
           size="1024"
           readOnly="true"/>
           
    <resultMap id="MenuRoleResultMap" type="MenuRole">
	 	<id property="menuId" column="menu_id" />
	 	<id property="roleId" column="role_id" />
	</resultMap>
	<select id="MenuRole.listMenuByRoleId" flushCache="false" useCache="true" parameterType="Long"  resultMap="MenuResultMap">
        select m.* 
        from security_menu_roles mr
        left join security_menus m on m.id = mr.menu_id 
        where mr.role_id=<#noparse>#</#noparse>{id} 
    </select>
	<select id="MenuRole.listRoleByMenuId" flushCache="false" useCache="true" parameterType="Long"  resultMap="RoleResultMap">
        select r.* 
        from security_menu_roles mr
        left join security_roles r on r.id = mr.role_id 
        where mr.menu_id=<#noparse>#</#noparse>{id} 
    </select>
    <insert id="MenuRole.insert" flushCache="true" parameterType="MenuRole">
    	insert into security_menu_roles
    	(menu_id,role_id) 
        values(<#noparse>#</#noparse>{menuId},<#noparse>#</#noparse>{roleId})
    </insert>
    <delete id="MenuRole.deleteByEntity" flushCache="true" parameterType="MenuRole" >
        delete 
        from security_menu_roles 
        where 
        <choose>
			<when test="menuId != null and roleId != null">
			menu_id = <#noparse>#</#noparse>{menuId} AND role_id = <#noparse>#</#noparse>{roleId}
			</when>
			<when test="menuId != null">
			menu_id = <#noparse>#</#noparse>{menuId}
			</when>
			<otherwise>
			role_id = <#noparse>#</#noparse>{roleId}
			</otherwise>
		</choose>
    </delete>
</mapper>