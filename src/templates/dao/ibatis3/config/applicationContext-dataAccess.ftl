<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:p="http://www.springframework.org/schema/p" xmlns:context="http://www.springframework.org/schema/context"
       xmlns:jee="http://www.springframework.org/schema/jee" xmlns:tx="http://www.springframework.org/schema/tx"
       default-lazy-init="true"
       xsi:schemaLocation="
			http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
			http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.0.xsd
			http://www.springframework.org/schema/jee http://www.springframework.org/schema/jee/spring-jee-3.0.xsd
			http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx-3.0.xsd">


    <bean id="dataSource" class="org.logicalcobwebs.proxool.ProxoolDataSource">
    	<property name="alias" value="${project.name}" />
	    <property name="driver">
	        <value><#noparse>${jdbc.driverClassName}</#noparse></value>
	    </property>
		<property name="driverUrl" value="<#noparse>${jdbc.url}</#noparse>" />
		<property name="user" value="<#noparse>${jdbc.username}</#noparse>" />
		<property name="password" value="<#noparse>${jdbc.password}</#noparse>" />
	    
<!--	    <property name="houseKeepingSleepTime" value="90000" />-->
<!--	    <property name="maimumNewConnections" value="20" />-->
	    <property name="prototypeCount" value="5" />
	    <property name="maximumConnectionCount" value="30" />
	    <property name="minimumConnectionCount" value="3" />
	    <property name="simultaneousBuildThrottle" value="30" />
	    <property name="houseKeepingTestSql" value="select CURRENT_DATE" />
    </bean>

	<!-- mybatis SqlSessionFactory -->
	<bean id="sqlSessionFactory" class="${project.org}.security.dao.factory.SqlSessionFactoryBean">
		<property name="configLocation" value="classpath:conf/ibatis/mybatis-config.xml"></property>
		<property name="dataSource" ref="dataSource"></property>
	</bean>
    <!-- spring 事务管理 -->
	<bean id="transactionManager"
		class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
		<property name="dataSource" ref="dataSource" />
	</bean>
	<tx:annotation-driven transaction-manager="transactionManager" />
</beans>