<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://java.sun.com/xml/ns/j2ee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd"
         version="2.4">

    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:config/spring/spring-root.xml</param-value>
    </context-param>

    <context-param>
        <param-name>log4jConfigLocation</param-name>
        <param-value>classpath:config/log4j.properties</param-value>
    </context-param>

	<context-param>
        <param-name>webAppRootKey</param-name>
        <param-value>${project.name}.root</param-value>
    </context-param>

    <listener>
        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
    </listener>

    <listener>
        <listener-class>org.springframework.web.context.request.RequestContextListener</listener-class>
    </listener>

    <listener>
        <listener-class>org.springframework.web.util.Log4jConfigListener</listener-class>
    </listener>
    <listener>
        <listener-class>${project.org}.web.listener.AppListener</listener-class>
    </listener>

    <!-- Spring security Filter -->
    <filter>
        <filter-name>springSecurityFilterChain</filter-name>
        <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
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
	
	<filter-mapping>
		<filter-name>encodingFilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
	<filter-mapping>
		<filter-name>disableUrlSessionFilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>

    <filter-mapping>
        <filter-name>springSecurityFilterChain</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
    
	<!-- spring kill proxool to avoid housekeeper-->
	<servlet>
		<servlet-name>proxoolKiller</servlet-name>
		<servlet-class>${project.org}.web.servlet.ProxoolKillerServlet</servlet-class>
		<load-on-startup>1</load-on-startup>
	</servlet>
	<!-- spring mvc-->
	<servlet>
		<servlet-name>springmvc</servlet-name>
		<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
		<init-param>
			<param-name>contextConfigLocation</param-name>
			<param-value>classpath:config/spring/spring-mvc.xml</param-value>
		</init-param>
		<load-on-startup>2</load-on-startup>
	</servlet>
	<servlet-mapping>
		<servlet-name>springmvc</servlet-name>
		<url-pattern>/</url-pattern>
	</servlet-mapping>

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
        <location>/common/401.jsp</location>
    </error-page>

</web-app>
