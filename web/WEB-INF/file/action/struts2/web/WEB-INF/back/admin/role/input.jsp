<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/admin/common/taglibs.jsp" %>

<html>
<head>
    <%@ include file="/admin/common/meta.jsp" %>
    <link href="<c:url value="/admin/styles/admin/admin.css"/>" type=text/css rel=stylesheet>
    <script type="text/javascript"  src="<c:url value="/admin/js/checkForm.js"/>"></script>
     <script language="javascript">
     $(document).ready(function(){
    	 alertMessage("<g:msg/>");
    	});
        function check() {
            if(!isStringLengthValidated(Trim($("#title").val()),1,35)){
                alert("角色名称不能为空,且不能大于25字符！");
                return false;
            }

            if (Trim(document.getElementById("descn").value).length >100) {
                 alert("描述不能超过100个字！");
                return false;
             }
            document.getElementById("roleSaveForm").submit();
            return true;
        }
    </script>
</head>

<body>
<div class="pageTitle">
    角色详情
</div>

<s:form name="roleSaveForm" action="save" namespace="/security/role" method="POST" id="roleSaveForm">
    <div id="left" style="float: left;width: 100%">
        <table class="border" width=90% cellSpacing=0 cellPadding=2 align="center">
            <tr>
                <td class="left" width="20%">
                    角色名称:
                </td>
                <td class="right">
                    <s:hidden name="id"/>
                    <s:hidden name="name"/>
                    <s:textfield name="title" size="35" id="title" maxLength="40"/>
                    <label class="star">*</label>
                </td>
            </tr>
            <tr>
                <td class="left">
                    描述:
                </td>
                <td class="right">
                    
                    <s:textarea name="descn" cols="50" rows="6" id="descn" />
                </td>
            </tr>
            <tr>
                <td colspan="2" class="bottom">
                    <input type="button" onclick="check()" class="submitButton" value="保存" style="margin-right:60px"/>
                </td>
            </tr>
        </table>
    </div>
</s:form>
</body>
</html>
