<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE hibernate-mapping PUBLIC
        "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
        "http://hibernate.sourceforge.net/hibernate-mapping-3.0.dtd">
<hibernate-mapping package="${project.org}.domain" default-lazy="true">
    <class name="Menu" table="${project.tablePre?default("")}menus">
        <cache usage="read-write"/>
        <id name="<#if project.security.idNameIsId>id<#else>menuId</#if>" type="${project.security.idType2JavaType}" column="<#if project.security.idNameIsId>id<#else>menu_id</#if>">
            <generator class="native"/>
        </id>
        <property name="iconCls" length="254" not-null="false" type="string" column="icon_cls"/>
        <property name="location" length="254" not-null="false" type="string" column="location"/>
        <property name="name" length="254" not-null="true" type="string" column="name"/>
        <property name="title" length="254" not-null="false" type="string" column="title"/>
        <many-to-one name="parent" class="Menu" column="parent_id" />
        <set name="roles" table="${project.tablePre}menu_roles" inverse="true" lazy="false" cascade="persist,save-update,merge">
            <key column="menu_id"/>
            <many-to-many column="role_id" class="Role"/>
        </set>
    </class>
</hibernate-mapping>