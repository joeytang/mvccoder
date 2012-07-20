<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${project.org}.security.domain.User">
    <!-- 二级缓存 -->
    <cache eviction="LRU"
           flushInterval="60000"
           size="1024"
           readOnly="true"/>
           
    <resultMap id="UserResultMap" type="User">
	 	<id property="id" column="id" />
	 	<result property="loginid" column="loginid" />
	 	<result property="passwd" column="passwd" />
	 	<result property="name" column="name" />
	 	<result property="descn" column="descn" />
	 	<result property="createDate" column="create_date" />
	 	<result property="disabled" column="disabled" />
	 	<collection property="roles" ofType="Role" resultMap="RoleResultMap" select="UserRole.listRoleByUserId" />
	 </resultMap>
	 
	<select id="User.countDynamic" flushCache="false" useCache="true" parameterType="IbatisSqlFilter"  resultType="integer">
        select count(*) 
        from security_users
        <where>
        	<if test="null != bean">
				<if test="bean.loginid != null"> and loginid=<#noparse>#</#noparse>{bean.loginid} </if>
				<if test="bean.passwd != null"> and passwd=<#noparse>#</#noparse>{bean.passwd} </if>
	        	<if test="bean.name != null"> name=<#noparse>#</#noparse>{bean.name} </if>
				<if test="bean.descn != null"> and descn=<#noparse>#</#noparse>{bean.descn} </if>
				<if test="bean.createDate != null"> and create_date=<#noparse>#</#noparse>{bean.createDate} </if>
				<if test="bean.disabled != null"> and disabled=<#noparse>#</#noparse>{bean.disabled} </if>
        	</if>
        </where>
    </select>
	<select id="User.listDynamic" flushCache="false" useCache="true" parameterType="IbatisSqlFilter"  resultMap="UserResultMap">
        select u.*, r.* 
        from security_users u 
        left join security_user_roles ur on u.id = ur.user_id
        left join security_roles r on r.id = ur.role_id 
        <where>
        	<if test="null != bean">
				<if test="bean.loginid != null"> and u.loginid=<#noparse>#</#noparse>{bean.loginid} </if>
				<if test="bean.passwd != null"> and u.passwd=<#noparse>#</#noparse>{bean.passwd} </if>
	        	<if test="bean.name != null"> u.name=<#noparse>#</#noparse>{bean.name} </if>
				<if test="bean.descn != null"> and u.descn=<#noparse>#</#noparse>{bean.descn} </if>
				<if test="bean.createDate != null"> and u.create_date=<#noparse>#</#noparse>{bean.createDate} </if>
				<if test="bean.disabled != null"> and u.disabled=<#noparse>#</#noparse>{bean.disabled} </if>
        	</if>
        </where>
        <if test="null != sort and null != sort.sorts">
        order by 
        <foreach item="item" index="index" collection="sort.sorts" separator="," >
       		<choose>
       			<when test="item.column != null">
       			u.<#noparse>$</#noparse>{item.column} <#noparse>$</#noparse>{item.order} 
       			</when>
       			<when test="'id' == item.property">
       			u.id <#noparse>$</#noparse>{item.order}
       			</when>
       			<when test="'loginid' == item.property">
       			u.loginid <#noparse>$</#noparse>{item.order}
       			</when>
       			<when test="'passwd' == item.property">
       			u.passwd <#noparse>$</#noparse>{item.order}
       			</when>
       			<when test="'name' == item.property">
       			u.name <#noparse>$</#noparse>{item.order}
       			</when>
       			<when test="'descn' == item.property">
       			u.descn <#noparse>$</#noparse>{item.order}
       			</when>
       			<when test="'createDate' == item.property">
       			u.create_date <#noparse>$</#noparse>{item.order}
       			</when>
       			<when test="'disabled' == item.property">
       			u.disabled <#noparse>$</#noparse>{item.order}
       			</when>
       		</choose>
		</foreach>
        </if>
    </select>
    <select id="User.selectOneById" flushCache="false" useCache="true" parameterType="Long"  resultMap="UserResultMap">
       select u.*, r.* 
        from security_users u 
        left join security_user_roles ur on u.id = ur.user_id
        left join security_roles r on r.id = ur.role_id 
        where u.id=<#noparse>#</#noparse>{id}
    </select>
    <select id="User.selectOneByEntity" flushCache="false" useCache="true" parameterType="User"  resultMap="UserResultMap">
        select u.*, r.* 
        from security_users u 
        left join security_user_roles ur on u.id = ur.user_id
        left join security_roles r on r.id = ur.role_id 
        where u.id=<#noparse>#</#noparse>{id}
    </select>
    <select id="User.listAll" flushCache="false" useCache="true" resultMap="UserResultMap">
        select u.*, r.* 
        from security_users u 
        left join security_user_roles ur on u.id = ur.user_id
        left join security_roles r on r.id = ur.role_id 
    </select>
    <select id="User.countAllIds" flushCache="false" useCache="true" resultType="integer">
        select count(distinct id) 
        from security_users
    </select>
    <select id="User.listByEntity" flushCache="false" useCache="true" parameterType="User"  resultMap="UserResultMap">
        select u.*, r.* 
        from security_users u 
        left join security_user_roles ur on u.id = ur.user_id
        left join security_roles r on r.id = ur.role_id 
    </select>
    <select id="User.countIdsByEntity" flushCache="false" useCache="true" parameterType="User"  resultType="integer">
        select count(distinct id) 
        from security_users
    </select>
    <insert id="User.insert" flushCache="true" parameterType="User">
    	insert into security_users
    	(loginid,passwd,name,descn,create_date,disabled) 
        values(<#noparse>#</#noparse>{loginid},<#noparse>#</#noparse>{passwd},<#noparse>#</#noparse>{name},<#noparse>#</#noparse>{descn},<#noparse>#</#noparse>{createDate},<#noparse>#</#noparse>{disabled})
    </insert>
    <update id="User.update" parameterType="User" flushCache="true">
        update security_users 
        <set>
			<if test="loginid != null">loginid=<#noparse>#</#noparse>{loginid},</if>
			<if test="passwd != null">passwd=<#noparse>#</#noparse>{passwd},</if>
			<if test="name != null">name=<#noparse>#</#noparse>{name},</if>
			<if test="descn != null">descn=<#noparse>#</#noparse>{descn},</if>
			<if test="createDate != null">create_date=<#noparse>#</#noparse>{createDate},</if>
			<if test="disabled != null">disabled=<#noparse>#</#noparse>{disabled}</if>
		</set>
        where id = <#noparse>#</#noparse>{id}
    </update>
    <delete id="User.deleteByEntity" flushCache="true" parameterType="User" >
        delete 
        from security_users 
        where id = <#noparse>#</#noparse>{id}
    </delete>
    <delete id="User.deleteById" flushCache="true" parameterType="Long" >
        delete 
        from security_users 
        where id = <#noparse>#</#noparse>{id}
    </delete>
</mapper>