<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${project.org}.security.domain.Role">
    <!-- 二级缓存 -->
    <cache eviction="LRU"
           flushInterval="60000"
           size="1024"
           readOnly="true"/>
           
    <resultMap id="RoleResultMap" type="Role">
	 	<id property="id" column="id" />
	 	<result property="name" column="name" />
	 	<result property="descn" column="descn" />
	 	<result property="title" column="title" />
	 </resultMap>
	 
    <select id="Role.selectOneById" flushCache="false" useCache="true" parameterType="Long"  resultMap="RoleResultMap">
        select * 
        from security_roles
        where id=<#noparse>#</#noparse>{id}
    </select>
    <select id="Role.selectOneByEntity" flushCache="false" useCache="true" parameterType="Role"  resultMap="RoleResultMap">
        select * 
        from security_roles
        where id=<#noparse>#</#noparse>{id}
    </select>
    <select id="Role.listAll" flushCache="false" useCache="true" resultMap="RoleResultMap">
        select * 
        from security_roles
    </select>
    <select id="Role.countAllIds" flushCache="false" useCache="true" resultType="integer">
        select count(distinct id) 
        from security_roles
    </select>
    <select id="Role.listByEntity" flushCache="false" useCache="true" parameterType="Role"  resultMap="RoleResultMap">
        select * 
        from security_roles
    </select>
    <select id="Role.countIdsByEntity" flushCache="false" useCache="true" parameterType="Role"  resultType="integer">
        select count(distinct id) 
        from security_roles
    </select>
    <insert id="Role.insert" flushCache="true" parameterType="Role">
    	insert into security_roles
    	(name,descn,title) 
        values(<#noparse>#</#noparse>{name},<#noparse>#</#noparse>{descn},<#noparse>#</#noparse>{title})
    </insert>
    <update id="Role.update" parameterType="Role" flushCache="true">
        update security_roles 
        <set>
			<if test="name != null">name=<#noparse>#</#noparse>{name},</if>
			<if test="descn != null">descn=<#noparse>#</#noparse>{descn},</if>
			<if test="title != null">title=<#noparse>#</#noparse>{title}</if>
		</set>
        where id = <#noparse>#</#noparse>{id}
    </update>
    <delete id="Role.deleteByEntity" flushCache="true" parameterType="Role" >
        delete 
        from security_roles 
        where id = <#noparse>#</#noparse>{id}
    </delete>
    <delete id="Role.deleteById" flushCache="true" parameterType="Long" >
        delete 
        from security_roles 
        where id = <#noparse>#</#noparse>{id}
    </delete>
</mapper>