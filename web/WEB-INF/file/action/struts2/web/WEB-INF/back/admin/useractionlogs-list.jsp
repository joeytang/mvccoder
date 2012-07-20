<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/admin/common/taglibs.jsp" %>
<html>
<head>
    <%@ include file="/admin/common/meta.jsp" %>
    <script type="text/javascript" src="<c:url value="/admin/js/forwardpage.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/admin/js/date/WdatePicker.js"/>"></script>
</head>
<body>
<s:form id="userLogsForm" method="post" action="useractionlogs-list" namespace="/security">
    <div id="filterDiv" style="text-align: center;">
	      用户名称:
	      <s:textfield name="username" size="10" id="title" maxlength="40" />
	      &nbsp;&nbsp;
          起始时间: 
          <s:textfield name="beginDate" size="30" id="beginDate" maxLength="50" cssClass="Wdate" cssStyle="width:180px;height:18px;" onfocus="javascript:new WdatePicker(this,'%Y-%M-%D %h:%m:%s',true);" value="%{@com.wanmei.system.security.util.DateTimeUtil@forMatDate(beginDate)}"/>
        &nbsp;&nbsp;
            结束时间:
          <s:textfield name="endDate" size="30" id="endDate" maxLength="50" cssClass="Wdate" cssStyle="width:180px;height:18px;" onfocus="javascript:new WdatePicker(this,'%Y-%M-%D %h:%m:%s',true);" value="%{@com.wanmei.system.security.util.DateTimeUtil@forMatDate(endDate)}"/>
        &nbsp;&nbsp;
        <input type="hidden" name="forwardpagename" id="forwardpagename" value="${forwardpagename}">
        <input type="hidden" name="${forwardpagename}" id="${forwardpagename}">
          <input type="submit" class="btn" name="modsubmit" value="查询"  /></div>
    <div id="tableDiv">
        <display:table name="userActionLogses" class="simple" id="art" requestURI="${ctx}/security/useractionlogs-list.action"  pagesize="${pagesize}"  size="${size}"  partialList="true">
            <display:column title="ID" property="id"/>
            <display:column title="数据源" property="dataSourceName"/>
            <display:column title="表名" property="tableName"/>
            <display:column title="对象标识" property="entityKey"/>
            <display:column title="用户KEY名称" property="userName"/>
            <display:column title="事件" property="actionName"/>
            <display:column title="操作对象" property="entityName"/>
            <display:column title="IP" property="actionIP"/>
            <display:column title="操作时间" property="actionDate" format="{0,date,yyyy-MM-dd HH:mm:ss}"/>
            <display:caption>日志信息</display:caption>
        </display:table>
    </div>
</s:form>
</body>
</html>
