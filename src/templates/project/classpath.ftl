<?xml version="1.0" encoding="UTF-8"?>
<classpath>
	<classpathentry kind="src" path="src"/>
	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER"/>
	<#if project.needTomcatPlug  >
	<classpathentry kind="var" path="TOMCAT_HOME/lib/servlet-api.jar"/>
	<classpathentry kind="var" path="TOMCAT_HOME/lib/jasper.jar"/>
	<classpathentry kind="var" path="TOMCAT_HOME/lib/jsp-api.jar"/>
	<classpathentry kind="var" path="TOMCAT_HOME/lib/el-api.jar"/>
	<classpathentry kind="var" path="TOMCAT_HOME/lib/annotations-api.jar"/>
	</#if>
	<#--
	<#list names as name>
	<classpathentry kind="lib" path="web/WEB-INF/lib/${name}"/>
	</#list>
	-->
	<classpathentry kind="con" path="org.eclipse.jst.j2ee.internal.web.container"/>
	<classpathentry kind="con" path="org.eclipse.jst.j2ee.internal.module.container"/>
	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/JavaSE-${project.jdkVersion}">
		<attributes>
			<attribute name="owner.project.facets" value="java"/>
		</attributes>
	</classpathentry>
	<classpathentry kind="output" path="web/WEB-INF/classes"/>
</classpath>
