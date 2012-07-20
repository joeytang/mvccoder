<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${domain.domainRealPackage}.${domain.domainName}">
    <!-- 二级缓存 -->
    <cache eviction="LRU"
           flushInterval="60000"
           size="1024"
           readOnly="true"/>
           
    <resultMap id="${domain.domainName}ResultMap" type="${domain.domainName}">
	 	<id property="${domain.clazz.identifierProperty.name}" column="<#list domain.clazz.identifierProperty.columnIterator as c>${c.name}</#list>" />
	 	<#list domain.properties as p>
	 	<result property="${p.name}" column="<#list p.columnIterator as c>${c.name}</#list>" />
	 	</#list>
	 </resultMap>

    <select id="${domain.domainName}.countDynamic" flushCache="false" useCache="true" parameterType="IbatisSqlFilter"  resultType="integer">
        select count(*) 
        from ${domain.clazz.table.name}
        <where>
        	<if test="null != bean">
        		<#list domain.properties as p>
	        	<if test="bean.${p.name} != null"> <#list p.columnIterator as c>${c.name}</#list>=<#noparse>#</#noparse>{bean.${p.name}} </if>
			 	</#list>
        	</if>
        </where>
    </select>
    <select id="${domain.domainName}.listDynamic" flushCache="false" useCache="true" parameterType="IbatisSqlFilter"  resultMap="${domain.domainName}ResultMap">
        select * 
        from ${domain.clazz.table.name}
        <where>
        	<if test="null != bean">
        		<#list domain.properties as p>
	        	<if test="bean.${p.name} != null"> <#list p.columnIterator as c>${c.name}</#list>=<#noparse>#</#noparse>{bean.${p.name}} </if>
			 	</#list>
        	</if>
        </where>
        <if test="null != sort and null != sort.sorts">
        order by 
        <foreach item="item" index="index" collection="sort.sorts" separator="," >
       		<choose>
       			<when test="item.column != null">
       			<#noparse>$</#noparse>{item.column} <#noparse>$</#noparse>{item.order} 
       			</when>
       			<when test="'${domain.clazz.identifierProperty.name}' == item.property">
       			<#list domain.clazz.identifierProperty.columnIterator as c>${c.name}</#list> <#noparse>$</#noparse>{item.order}
       			</when>
       			<#list domain.properties as p>
	        	<if test="bean.${p.name} != null"> <#list p.columnIterator as c>${c.name}</#list>=<#noparse>#</#noparse>{bean.${p.name}} </if>
       			<when test="'${p.name}' == item.property">
       			<#list p.columnIterator as c>${c.name}</#list> <#noparse>$</#noparse>{item.order}
       			</when>
			 	</#list>
       		</choose>
		</foreach>
        </if>
    </select>
    <select id="${domain.domainName}.selectOneById" flushCache="false" useCache="true" parameterType="Long"  resultMap="${domain.domainName}ResultMap">
        select * 
        from ${domain.clazz.table.name}
        where id=<#noparse>#</#noparse>{id}
    </select>
    <select id="${domain.domainName}.selectOneByEntity" flushCache="false" useCache="true" parameterType="${domain.domainName}"  resultMap="${domain.domainName}ResultMap">
        select * 
        from ${domain.clazz.table.name}
        where id=<#noparse>#</#noparse>{id}
    </select>
    <select id="${domain.domainName}.listAll" flushCache="false" useCache="true" resultMap="${domain.domainName}ResultMap">
        select * 
        from ${domain.clazz.table.name}
    </select>
    <select id="${domain.domainName}.countAllIds" flushCache="false" useCache="true" resultType="integer">
        select count(distinct id) 
        from ${domain.clazz.table.name}
    </select>
    <select id="${domain.domainName}.listByEntity" flushCache="false" useCache="true" parameterType="${domain.domainName}"  resultMap="${domain.domainName}ResultMap">
        select * 
        from ${domain.clazz.table.name}
    </select>
    <select id="${domain.domainName}.countIdsByEntity" flushCache="false" useCache="true" parameterType="${domain.domainName}"  resultType="integer">
        select count(distinct id) 
        from ${domain.clazz.table.name}
    </select>
    <insert id="${domain.domainName}.insert" flushCache="true" parameterType="${domain.domainName}">
    	insert into ${domain.clazz.table.name}<#assign x=0>
    	( ${domain.clazz.identifierProperty.name},<#list domain.properties as p><#assign x=x+1>${p.name}<#if x != domain.properties?size>,</#if></#list> ) <#assign x=0>
        values( <#noparse>#</#noparse>{<#list domain.clazz.identifierProperty.columnIterator as c>${c.name}</#list>},<#list domain.properties as p><#assign x=x+1><#list p.columnIterator as c><#noparse>#</#noparse>{${c.name}}</#list><#if x != domain.properties?size>,</#if></#list> )
    </insert>
    <update id="${domain.domainName}.update" parameterType="${domain.domainName}" flushCache="true">
        update ${domain.clazz.table.name} 
        <set>
       		<#list domain.properties as p>
			<if test="${p.name} != null"><#list p.columnIterator as c>${c.name}</#list>=<#noparse>#</#noparse>{${p.name}},</if>
			</#list>
		</set>
        where id = <#noparse>#</#noparse>{id}
    </update>
    <delete id="${domain.domainName}.deleteByEntity" flushCache="true" parameterType="${domain.domainName}" >
        delete 
        from ${domain.clazz.table.name} 
        where id = <#noparse>#</#noparse>{id}
    </delete>
    <delete id="${domain.domainName}.deleteById" flushCache="true" parameterType="Long" >
        delete 
        from ${domain.clazz.table.name} 
        where id = <#noparse>#</#noparse>{id}
    </delete>
</mapper>