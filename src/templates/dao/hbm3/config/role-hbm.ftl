<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE hibernate-mapping PUBLIC
        "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
        "http://hibernate.sourceforge.net/hibernate-mapping-3.0.dtd">
<hibernate-mapping package="${project.org}.domain" default-lazy="true">
    <class name="Role" table="${project.tablePre?default("")}role">
        <cache usage="read-write"/>
        <id name="<#if project.security.idNameIsId>id<#else>roleId</#if>" type="${project.security.idType2JavaType}" column="<#if project.security.idNameIsId>id<#else>role_id</#if>">
            <generator class="native"/>
        </id>
        <property name="name" length="50" not-null="true" type="string" column="name"/>
        <property name="descn" length="255" not-null="false" type="string" column="descn"/>
        <property name="title" length="200" not-null="false" type="string"  column="title"/>
        <set name="resources" inverse="false" table="${project.tablePre}role_resource" lazy="false" cascade="persist,save-update,merge">
            <key column="role_id"/>
            <many-to-many column="resource_id" class="Resource"/>
        </set>
        <set name="menus" inverse="false" table="${project.tablePre}menu_role" lazy="true" cascade="persist,save-update,merge">
            <key column="role_id"/>
            <many-to-many column="menu_id" class="Menu"/>
        </set>
        <set name="users" inverse="true" table="${project.tablePre}user_role" cascade="persist,save-update,merge">
            <key column="role_id"/>
            <many-to-many column="user_id" class="User"/>
        </set>
    </class>
</hibernate-mapping>