<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/admin/common/taglibs.jsp" %>
<html>
<head>
    <%@ include file="/admin/common/meta.jsp" %>
    <script type="text/javascript" src="<c:url value="/admin/js/forwardpage.js"/>"></script>
    <script type="text/javascript">
  //反选
    function checks() {
        var items = document.getElementsByName('ids');
        if (items.length > 0) {
            for (var i = 0; i < items.length; i++) {
                items[i].checked = document.getElementById("checkall").checked;
            }
        }
    }
    </script>
</head>

<body>

<div style="text-align: left;">
    <s:form id="queryform" method="post" action="list" namespace="/security/resource">
        <s:actionmessage/>
    <div id="filterDiv" style="text-align: center;">
        资源名称:
        <s:textfield name="name" maxLength="40"/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="hidden" name="forwardpagename" id="forwardpagename" value="${forwardpagename}">
        <input type="hidden" name="${forwardpagename}" id="${forwardpagename}">
        <input type="image" src="<c:url value="/admin/images/filter.gif"/>" class="nullBorder" onclick="document.getElementById('queryform').submit();"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="<c:url value="/security/resource/input.html"/>">添加资源</a>
	</div>
    </s:form>
</div>
<div id="tableDiv">
        <display:table name="resources" class="simple" id="resource">
        <display:column title="<input type='checkbox' name='checkall' id='checkall' onclick='checks()'>" class="td25">
            <input type="checkbox" id="ids" name="ids" value="${resource.id}" style="border:0px"/>
        </display:column>
        <display:column property="name" title="资源名称"/>
        <display:column property="type" title="资源类型"/>
        <display:column property="resString" title="资源串"/>
        <display:column  title="管理">
            <a href="<c:url value="/security/resource/input.html?id=${resource.id}" />">编辑</a>  &nbsp;&nbsp;&nbsp;
            <a href="<c:url value="/security/resource/remove.html?id=${resource.id}" />" onclick="JavaScript:return confirm('你确认删除吗？');">
                删除
            </a>
        </display:column>
        <display:caption>资源列表</display:caption>
    </display:table>
</div>
</body>
</html>
