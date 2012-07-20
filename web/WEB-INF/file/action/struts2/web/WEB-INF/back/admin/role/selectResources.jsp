<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/admin/common/taglibs.jsp" %>
<html>
<head>
    <%@ include file="/admin/common/meta.jsp" %>
    <script type="text/javascript">
	    function checkSelect(){
	           if(!isAnyNamedBoxSelected(document.getElementById("selectResourceForm"),"ids")){
	    		alert("至少选择一项！")
	            return false;
	    	}
	    	return true;
	    }
        function addRoleResourceAuth(){
            if (confirm("确定要授权?")){
                if (!checkSelect()){
                    alert('请至少选择一资源！');
                    return;
                }
                document.getElementById("needAuth").value  = 'true';
                document.getElementById('selectResourceForm').action = '${ctx}/security/role/authResources.html';
                document.getElementById('selectResourceForm').submit();
            }
        }

        function removeRoleResourceAuth(){
            if (confirm("确定要取消授权?")){
                if (!checkSelect()){
                    alert('请至少选择一资源！');
                    return;
                }
                document.getElementById("needAuth").value = 'false';
                document.getElementById('selectResourceForm').action = '${ctx}/security/role/authResources.html';
                document.getElementById('selectResourceForm').submit();
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
<s:form id="selectResourceForm" name="selectResourceForm" method="post" action="selectResources" namespace="/security/role">
    <%--<div class="pageTitle" align="center"><b><h3>选择角色[${title}]拥有的资源</h3></b></div>--%>
    <s:actionmessage/>
    <div id="filterDiv" style="text-align: center;">
        <s:hidden name="needAuth" id="needAuth"/>
        <s:hidden name="id"/>
        授权：
        <s:select list="#{'0':'未授权','1':'已授权'}"
                  name="searchAuthorize"
                  value="%{searchAuthorize}"
                  headerKey=""
                  headerValue="所有"/>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="image" src="<c:url value="/admin/images/filter.gif"/>" class="nullBorder" onclick="document.getElementById('selectResourceForm').submit();"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="<c:url value="/security/role/list.html"/>">返回</a>&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="javascript:addRoleResourceAuth();">授权</a>&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="javascript:removeRoleResourceAuth();">撤销授权</a>
</div>
    <div id="tableDiv">
            <display:table name="selectResources" class="simple" id="resource">
            <display:column title="<input type='checkbox' name='checkall' id='checkall' onclick='checks()'>" class="td25">
                <input type="checkbox" id="ids" name="ids" value="${resource.id}" style="border:0px"/>
            </display:column>
            <display:column property="name" title="资源名称"/>
            <display:column property="type" title="资源类型"/>
            <display:column property="resString" title="资源串"/>
            <display:column  title="授权" style="width: 26px;text-align: center">
                  <c:choose>
                            <c:when test="${resource.authorize=='1'}">
                                <label style="color:red;">是</label>
                            </c:when>
                            <c:otherwise>
                                <label style="color:green;">否</label>
                            </c:otherwise>
                        </c:choose>
            </display:column>
            <display:caption>选择角色[${title}]拥有的资源</display:caption>
        </display:table>
    </div>
</s:form>
</body>
</html>
