<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE struts PUBLIC
        "-//Apache Software Foundation//DTD Struts Configuration 2.0//EN"
        "http://struts.apache.org/dtds/struts-2.0.dtd">

<struts>

	<package name="view" namespace="/view" extends="comm">
        <default-interceptor-ref name="authStack"/>
     </package>
        <#list modelDomains as domain>
    <package name="view${domain.domainName}" namespace="/view/${domain.domainName?uncap_first}" extends="comm">
        <!-- ${domain.domainName} action -->
        <action name="list" class="view${domain.domainName}Action" method="list">
            <result name="success">/WEB-INF/view/${domain.domainName?uncap_first}/list.jsp</result>
        </action>
        
        <action name="input" class="view${domain.domainName}Action" method="input">
            <result name="success">/WEB-INF/view/${domain.domainName?uncap_first}/input.jsp</result>
        </action>
	
		<action name="save" class="view${domain.domainName}Action" method="save">
			<result name="success" type="redirectAction">
				<param name="actionName">list</param>
			</result>
			<result name="input">/WEB-INF/view/${domain.domainName?uncap_first}/input.jsp</result>
		</action>
	
		<action name="remove" class="view${domain.domainName}Action" method="remove">
			<result name="success" type="redirectAction">
				<param name="actionName">list</param>
			</result>
			<result name="input" type="redirectAction">
				<param name="actionName">list</param>
			</result>
		</action>
	
		<action name="removeMore" class="view${domain.domainName}Action" method="removeMore">
			<result name="success" type="redirectAction">
				<param name="actionName">list</param>
			</result>
			<result name="input" type="redirectAction">
				<param name="actionName">list</param>
			</result>
		</action>
		<action name="*" class="view${domain.domainName}Action" method="{0}">
            <result name="success">/WEB-INF/view/${domain.domainName?uncap_first}/{0}.jsp</result>
        </action>
    </package>
        </#list>
        
</struts>