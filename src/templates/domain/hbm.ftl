<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE hibernate-mapping PUBLIC 
	"-//Hibernate/Hibernate Mapping DTD 3.0//EN" 
	"http://hibernate.sourceforge.net/hibernate-mapping-3.0.dtd">
<hibernate-mapping package="${domain.packageName}">
	<class name="${domain.packageName}.${domain.name}" table="${domain.table}">
		<#if domain.isMany2ManyKey>
		<composite-id name="id" class="${domain.packageName}.${domain.name}">
		<#list domain.allFields as f>
			<key-property name="${f.name}" column="${f.column}" type="java.lang.${f.primaryType}"/>
   		</#list>
   		</composite-id>
		<#else>
			<#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>
		<composite-id name="${domain.id.name}" class="${domain.id.entityPackage}.${domain.id.entityName}">
		<#list project.domainMap[domain.id.entityName].fields as f>
			<key-property name="${f.name}" column="${f.column}" type="java.lang.${f.primaryType}"/>
   		</#list>
   		</composite-id>
   			<#else>
		<cache usage="read-write"/>
        <id name="${domain.id.name}" type="java.lang.${domain.id.primaryType}">
            <column name="${domain.id.column}" />
            <generator class="native" />
        </id>
        	</#if>
        <#list domain.hbmableFields as f>
		<#if f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_INT>
		<property name="${f.name}" type="java.lang.Integer" column="${f.column}" <#if !f.nullable>not-null="true"</#if> />
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_STRING)>
		<property name="${f.name}" type="string" column="${f.column}" length="${(f.length?c)?default("250")}" <#if !f.nullable>not-null="true"</#if> />
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_FILE)>
		<property name="${f.name}" type="string" column="${f.column}" length="${(f.length?c)?default("250")}" <#if !f.nullable>not-null="true"</#if> />
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_LONG)>
		<property name="${f.name}" type="java.lang.Long" column="${f.column}" <#if !f.nullable>not-null="true"</#if> />
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_FLOAT)>
		<property name="${f.name}" type="java.lang.Float" column="${f.column}" <#if !f.nullable>not-null="true"</#if> />
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_DOUBLE)>
		<property name="${f.name}" type="java.lang.Double" column="${f.column}" <#if !f.nullable>not-null="true"</#if> />
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_DATE)>
		<property name="${f.name}" type="timestamp" column="${f.column}" <#if !f.nullable>not-null="true"</#if> />
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_DATETIME)>
		<property name="${f.name}" type="timestamp" column="${f.column}" <#if !f.nullable>not-null="true"</#if> />
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_TEXT)>
		<property name="${f.name}" type="text" column="${f.column}" length="${(f.length?c)?default("65500")}" <#if !f.nullable>not-null="true"</#if> />
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_CLOB)>
		<property name="${f.name}" type="text" column="${f.column}" length="${(f.length?c)?default("65500")}" <#if !f.nullable>not-null="true"</#if> />
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_BYTE)>
		<property name="${f.name}" type="java.lang.Byte" column="${f.column}" <#if !f.nullable>not-null="true"</#if> />
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_BOOLEAN)>
		<property name="${f.name}" type="java.lang.Boolean" column="${f.column}" <#if !f.nullable>not-null="true"</#if> />
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>
		<many-to-one name="${f.name}" class="${f.entityPackage}.${f.entityName}" fetch="select" lazy="false" column="${f.column}" />
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_ONE2MANY)>
		<set name="${f.name}" inverse="true" lazy="true" fetch="select" <#if f.table??>table="${f.table}"</#if> >
           	<cache usage="read-write"/>
            <key>
                <column name="${f.column}" />
            </key>
            <one-to-many class="${f.entityPackage}.${f.entityName}" />
        </set>
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2MANY)>
		<set name="${f.name}" lazy="true" table="${f.table}" fetch="select" >
            <cache usage="read-write"/>
            <key>
                <column name="${f.column}" />
            </key>
            <many-to-many entity-name="${f.entityPackage}.${f.entityName}" >
                <column name="${f.manyColumn}" <#if !f.nullable>not-null="true"</#if> />
            </many-to-many>
        </set>
		<#else>
		<property name="${f.name}" type="java.lang.String" column="${f.column}" length="${(f.length?c)?default("250")}" <#if !f.nullable>not-null="true"</#if> />
		</#if>
		</#list>
		</#if>
    </class>
</hibernate-mapping>