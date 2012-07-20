<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/admin/common/taglibs.jsp" %>
<html>
<head>
    <%@ include file="/admin/common/meta.jsp" %>
    <script type="text/javascript" src="${ctx}/admin/js/admin/admin.js"></script>
    <script type="text/javascript">
    	function checkSelect(){
	           if(!isAnyNamedBoxSelected(document.getElementById("selectMenuForm"),"ids")){
	    		alert("至少选择一项！")
	            return false;
	    	}
	    	return true;
	    }
        function addRoleMenuAuth(){
            if (confirm("确定要授权?")){
                if (!checkSelect()){
                    alert('请至少选择一角色！');
                    return;
                }
                document.getElementById("needAuth").value = 'true';
                document.getElementById("selectMenuForm").action = '${ctx}/security/role/authMenus.html';
                document.getElementById("selectMenuForm").submit();
            }
        }
        function removeRoleMenuAuth(){
            if (confirm("确定要取消授权?")){
                if (!checkSelect()){
                    alert('请至少选择一菜单！');
                    return;
                }

                document.getElementById("needAuth").value = 'false';
                document.getElementById("selectMenuForm").action = '${ctx}/security/role/authMenus.html';
                document.getElementById("selectMenuForm").submit();
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
<s:form id="selectMenuForm" name="selectMenuForm" method="post" action="selectMenus" namespace="/security/role">
    <%--<div class="pageTitle" align="center"><b><h3>选择角色[${title}]拥有的菜单</h3></b></div>--%>
    <s:actionmessage/>
    <div id="filterDiv" style="text-align: center;">
        <s:hidden name="needAuth" id="needAuth"/>
        <s:hidden name="id"/>
        授权：
        <s:select list="#{'0':'未授权','1':'已授权'}"
                  name="searchAuthorize"
                  value="%{searchAuthorize}"
                  headerKey=""
                  headerValue="所有"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="image" src="<c:url value="/admin/images/filter.gif"/>" class="nullBorder" onclick="document.getElementById('selectMenuForm').submit();"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="<c:url value="/security/role/list.html"/>">返回</a>&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="javascript:addRoleMenuAuth();">授权</a>&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="javascript:removeRoleMenuAuth();">撤销授权</a>
</div>
    <div id="tableDiv">
        <display:table name="selectMenus" class="simple" id="menu" >
            <display:column title="<input type='checkbox' name='checkall' id='checkall' onclick='checks()'>" class="td25">
                <input type="checkbox" id="ids" name="ids" value="${menu.id}" style="border:0px"/>
            </display:column>
            <%--<display:column property="name" title="英文名称"/>--%>
            <display:column property="title" title="菜单名称"/>
            <display:column title="授权" style="width: 26px;text-align: center">
                <c:choose>
                            <c:when test="${menu.authorize=='1'}">
                                <label style="color:red;">是</label>
                            </c:when>
                            <c:otherwise>
                                <label style="color:green;">否</label>
                            </c:otherwise>
                        </c:choose>
            </display:column>
            <display:caption>选择角色[${title}]拥有的菜单</display:caption>
        </display:table>
    </div>
</s:form>
</body>
</html>
