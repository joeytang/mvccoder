<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE hibernate-mapping PUBLIC
        "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
        "http://hibernate.sourceforge.net/hibernate-mapping-3.0.dtd">
<hibernate-mapping package="${project.org}.domain" default-lazy="true">
    <class name="Resource" table="${project.tablePre?default("")}resource">
        <cache usage="read-write"/>
        <id name="<#if project.security.idNameIsId>id<#else>resourceId</#if>" type="${project.security.idType2JavaType}" column="<#if project.security.idNameIsId>id<#else>resource_id</#if>">
            <generator class="native"/>
        </id>
        <property name="name" length="200" type="string" not-null="true" column="name"/>
        <property name="type" length="50" type="string" not-null="true" column="type"/>
        <property name="resString" length="255" type="string" not-null="false" column="res_string"/>
        <property name="descn" length="255" type="string" not-null="false" column="descn"/>
        <set name="roles" lazy="false" inverse="true" table="${project.tablePre}role_resource" cascade="persist,save-update,merge">
            <key column="resource_id"/>
            <many-to-many column="role_id" class="Role"/>
        </set>
    </class>
</hibernate-mapping>