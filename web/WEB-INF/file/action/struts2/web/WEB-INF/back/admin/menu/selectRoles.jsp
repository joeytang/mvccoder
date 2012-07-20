<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/admin/common/taglibs.jsp" %>
<html>
<head>
    <%@ include file="/admin/common/meta.jsp" %>
    <script type="text/javascript" src="${ctx}/admin/js/admin/admin.js"></script>
    <script type="text/javascript">
    
     	function checkSelect(){
	           if(!isAnyNamedBoxSelected(document.getElementById("queryform"),"ids")){
	    		alert("至少选择一项！")
	            return false;
	    	}
	    	return true;
	    }
        function addUserRoleAuth() {
            if (confirm("确定要授权?")) {
                if (!atleaseOneCheck()) {
                    alert('请至少选择一角色！');
                    return;
                }
                document.getElementById("needAuth").value = 'true';
                document.getElementById('queryform').action = '${ctx}/security/menu/authRoles.html';
                document.getElementById('queryform').submit();
            }
        }

        function removeUserRoleAuth() {
            if (confirm("确定要取消授权?")) {
                if (!atleaseOneCheck()) {
                    alert('请至少选择一角色！');
                    return;
                }
                document.getElementById("needAuth").value = 'false';
                document.getElementById('queryform').action = '${ctx}/security/menu/authRoles.html';
                document.getElementById('queryform').submit();
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
<s:form id="queryform" name="queryform" method="post" action="selectRoles" namespace="/security/menu">
    <%--<div class="pageTitle" align="center"><b><h3>选择用户[${name}]拥有的角色</h3></b></div>--%>
    <s:actionmessage/>
    <div id="filterDiv" style="text-align: center;">
        <s:hidden name="id"/>
        <s:hidden name="needAuth" id="needAuth"/>
        授权：<s:select list="#{'0':'未授权','1':'已授权'}"
                     name="authorize"
                     value="%{authorize}"
                     headerKey=""
                     headerValue="所有"/>

        <input type="image" src="<c:url value="/admin/images/filter.gif"/>" class="nullBorder" onclick="document.getElementById('queryform').submit();"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="<c:url value="/security/menu/list.html"/>">返回</a>&nbsp;
        <a href="javascript:addUserRoleAuth();">授权</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:removeUserRoleAuth();">撤销授权</a>
    </div>
    <div id="tableDiv">
        <display:table name="selectRoles" class="simple" id="role">
            <display:column title="<input type='checkbox' name='checkall' id='checkall' onclick='checks()'>" class="td25">
                <input type="checkbox" id="ids" name="ids" value="${role.id}" style="border:0px"/>
            </display:column>
            <display:column property="title" title="角色名称"/>
            <display:column property="descn" title="角色描述"/>
            <display:column title="授权" style="width: 26px;text-align: center">
                <c:choose>
                    <c:when test="${role.authorize=='1'}">
                        <label style="color:red;">是</label>
                    </c:when>
                    <c:otherwise>
                        <label style="color:green;">否</label>
                    </c:otherwise>
                </c:choose>
            </display:column>
            <display:caption>选择菜单[${name}]拥有的角色</display:caption>
        </display:table>
    </div>
</s:form>
</body>
</html>
