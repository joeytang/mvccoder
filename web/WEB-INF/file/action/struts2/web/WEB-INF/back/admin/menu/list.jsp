<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/admin/common/taglibs.jsp" %>
<html>
<head>
 <%@ include file="/admin/common/meta.jsp" %>
 <script type="text/javascript">
 	$(document).ready(function(){
 		alertMessage("<g:msg/>");
	});
 	function checkSelect(){
           if(!isAnyNamedBoxSelected(document.getElementById("queryform"),"ids")){
    		alert("至少选择一项！")
            return false;
    	}
    	return true;
    }
    function checkRemoveMore(){
       if(!checkSelect()){
       		return false;
       }
       if (confirm('你确认删除该信息吗？')) {
       		$("#queryform").attr("action","${ctx}/security/menu/removeMore.html");
       		$("#queryform").submit();
       } else {
           return false;
       }
    }
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

    <s:form id="queryform" method="post" action="list" namespace="/security/menu">
<div style="text-align: left;">
        <s:actionmessage/>
    <div id="filterDiv" style="text-align: center;">
        菜单标示:
        <s:textfield name="name" maxLength="40"/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        菜单名称:
        <s:textfield name="title" maxLength="40"/>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="hidden" name="forwardpagename" id="forwardpagename" value="${forwardpagename}">
        <input type="hidden" name="${forwardpagename}" id="${forwardpagename}">
        <input type="image" src="<c:url value="/admin/images/filter.gif"/>" class="nullBorder" onclick="document.getElementById('queryform').submit();"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <s:if test="menu != null && menu.parentMenuItem != null && menu.parentMenuItem.id != null">
        	<a href="<c:url value="/security/menu/input.html?parentMenuItem.id=${menu.parentMenuItem.id}"/>">添加资源</a>
        </s:if>
        <s:else>
        	<a href="<c:url value="/security/menu/input.html"/>">添加资源</a>
        </s:else>
        <s:hidden name="parentMenuItem.id" />
	</div>
</div>
<div id="tableDiv">
        <display:table name="menus" class="simple" id="menu" pagesize="${pagesize}" size="${size}" requestURI="${ctx}/security/menu/list.html" partialList="true">
        <display:column title="<input type='checkbox' name='checkall' id='checkall' onclick='checks()'>" class="td25">
            <input type="checkbox" id="ids" name="ids" value="${menu.id}" style="border:0px"/>
        </display:column>
        <display:column property="name" title="菜单标示">
        </display:column>
        <display:column title="菜单名称">
        	<a href="<c:url value="/security/menu/list.html?parentMenuItem.id=${menu.id}" />">
        		${menu.title}
        	</a>
        </display:column>
        <display:column  title="管理">
            <a href="<c:url value="/security/menu/input.html?id=${menu.id}" />">编辑</a>  &nbsp;&nbsp;&nbsp;
            <a href="<c:url value="/security/menu/remove.html?id=${menu.id}" />" onclick="JavaScript:return confirm('你确认删除吗？');">
                删除
            </a>
        </display:column>
        <display:caption>菜单列表</display:caption>
    </display:table>
    <input type="button" name="but_1" class="nullBorder" value="批量删除" onclick="checkRemoveMore()" /> &nbsp;&nbsp;&nbsp;&nbsp;
</div>
    </s:form>
</body>
</html>
