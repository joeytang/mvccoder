<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${project.org}.security.domain.UserRole">
    <!-- 二级缓存 -->
    <cache eviction="LRU"
           flushInterval="60000"
           size="1024"
           readOnly="true"/>
           
    <resultMap id="UserRoleResultMap" type="UserRole">
	 	<id property="userId" column="user_id" />
	 	<id property="roleId" column="role_id" />
	</resultMap>

	<select id="UserRole.listUserByRoleId" flushCache="false" useCache="true" parameterType="Long"  resultMap="UserResultMap">
        select u.* 
        from security_user_roles ur
        left join security_users u on u.id = ur.user_id 
        where ur.role_id=<#noparse>#</#noparse>{id} 
    </select>
	<select id="UserRole.listRoleByUserId" flushCache="false" useCache="true" parameterType="Long"  resultMap="RoleResultMap">
        select r.* 
        from security_user_roles ur
        left join security_roles r on r.id = ur.role_id 
        where ur.user_id=<#noparse>#</#noparse>{id} 
    </select>
    
    <insert id="UserRole.insert" flushCache="true" parameterType="UserRole">
    	insert into security_user_roles
    	(user_id,role_id) 
        values(<#noparse>#</#noparse>{userId},<#noparse>#</#noparse>{roleId})
    </insert>
    <delete id="UserRole.deleteByEntity" flushCache="true" parameterType="UserRole" >
        delete 
        from security_user_roles 
        where 
        <choose>
			<when test="userId != null and roleId != null">
			user_id = <#noparse>#</#noparse>{userId} AND role_id = <#noparse>#</#noparse>{roleId}
			</when>
			<when test="userId != null">
			user_id = <#noparse>#</#noparse>{userId}
			</when>
			<otherwise>
			role_id = <#noparse>#</#noparse>{roleId}
			</otherwise>
		</choose>
    </delete>
</mapper>