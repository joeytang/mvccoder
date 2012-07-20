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
            if(Trim(document.getElementById("name").value).length==0){
                alert("真实姓名不能为空！");
                return false;
            }
             if (Trim(document.getElementById("name").value).length >10) {
                 alert("真实姓名的字数不能超过10个字！");
                return false;
             }
            if(Trim(document.getElementById("loginid").value).length==0){
                alert("key名称不能为空！");
                return false;
            }
             if (Trim(document.getElementById("loginid").value).length >40) {
                 alert("key名称的字数不能超过20个字！");
                return false;
             }

            document.getElementById("userEditForm").submit();
            return true;
        }

    </script>
</head>
<body>
<div class="pageTitle">
    用户详情
</div>

<s:form action="save" namespace="/security/user" name="userEditForm" id="userEditForm">
    <div id="left" style="float: left;width: 100%">
        <table class="border" width=90% cellSpacing=0 cellPadding=2 align="center">
            <tr>
                <td class="left" width="20%">
                    真实姓名:
                </td>
                <td class="right">
                    <s:hidden name="id"/>
                    <s:textfield name="name" size="35" id="name" maxLength="10"/>
                    <label class="star">*</label>
                </td>
            </tr>
            <tr>
                <td class="left" width="20%">
                    key名称:
                </td>
                <td class="right">
                    <s:textfield name="loginid" size="35" id="loginid" maxLength="40"/>
                    <label class="star">*</label>
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