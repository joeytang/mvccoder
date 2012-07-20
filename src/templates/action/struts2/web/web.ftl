<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://java.sun.com/xml/ns/j2ee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd"
         version="2.4">

    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:conf/spring/applicationContext-*.xml,/WEB-INF/conf/spring/spring-web.xml</param-value>
    </context-param>

    <context-param>
        <param-name>log4jConfigLocation</param-name>
        <param-value>classpath:log4j.properties</param-value>
    </context-param>

    <context-param>
        <param-name>webAppRootKey</param-name>
        <param-value>${project.name}.root</param-value>
    </context-param>

    <listener>
        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
    </listener>

    <listener>
        <listener-class>org.springframework.security.web.session.HttpSessionEventPublisher</listener-class>
    </listener>

    <listener>
        <listener-class>org.springframework.web.context.request.RequestContextListener</listener-class>
    </listener>

    <listener>
        <listener-class>org.springframework.web.util.Log4jConfigListener</listener-class>
    </listener>
    <listener>
        <listener-class>${project.org}.security.web.listener.AppListener</listener-class>
    </listener>

    <!-- Spring security Filter -->
    <filter>
        <filter-name>springSecurityFilterChain</filter-name>
        <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
    </filter>

    <filter>
        <filter-name>struts-cleanup</filter-name>
        <filter-class>org.apache.struts2.dispatcher.ActionContextCleanUp</filter-class>
    </filter>

    <filter>
        <filter-name>struts</filter-name>
        <filter-class>org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter</filter-class>
    </filter>

     <filter>
		<filter-name>disableUrlSessionFilter</filter-name>
		<filter-class>${project.org}.web.filter.DisableUrlSessionFilter</filter-class>
	</filter>
	<filter>
		<filter-name>encodingFilter</filter-name>
		<filter-class>
			org.springframework.web.filter.CharacterEncodingFilter
		</filter-class>
		<init-param>
			<param-name>encoding</param-name>
			<param-value>UTF-8</param-value>
		</init-param>
		<init-param>
			<param-name>forceEncoding</param-name>
			<param-value>true</param-value>
		</init-param>
	</filter>
	<filter>
		<filter-name>illegalParamFilter</filter-name>
		<filter-class>${project.org}.web.filter.IllegalFilter</filter-class>
		<init-param>
			<param-name>exclude</param-name>
			<param-value>d-..*</param-value>
		</init-param>
	</filter>
	
	<filter-mapping>
		<filter-name>encodingFilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
	<filter-mapping>
		<filter-name>illegalParamFilter</filter-name>
		<url-pattern>*.html</url-pattern>
	</filter-mapping>
	<filter-mapping>
		<filter-name>disableUrlSessionFilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
    <filter-mapping>
        <filter-name>struts-cleanup</filter-name>
        <url-pattern>*.html</url-pattern>
    </filter-mapping>

    <filter-mapping>
        <filter-name>springSecurityFilterChain</filter-name>
        <url-pattern>/j_spring_security_check</url-pattern>
    </filter-mapping>
    <filter-mapping>
        <filter-name>springSecurityFilterChain</filter-name>
        <url-pattern>/j_spring_security_logout</url-pattern>
    </filter-mapping>
    <filter-mapping>
        <filter-name>springSecurityFilterChain</filter-name>
        <url-pattern>/security/*</url-pattern>
        <dispatcher>REQUEST</dispatcher>
        <dispatcher>INCLUDE</dispatcher>
        <dispatcher>FORWARD</dispatcher>
    </filter-mapping>
    <filter-mapping>
        <filter-name>springSecurityFilterChain</filter-name>
        <url-pattern>/admin/*</url-pattern>
        <dispatcher>REQUEST</dispatcher>
        <dispatcher>INCLUDE</dispatcher>
        <dispatcher>FORWARD</dispatcher>
    </filter-mapping>

    <filter-mapping>
        <filter-name>struts</filter-name>
        <url-pattern>*.html</url-pattern>
        <dispatcher>REQUEST</dispatcher>
        <dispatcher>INCLUDE</dispatcher>
        <dispatcher>FORWARD</dispatcher>
    </filter-mapping>
    <filter-mapping>
        <filter-name>struts</filter-name>
        <url-pattern>*.jsp</url-pattern>
        <dispatcher>REQUEST</dispatcher>
        <dispatcher>INCLUDE</dispatcher>
        <dispatcher>FORWARD</dispatcher>
    </filter-mapping>

    <session-config>
        <session-timeout>300</session-timeout>
    </session-config>


    <mime-mapping>
        <extension>rar</extension>
        <mime-type>application/octet-stream</mime-type>
    </mime-mapping>
    <mime-mapping>
        <extension>zip</extension>
        <mime-type>application/octet-stream</mime-type>
    </mime-mapping>
    <mime-mapping>
        <extension>mht</extension>
        <mime-type>text/x-mht</mime-type>
    </mime-mapping>
    <mime-mapping>
        <extension>iso</extension>
        <mime-type>application/octet-stream</mime-type>
    </mime-mapping>
    <mime-mapping>
        <extension>xls</extension>
        <mime-type>application/octet-stream</mime-type>
    </mime-mapping>
    <mime-mapping>
        <extension>ape</extension>
        <mime-type>application/octet-stream</mime-type>
    </mime-mapping>
    <mime-mapping>
        <extension>doc</extension>
        <mime-type>application/octet-stream</mime-type>
    </mime-mapping>
    <mime-mapping>
        <extension>docx</extension>
        <mime-type>application/octet-stream</mime-type>
    </mime-mapping>
    <welcome-file-list>
        <welcome-file>index.jsp</welcome-file>
    </welcome-file-list>
    <error-page>
        <error-code>403</error-code>
        <location>/admin/common/401.jsp</location>
    </error-page>

</web-app>
