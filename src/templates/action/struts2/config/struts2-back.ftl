<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE struts PUBLIC
        "-//Apache Software Foundation//DTD Struts Configuration 2.0//EN"
        "http://struts.apache.org/dtds/struts-2.0.dtd">

<struts>
	<package name="back" namespace="/security" extends="comm">
        <default-interceptor-ref name="paramsPrepareParamsStack"/>
     </package>
     
     <#list modelDomains as domain>
        <!-- ${domain.domainName} action -->
     <package name="back${domain.domainName}" namespace="/security/${domain.domainName?uncap_first}" extends="back">
        
        <action name="list" class="back${domain.domainName}Action" method="list">
            <result name="success">/WEB-INF/back/${domain.domainName?uncap_first}/list.jsp</result>
        </action>
        
        <action name="input" class="back${domain.domainName}Action" method="input">
            <result name="success">/WEB-INF/back/${domain.domainName?uncap_first}/input.jsp</result>
        </action>
	
		<action name="save" class="back${domain.domainName}Action" method="save">
			<result name="success" type="redirectAction">
				<param name="actionName">list</param>
			</result>
			<result name="input">/WEB-INF/back/${domain.domainName?uncap_first}/input.jsp</result>
		</action>
	
		<action name="remove" class="back${domain.domainName}Action" method="remove">
			<result name="success" type="redirectAction">
				<param name="actionName">list</param>
			</result>
			<result name="input" type="redirectAction">
				<param name="actionName">list</param>
			</result>
		</action>
	
		<action name="removeMore" class="back${domain.domainName}Action" method="removeMore">
			<result name="success" type="redirectAction">
				<param name="actionName">list</param>
			</result>
			<result name="input" type="redirectAction">
				<param name="actionName">list</param>
			</result>
		</action>
		<action name="*" class="back${domain.domainName}Action" method="{0}">
            <result name="success">/WEB-INF/back/${domain.domainName?uncap_first}/{0}.jsp</result>
        </action>
	 </package>
        </#list>
		
    
</struts>