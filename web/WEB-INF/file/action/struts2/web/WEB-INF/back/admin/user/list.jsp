<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/admin/common/taglibs.jsp" %>
<html>
<head>
    <%@ include file="/admin/common/meta.jsp" %>
    <script type="text/javascript" src="<c:url value="/admin/js/forwardpage.js"/>"></script>
</head>
<body>

<s:form id="queryform" method="post" action="list" namespace="/security/user">
    <%--<div class="pageTitle" align="center"><b><h3>用户管理</h3></b></div>--%>
    <s:actionmessage/>
    <div id="filterDiv" style="text-align: center;">
        姓名:
        <s:textfield name="name" maxLength="40"/>
        key名称:
        <s:textfield name="loginid" maxLength="40"/>
        <input type="hidden" name="forwardpagename" id="forwardpagename" value="${forwardpagename}">
        <input type="hidden" name="${forwardpagename}" id="${forwardpagename}">
        <input type="image" src="<c:url value="/admin/images/filter.gif"/>" class="nullBorder" onclick="document.getElementById('queryform').submit();"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="<c:url value="/security/user/input.html"/>">增加用户</a>
    </div>
    <div id="tableDiv">
        <display:table name="users" class="simple" id="user" pagesize="${pagesize}" size="${size}" requestURI="${ctx}/security/user/list.html" partialList="true">
            <display:column property="name" title="姓名"/>
            <display:column property="loginid" title="key名称"/>
            <display:column title="是否可用">
            <s:if test="!#attr.user.disabled">
            是
            </s:if>
            <s:else>
            否
            </s:else>
            </display:column>
           
            <display:column property="createDate" title="创建时间" format="{0,date,yyyy-MM-dd hh:mm:ss}"/>
            <display:column title="管理">
                <a href="<c:url value="/security/user/selectRoles.html?id=${user.id}" />">角色</a> &nbsp;&nbsp;&nbsp;
                <a href="<c:url value="/security/user/input.html?id=${user.id}" />">编辑</a> &nbsp;&nbsp;&nbsp;
                <a href="<c:url value="/security/user/remove.html?id=${user.id}" />" onclick="JavaScript:return confirm('你确认删除用户“${user.name}”吗？');">
                    删除
                </a>
            </display:column>
            <display:caption>用户管理</display:caption>
        </display:table>
    </div>
</s:form>
</body>
</html>
