<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${project.org}.security.domain.RoleResource">
    <!-- 二级缓存 -->
    <cache eviction="LRU"
           flushInterval="60000"
           size="1024"
           readOnly="true"/>
           
    <resultMap id="RoleResourceResultMap" type="RoleResource">
	 	<id property="roleId" column="role_id" />
	 	<id property="resourceId" column="resource_id" />
	</resultMap>

	<select id="RoleResource.listResourceByRoleId" flushCache="false" useCache="true" parameterType="Long"  resultMap="ResourceResultMap">
        select r.* 
        from security_role_resources rr
        left join security_resources r on r.id = rr.resource_id 
        where rr.role_id=<#noparse>#</#noparse>{id} 
    </select>
	<select id="RoleResource.listRoleByResourceId" flushCache="false" useCache="true" parameterType="Long"  resultMap="RoleResultMap">
        select r.* 
        from security_role_resources rr
        left join security_roles r on r.id = rr.role_id 
        where rr.resource_id=<#noparse>#</#noparse>{id} 
    </select>
    <insert id="RoleResource.insert" flushCache="true" parameterType="RoleResource">
    	insert into security_role_resources
    	(role_id,resource_id) 
        values(<#noparse>#</#noparse>{roleId},<#noparse>#</#noparse>{resourceId})
    </insert>
    <delete id="RoleResource.deleteByEntity" flushCache="true" parameterType="RoleResource" >
        delete 
        from security_role_resources 
        where 
        <choose>
			<when test="resourceId != null and roleId != null">
			resource_id = <#noparse>#</#noparse>{resourceId} AND role_id = <#noparse>#</#noparse>{roleId}
			</when>
			<when test="resourceId != null">
			resource_id = <#noparse>#</#noparse>{resourceId}
			</when>
			<otherwise>
			role_id = <#noparse>#</#noparse>{roleId}
			</otherwise>
		</choose>
    </delete>
</mapper>