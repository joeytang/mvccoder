log4j.rootLogger = info, console,logInfo

# console
#log4j.appender.console.Threshold = INFO
log4j.appender.console = org.apache.log4j.ConsoleAppender
log4j.appender.console.layout = org.apache.log4j.PatternLayout
log4j.appender.console.layout.ConversionPattern = %-d{yyyy-MM-dd HH:mm:ss} [%c]-[%p] %m%n

#log4j.logger.com.ibatis=debug
#log4j.logger.com.ibatis.common.jdbc.SimpleDataSource=debug
#log4j.logger.com.ibatis.common.jdbc.ScriptRunner=debug
#log4j.logger.com.ibatis.sqlmap.engine.impl.SqlMapClientDelegate=debug
log4j.logger.java.sql.Connection=debug
log4j.logger.java.sql.Statement=debug
log4j.logger.java.sql.PreparedStatement=debug

# logInfo
log4j.appender.logInfo = org.apache.log4j.DailyRollingFileAppender
log4j.appender.logInfo.File = <#noparse>${</#noparse>${project.name}.root<#noparse>}</#noparse>/WEB-INF/logs/log
log4j.appender.logInfo.DatePattern = '-'yyyyMMdd'.log'
log4j.appender.logInfo.layout = org.apache.log4j.PatternLayout
log4j.appender.logInfo.layout.ConversionPattern=%-d{yyyy-MM-dd HH\:mm\:ss} [%c]-[%p] - %m%n

