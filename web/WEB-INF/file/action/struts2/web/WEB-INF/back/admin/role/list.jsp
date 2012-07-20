<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/admin/common/taglibs.jsp" %>
<html>
<head>
    <%@ include file="/admin/common/meta.jsp" %>
    <script type="text/javascript" src="<c:url value="/admin/js/forwardpage.js"/>"></script>
    <script type="text/javascript">
    $(document).ready(function(){
    	alertMessage("<g:msg/>");
	});
    </script>
</head>
<body>
<s:form id="queryform" method="post" action="list" namespace="/security/role">
    <s:actionmessage/>
    <div id="filterDiv" style="text-align: center;">
        角色名称:
        <s:textfield name="title" maxLength="40"/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="hidden" name="forwardpagename" id="forwardpagename" value="${forwardpagename}">
        <input type="hidden" name="${forwardpagename}" id="${forwardpagename}">
        <input type="image" src="<c:url value="/admin/images/filter.gif"/>" class="nullBorder" onclick="document.getElementById('queryform').submit();"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="<c:url value="/security/role/input.html"/>">添加角色</a>
</div>
    <div id="tableDiv">
        <display:table name="roles" class="simple" id="role"  pagesize="${pagesize}"  size="${size}" requestURI="${ctx}/security/role/list.html" partialList="true" >
            <display:column property="title" title="角色名称"/>
            <display:column title="角色描述">
            	<span id="role${role.id}" title=" ${fn:replace(fn:replace(role.descn,']','>'),'[','<')}"
                      style="font-family:arial;font-size:12px;font-weight:bold;color:#ABABAB;cursor:pointer">
                       ${fn:substring(role.descn, 0,5 )}</span>
            </display:column>
            <display:column  title="管理">
            	<a href="<c:url value="/security/role/selectMenus.html?id=${role.id}" />">菜单</a>&nbsp;&nbsp;&nbsp;
                <a href="<c:url value="/security/role/selectResources.html?id=${role.id}" />">资源</a>  &nbsp;&nbsp;&nbsp;
                <a href="<c:url value="/security/role/input.html?id=${role.id}" />">编辑</a>  &nbsp;&nbsp;&nbsp;
                <a href="<c:url value="/security/role/remove.html?id=${role.id}" />" onclick="JavaScript:return confirm('你确认删除角色“${role.title}”吗？');">
                    删除
                </a>
            </display:column>
            <display:caption>角色管理</display:caption>
        </display:table>
    </div>
</s:form>
</body>
</html>
