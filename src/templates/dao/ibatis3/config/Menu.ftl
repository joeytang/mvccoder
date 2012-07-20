<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${project.org}.security.domain.Menu">
    <!-- 二级缓存 -->
    <cache eviction="LRU"
           flushInterval="60000"
           size="1024"
           readOnly="true"/>
           
    <resultMap id="MenuResultMap" type="Menu">
	 	<id property="id" column="id" />
	 	<result property="action" column="action" />
	 	<result property="align" column="align" />
	 	<result property="description" column="description" />
	 	<result property="forward" column="forward" />
	 	<result property="height" column="height" />
	 	<result property="image" column="image" />
	 	<result property="location" column="location" />
	 	<result property="name" column="name" />
	 	<result property="onclick" column="onclick" />
	 	<result property="ondblclick" column="ondblclick" />
	 	<result property="onmouseout" column="onmouseout" />
	 	<result property="onmouseover" column="onmouseover" />
	 	<result property="page" column="page" />
	 	<result property="target" column="target" />
	 	<result property="title" column="title" />
	 	<result property="toolTip" column="toolTip" />
	 	<result property="width" column="width" />
	 	<result property="displayOrder" column="displayOrder" />
	 	<association property="parentMenuItem" column="parent_id" javaType="Menu" select="Menu.selectOneById"/>
		<collection property="roles" ofType="Role" resultMap="RoleResultMap" />
	</resultMap>
	
    <select id="Menu.listMenuByParent" flushCache="false" useCache="true" parameterType="Long"  resultMap="MenuResultMap">
        select m.*,r.*  
        from security_menus m 
        left join security_menu_roles mr on m.id = mr.menu_id  
        left join security_roles r on r.id = mr.role_id 
        where m.id=<#noparse>#</#noparse>{id} 
    </select>
    <select id="Menu.selectOneById" flushCache="false" useCache="true" parameterType="Long"  resultMap="MenuResultMap">
        select m.*,r.*  
        from security_menus m 
        left join security_menu_roles mr on m.id = mr.menu_id  
        left join security_roles r on r.id = mr.role_id 
        where m.id=<#noparse>#</#noparse>{id} 
    </select>
    <select id="Menu.selectOneByEntity" flushCache="false" useCache="true" parameterType="Menu"  resultMap="MenuResultMap">
        select m.*,r.*  
        from security_menus m 
        left join security_menu_roles mr on m.id = mr.menu_id  
        left join security_roles r on r.id = mr.role_id 
        where m.id=<#noparse>#</#noparse>{id} 
    </select>
    <select id="Menu.listAll" flushCache="false" useCache="true" resultMap="MenuResultMap">
        select m.*,r.*  
        from security_menus m 
        left join security_menu_roles mr on m.id = mr.menu_id  
        left join security_roles r on r.id = mr.role_id 
    </select>
    <select id="Menu.countAllIds" flushCache="false" useCache="true" resultType="integer">
        select count(distinct id) 
        from security_menus
    </select>
    <select id="Menu.listByEntity" flushCache="false" useCache="true" parameterType="Menu"  resultMap="MenuResultMap">
        select m.*,r.*  
        from security_menus m 
        left join security_menu_roles mr on m.id = mr.menu_id  
        left join security_roles r on r.id = mr.role_id 
    </select>
    <select id="Menu.countIdsByEntity" flushCache="false" useCache="true" parameterType="Menu"  resultType="integer">
        select count(distinct id) 
        from security_menus
    </select>
    <insert id="Menu.insert" flushCache="true" parameterType="Menu">
    	insert into security_menus
    	(action,align,description,forward,height,image,location,name,onclick,ondblclick,onmouseout,onmouseover,page,target,title,toolTip,width,displayOrder,parent_id) 
        values(<#noparse>#</#noparse>{action},<#noparse>#</#noparse>{align},<#noparse>#</#noparse>{description},<#noparse>#</#noparse>{forward},<#noparse>#</#noparse>{height},<#noparse>#</#noparse>{image},<#noparse>#</#noparse>{location},<#noparse>#</#noparse>{name},<#noparse>#</#noparse>{onclick},<#noparse>#</#noparse>{ondblclick},<#noparse>#</#noparse>{onmouseout},<#noparse>#</#noparse>{onmouseover},<#noparse>#</#noparse>{page},<#noparse>#</#noparse>{target},<#noparse>#</#noparse>{title},<#noparse>#</#noparse>{toolTip},<#noparse>#</#noparse>{width},<#noparse>#</#noparse>{displayOrder},<#noparse>#</#noparse>{parentMenuItem.id})
    </insert>
    <update id="Menu.update" parameterType="Menu" flushCache="true">
        update security_menus 
        <set>
			<if test="action != null">action=<#noparse>#</#noparse>{action},</if>
			<if test="align != null">align=<#noparse>#</#noparse>{align},</if>
			<if test="description != null">description=<#noparse>#</#noparse>{description},</if>
			<if test="forward != null">forward=<#noparse>#</#noparse>{forward},</if>
			<if test="height != null">height=<#noparse>#</#noparse>{height},</if>
			<if test="image != null">image=<#noparse>#</#noparse>{image},</if>
			<if test="location != null">location=<#noparse>#</#noparse>{location},</if>
			<if test="onclick != null">onclick=<#noparse>#</#noparse>{onclick},</if>
			<if test="ondblclick != null">ondblclick=<#noparse>#</#noparse>{ondblclick},</if>
			<if test="onmouseout != null">onmouseout=<#noparse>#</#noparse>{onmouseout},</if>
			<if test="onmouseover != null">onmouseover=<#noparse>#</#noparse>{onmouseover},</if>
			<if test="page != null">page=<#noparse>#</#noparse>{page},</if>
			<if test="target != null">target=<#noparse>#</#noparse>{target},</if>
			<if test="title != null">title=<#noparse>#</#noparse>{title},</if>
			<if test="toolTip != null">toolTip=<#noparse>#</#noparse>{toolTip},</if>
			<if test="width != null">width=<#noparse>#</#noparse>{width},</if>
			<if test="displayOrder != null">displayOrder=<#noparse>#</#noparse>{displayOrder},</if>
			<if test="parentMenuItem != null and null != parentMenuItem.id">parent_id=<#noparse>#</#noparse>{parentMenuItem.id}</if>
		</set>
        where id = <#noparse>#</#noparse>{id}
    </update>
    <delete id="Menu.deleteByEntity" flushCache="true" parameterType="Menu" >
        delete 
        from security_menus 
        where id = <#noparse>#</#noparse>{id}
    </delete>
    <delete id="Menu.deleteById" flushCache="true" parameterType="Long" >
        delete 
        from security_menus 
        where id = <#noparse>#</#noparse>{id}
    </delete>
</mapper>