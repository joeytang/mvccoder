<?xml version="1.0" encoding="UTF-8"?>

<beans:beans xmlns="http://www.springframework.org/schema/security"
             xmlns:beans="http://www.springframework.org/schema/beans"
             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
             xmlns:aop="http://www.springframework.org/schema/aop"
             xsi:schemaLocation="
             http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
             http://www.springframework.org/schema/security http://www.springframework.org/schema/security/spring-security-3.1.xsd 
             http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop-3.0.xsd">

    <beans:bean id="loggerListener" class="org.springframework.security.access.event.LoggerListener"/>

   	<http pattern="/static/**" security='none'/>
   	<http pattern="/common/**" security='none'/>
    <http pattern="/js/**" security='none'/>
    <http pattern="/images/**" security='none'/>
    <http pattern="/style/**" security='none'/>
    <http pattern="/login.jsp" security='none'/>
    <http pattern="/accessDenied.jsp" security='none'/>
    <http pattern="/favicon.ico" security='none'/>
    <http access-denied-page="/common/accessDenied.jsp" entry-point-ref="myAuthenticationProcessingFilterEntryPoint">
<!--     	<intercept-url pattern="/**" access="ROLE_ADMIN" requires-channel="https"/>-->
     	<#if project.security.type == statics["com.wanmei.domain.SecurityHelper"].TYPE_SIMPLE>
     	<intercept-url pattern="/**" access="ROLE_ADMIN,ROLE_USER" />
     	</#if>
        <form-login login-page="/login.jsp" authentication-failure-url="/login.jsp?login_error=true" default-target-url="/index.jsp" always-use-default-target="true" />
       	<logout invalidate-session="true" logout-success-url="/login.jsp" logout-url="/logout"/>
<!--        <x509 subject-principal-regex="CN=([^,]*)" />-->
		<#if project.security.type == statics["com.wanmei.domain.SecurityHelper"].TYPE_COMPLEX>
	 	<custom-filter ref="resourceSecurityInterceptor"  after="LAST"/>
	 	</#if>
    </http>
    
    <authentication-manager alias="authenticationManager">
	    <authentication-provider user-service-ref="securityUserService">
			<password-encoder hash="plaintext"/>
	    </authentication-provider>
    </authentication-manager>
    <!-- 未登录的切入点 -->
	<beans:bean id="myAuthenticationProcessingFilterEntryPoint"
		class="${project.org}.common.security.MyAuthenticationProcessingFilterEntryPoint">
		<beans:property name="loginFormUrl" value="/login.jsp"></beans:property>
	</beans:bean>
    <#if project.security.type == statics["com.wanmei.domain.SecurityHelper"].TYPE_COMPLEX>
 	<beans:bean id="passwordEncoder" class="org.springframework.security.authentication.encoding.PlaintextPasswordEncoder"/>

    <beans:bean id="accessDecisionManager" class="org.springframework.security.access.vote.AffirmativeBased">
        <beans:property name="allowIfAllAbstainDecisions" value="false"/>
        <beans:property name="decisionVoters">
            <beans:list>
                <beans:bean class="org.springframework.security.access.vote.RoleVoter"/>
                <beans:bean class="org.springframework.security.access.vote.AuthenticatedVoter"/>
            </beans:list>
        </beans:property>
    </beans:bean>

    <beans:bean id="resourceSecurityInterceptor" class="org.springframework.security.web.access.intercept.FilterSecurityInterceptor">
        <beans:property name="authenticationManager" ref="authenticationManager"/>
        <beans:property name="accessDecisionManager" ref="accessDecisionManager"/>
        <beans:property name="securityMetadataSource" ref="secureResourceFilterInvocationDefinitionSource"/>
        <beans:property name="observeOncePerRequest" value="false"/>
    </beans:bean>

    <aop:config proxy-target-class="false">
        <aop:pointcut id="securityPointcut" expression="execution(* ${project.org}.*.service.*Manager*.*(..))"/>
        <aop:advisor advice-ref="methodSecurityInterceptor" pointcut-ref="securityPointcut" order="0"/>
    </aop:config>

    <beans:bean id="methodSecurityInterceptor"
                class="org.springframework.security.access.intercept.aopalliance.MethodSecurityInterceptor">
        <beans:property name="authenticationManager" ref="authenticationManager"/>
        <beans:property name="accessDecisionManager" ref="accessDecisionManager"/>
        <beans:property name="securityMetadataSource" ref="databaseMethodDefinitionSource"/>
    </beans:bean>

     <beans:bean id="userCache" class="org.springframework.security.core.userdetails.cache.EhCacheBasedUserCache">
        <beans:property name="cache">
            <beans:bean class="org.springframework.cache.ehcache.EhCacheFactoryBean" autowire="byName">
                <beans:property name="cacheManager" ref="cacheManager"/>
                <beans:property name="cacheName" value="userCache"/>
            </beans:bean>
        </beans:property>
    </beans:bean>

    <beans:bean id="resourceCache" class="${project.org}.cache.ResourceCache">
        <beans:property name="cache">
            <beans:bean class="org.springframework.cache.ehcache.EhCacheFactoryBean" autowire="byName">
                <beans:property name="cacheManager" ref="cacheManager"/>
                <beans:property name="cacheName" value="resourceCache"/>
            </beans:bean>
        </beans:property>
    </beans:bean>

    <beans:bean id="menuCache" class="${project.org}.cache.MenuCache">
        <beans:property name="cache">
            <beans:bean class="org.springframework.cache.ehcache.EhCacheFactoryBean" autowire="byName">
                <beans:property name="cacheManager" ref="cacheManager"/>
                <beans:property name="cacheName" value="menuCache"/>
            </beans:bean>
        </beans:property>
    </beans:bean>
 	</#if>
    
</beans:beans>
