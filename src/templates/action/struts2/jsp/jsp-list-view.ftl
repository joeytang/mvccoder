<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/admin/common/taglibs.jsp" %>
<html>
<head>
    <%@ include file="/admin/common/meta.jsp" %>

    <script type="text/javascript">
	    <#noparse>$(document).ready(function(){
	    	$.infoMessage("<g:msg/>");
	     });
    	function checkSelect(){
            if(!isAnyNamedBoxSelected(document.getElementById("queryform"),"ids")){
	    		$.info("至少选择一项！")
	            return false;
	    	}
	    	return true;
	    }
        function checkRemoveMore(){
           if(!checkSelect()){
           		return false;
           }
           if (confirm('你确认删除该信息吗？')) {
           		$("#queryform").attr("action","${ctx}</#noparse>/view/${domain.domainName?uncap_first}/removeMore.html");
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
<s:form id="queryform" method="post" action="list" namespace="/security/${domain.domainName?uncap_first}">
	<div id="filterDiv" style="text-align: center;">
        名称:
        <s:textfield name="name" maxLength="40"/>
        <input type="hidden" name="forwardpagename" id="forwardpagename" value="<#noparse>$</#noparse>{forwardpagename}" />
        <input type="hidden" name="<#noparse>$</#noparse>{forwardpagename}" id="<#noparse>$</#noparse>{forwardpagename}" />
        <input type="image" src="<c:url value="/admin/images/filter.gif"/>" class="nullBorder" onclick="document.getElementById('queryform').submit();"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="<c:url value="/security/${domain.domainName?uncap_first}/input.html"/>">添加</a>
    </div>
    <div id="tableDiv">
        <display:table name="${domain.domainName?uncap_first}s" class="simple" id="${domain.domainName?uncap_first}" pagesize="<#noparse>$</#noparse>{pageSize}" size="<#noparse>$</#noparse>{size}" requestURI="<#noparse>$</#noparse>{ctx}/security/${domain.domainName?uncap_first}/list.html" partialList="true">
            <display:column title="<input type='checkbox' name='checkall' id='checkall' onclick='checks()'>" class="td25">
                <input type="checkbox" name="ids" value="<#noparse>$</#noparse>{${domain.domainName?uncap_first}.${domain.idName}}" style="border:0px"/>
            </display:column>
            <#list domain.properties as p>
        	<#if (p.type.name == "boolean")>
        	<display:column title="${p.name}" >
        	<s:if test="#attr.${domain.domainName?uncap_first}.${p.name}">
        	是
        	</s:if>
        	<s:else>
        	否
        	</s:else>
        	</display:column>
        	<#elseif (p.type.name == "text")>
        	<display:column title="${p.name}">
            	<span title="<s:property value='#attr.${domain.domainName?uncap_first}.${p.name}'/>" style="word-break:break-all;font-family:arial;font-size:12px;font-weight:bold;color:#ABABAB;cursor:pointer;" >
            		<cs:substring value="#attr.${domain.domainName?uncap_first}.${p.name}" length="20" />
            	</span>
            </display:column>
        	<#elseif (p.type.name == "timestamp")>
        	<display:column property="${p.name}" title="${p.name}" format="{0,date,yyyy-MM-dd HH:mm:ss}" />
        	<#else>
        	</#if>
        	</#list>
            <display:column title="管理">
	            <a href="<c:url value="/security/${domain.domainName?uncap_first}/input.html?${domain.idName}=<#noparse>$</#noparse>{${domain.domainName?uncap_first}.${domain.idName}}" />">编辑</a> &nbsp;&nbsp;&nbsp;
		        <a href="<c:url value="/security/${domain.domainName?uncap_first}/remove.html?${domain.idName}=<#noparse>$</#noparse>{${domain.domainName?uncap_first}.${domain.idName}}" />" onclick="JavaScript:return confirm('确认删除？');">删除</a> &nbsp;&nbsp;&nbsp;
            </display:column>
            <display:caption>${domain.domainName?uncap_first}管理</display:caption>
        </display:table>
        <input type="button" name="but_1" class="nullBorder" value="批量删除" onclick="checkRemoveMore()" /> &nbsp;&nbsp;&nbsp;&nbsp;
    </div>
</s:form>
</body>
</html>
