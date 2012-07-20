<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${project.org}.security.domain.Resource">
    <!-- 二级缓存 -->
    <cache eviction="LRU"
           flushInterval="60000"
           size="1024"
           readOnly="true"/>
           
    <resultMap id="ResourceResultMap" type="Resource">
	 	<id property="id" column="id" />
	 	<result property="name" column="name" />
	 	<result property="type" column="type" />
	 	<result property="resString" column="resstring" />
	 	<result property="descn" column="descn" />
	 	<collection property="roles" ofType="Role" select="RoleResource.listRoleByResourceId" column="resource_id"/>
	 </resultMap>

    <select id="Resource.selectOneById" flushCache="false" useCache="true" parameterType="Long"  resultMap="ResourceResultMap">
        select re.*,r.* 
        from security_resources re 
        left join security_role_resources rr on rr.resource_id = re.id
        left join security_roles r on r.id = rr.role_id 
        where re.id=<#noparse>#</#noparse>{id} 
    </select>
    <select id="Resource.selectOneByEntity" flushCache="false" useCache="true" parameterType="Resource"  resultMap="ResourceResultMap">
        select re.*,r.* 
        from security_resources re 
        left join security_role_resources rr on rr.resource_id = re.id
        left join security_roles r on r.id = rr.role_id 
        where re.id=<#noparse>#</#noparse>{id}  
    </select>
    <select id="Resource.listAll" flushCache="false" useCache="true" resultMap="ResourceResultMap">
        select * 
        from security_resources re 
    </select>
    <select id="Resource.countAllIds" flushCache="false" useCache="true" resultType="integer">
        select count(distinct id) 
        from security_users
    </select>
    <select id="Resource.listByEntity" flushCache="false" useCache="true" parameterType="Resource"  resultMap="ResourceResultMap">
        select re.*,r.* 
        from security_resources re 
        left join security_role_resources rr on rr.resource_id = re.id
        left join security_roles r on r.id = rr.role_id 
    </select>
    <select id="Resource.countIdsByEntity" flushCache="false" useCache="true" parameterType="Resource"  resultType="integer">
        select count(distinct id) 
        from security_users
    </select>
    <insert id="Resource.insert" flushCache="true" parameterType="Resource">
    	insert into security_users
    	(name,type,resstring,descn) 
        values(<#noparse>#</#noparse>{name},<#noparse>#</#noparse>{type},<#noparse>#</#noparse>{resString},<#noparse>#</#noparse>{descn})
    </insert>
    <update id="Resource.update" parameterType="Resource" flushCache="true">
        update security_users 
        <set>
			<if test="name != null">name=<#noparse>#</#noparse>{name},</if>
			<if test="type != null">type=<#noparse>#</#noparse>{type},</if>
			<if test="resString != null">resstring=<#noparse>#</#noparse>{resString},</if>
			<if test="descn != null">descn=<#noparse>#</#noparse>{descn},</if>
		</set>
        where id = <#noparse>#</#noparse>{id}
    </update>
    <delete id="Resource.deleteByEntity" flushCache="true" parameterType="Resource" >
        delete 
        from security_users 
        where id = <#noparse>#</#noparse>{id}
    </delete>
    <delete id="Resource.deleteById" flushCache="true" parameterType="Long" >
        delete 
        from security_users 
        where id = <#noparse>#</#noparse>{id}
    </delete>
</mapper>