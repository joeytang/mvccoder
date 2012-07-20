<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE hibernate-mapping PUBLIC
        "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
        "http://hibernate.sourceforge.net/hibernate-mapping-3.0.dtd">
<hibernate-mapping package="${project.org}.domain" default-lazy="true">
    <class name="User" table="${project.tablePre?default("")}user">
        <cache usage="read-write"/>
        <id name="<#if project.security.idNameIsId>id<#else>userId</#if>" type="${project.security.idType2JavaType}" column="<#if project.security.idNameIsId>id<#else>user_id</#if>">
            <generator class="native"/>
        </id>
        <property name="account" type="string">
            <column name="account" length="50" not-null="true" unique="true" />
        </property>
        <property name="userName" type="string" column="user_name" length="50" not-null="true" />
        <property name="password" type="string" column="password" length="50" not-null="true" />
        <property name="createTime" length="50" not-null="false" column="create_time" type="timestamp"/>
        <property name="email" type="string" column="email" length="200" not-null="true"/>
        <property name="status" type="java.lang.Byte" column="status" not-null="true"/>
        <#if project.security.type==statics["com.wanmei.domain.SecurityHelper"].TYPE_COMPLEX>
		<set name="roles" table="security_user_roles" inverse="false" lazy="false" outer-join="auto">
            <key column="user_id"/>
            <many-to-many column="role_id" class="Role"/>
        </set>
        <#else>
        <property name="role" type="string" column="role" length="200" />
        </#if>
    </class>
</hibernate-mapping>