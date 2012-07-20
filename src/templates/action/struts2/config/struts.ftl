<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE struts PUBLIC
        "-//Apache Software Foundation//DTD Struts Configuration 2.0//EN"
        "http://struts.apache.org/dtds/struts-2.0.dtd">

<struts>

    <constant name="struts.objectFactory" value="spring"/>
    <constant name="struts.devMode" value="false"/>
    <constant name="struts.ui.theme" value="simple"/>
    <!--<constant name="struts.i18n.reload" value="false"/>-->
    <!--<constant name="struts.configuration.xml.reload" value="false"/>-->
    <constant name="struts.custom.i18n.resources" value="res.globalMessages"/>
    <constant name="struts.i18n.encoding" value="UTF-8"/>
    <!--<constant name="struts.serve.static" value="true"/>-->
    <!--<constant name="struts.serve.static.browserCache" value="false"/>-->
     <constant name="struts.multipart.maxSize" value="524288000"/>
     <constant name="struts.action.extension" value="html"/>
     <constant name="struts.ognl.allowStaticMethodAccess" value="true"/>
    <package name="comm" extends="struts-default">
    	<interceptors>
        	<interceptor name="login" class="${project.org}.security.struts.interceptor.LoginInterceptor"/>
			<interceptor-stack name="paramsPrepareParamsStack">
                <interceptor-ref name="exception"/>
                <interceptor-ref name="alias"/>
                <interceptor-ref name="i18n"/>
                <interceptor-ref name="checkbox"/>
                <interceptor-ref name="multiselect"/>
                <interceptor-ref name="params">
                    <param name="excludeParams">dojo\..*,^struts\..*,d-..*</param>
                </interceptor-ref>
                <interceptor-ref name="servletConfig"/>
                <interceptor-ref name="prepare"/>
                <interceptor-ref name="chain"/>
                <interceptor-ref name="modelDriven"/>
                <interceptor-ref name="fileUpload"/>
                <interceptor-ref name="staticParams"/>
                <interceptor-ref name="actionMappingParams"/>
                <interceptor-ref name="params">
                    <param name="excludeParams">dojo\..*,^struts\..*,d-..*</param>
                </interceptor-ref>
                <interceptor-ref name="conversionError"/>
                <interceptor-ref name="validation">
                    <param name="excludeMethods">input,back,cancel,browse</param>
                </interceptor-ref>
                <interceptor-ref name="workflow">
                    <param name="excludeMethods">input,back,cancel,browse</param>
                </interceptor-ref>
            </interceptor-stack>
            <interceptor-stack name="authStack">
                <interceptor-ref name="paramsPrepareParamsStack"/>
                <interceptor-ref name="login"/>
            </interceptor-stack>
        </interceptors>

        <global-results>
            <result name="nologin">/admin/message.jsp</result>
            <result name="illegeParam">/illegeparam.jsp</result>
            <result name="error">/error.jsp</result>
        </global-results>
        <global-exception-mappings>
            <exception-mapping exception="java.lang.Throwable" result="error"/>
        </global-exception-mappings>
    </package>

    <include file="conf/struts/struts2-security.xml"/>
    <include file="conf/struts/struts2-back.xml"/>
    <include file="conf/struts/struts2-view.xml"/>
</struts>
