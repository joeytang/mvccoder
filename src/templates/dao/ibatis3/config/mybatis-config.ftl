<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <typeAliases>
        <!-- POJO ALIAS -->
        <#list domains as domain>
		<typeAlias alias="${domain.domainName}" type="${domain.domainRealPackage}.${domain.domainName}"/>
		</#list>
		
		<typeAlias alias="User" type="${project.org}.security.domain.User"/>
		<typeAlias alias="Role" type="${project.org}.security.domain.Role"/>
		<typeAlias alias="Menu" type="${project.org}.security.domain.Menu"/>
		<typeAlias alias="Resource" type="${project.org}.security.domain.Resource"/>
		<typeAlias alias="UserRole" type="${project.org}.security.domain.UserRole"/>
		<typeAlias alias="MenuRole" type="${project.org}.security.domain.MenuRole"/>
		<typeAlias alias="RoleResource" type="${project.org}.security.domain.RoleResource"/>
		<typeAlias alias="IbatisSqlFilter" type="${project.org}.security.dao.impl.IbatisSqlFilter"/>
    </typeAliases>

    <mappers>
        <!-- mapping -->
        <#list domains as domain>
        <mapper resource="${domain.domainRealPackage?replace(".","/")}/${domain.domainName}.xml"/>
		</#list>
		
        <mapper resource="org/joey/security/domain/User.xml"/>
        <mapper resource="org/joey/security/domain/Role.xml"/>
        <mapper resource="org/joey/security/domain/Menu.xml"/>
        <mapper resource="org/joey/security/domain/Resource.xml"/>
        <mapper resource="org/joey/security/domain/UserRole.xml"/>
        <mapper resource="org/joey/security/domain/MenuRole.xml"/>
        <mapper resource="org/joey/security/domain/RoleResource.xml"/>
        
    </mappers>
</configuration>
