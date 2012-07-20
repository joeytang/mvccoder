<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/admin/common/taglibs.jsp" %>

<html>
<head>
    <%@ include file="/admin/common/meta.jsp" %>
    <link href="<c:url value="/admin/styles/admin/admin.css"/>" type=text/css rel=stylesheet>
    <script type="text/javascript"  src="<c:url value="/admin/js/checkForm.js"/>"></script>
    <script type="text/javascript"  src="<c:url value="/admin/js/jquery-1.2.2.pack.js"/>"></script>
</head>

<script language="javascript">
	$(document).ready(function(){
		alertMessage("<g:msg/>");
     });
    function check() {
    	if(!isStringLengthValidated(Trim($("#nameId").val()),1,25)){
            alert("标示不能为空,且不能大于25字符！");
            return false;
        }
        
    	if(!isStringLengthValidated(Trim($("#titleId").val()),1,25)){
            alert("名称不能为空,且不能大于25字符！");
            return false;
        }
    	if(!isStringLengthValidated(Trim($("#locationId").val()),0,80)){
            alert("资源串不能大于80字符！");
            return false;
        }
        
    	if(!isStringLengthValidated(Trim($("#descriptionId").val()),0,200)){
            alert("描述不能大于200字符！");
            return false;
        }
        document.getElementById("menuSaveFormId").submit();
        return true;
    }
</script>

<body>
<div class="pageTitle">
    资源详情
</div>

<s:form action="save" namespace="/security/menu" id="menuSaveFormId" name="menuSaveForm" method="POST">
   		<s:hidden name="parentMenuItem.id"/>
    <table class="border" width=90% cellSpacing=0 cellPadding=2 align="center">
        <tr>
            <td class="left" width="20%">
               标示
            </td>
            <td class="right">
                <s:hidden name="id"/>
                <s:textfield id="nameId" name="name" size="25"/>
                <label class="star">*</label>
            </td>
        </tr>
        <tr>
            <td class="left" width="20%">
               名称
            </td>
            <td class="right">
                <s:textfield id="titleId" name="title" size="25"/>
                <label class="star">*</label>
            </td>
        </tr>
        <tr>
            <td class="left">
               资源串
            </td>
            <td class="right">
                <s:textfield id="locationId" name="location" size="80"/>
            </td>
        </tr>
        <tr>
            <td class="left">
              描述
            </td>
            <td class="right">
                <s:textarea id="descriptionId" name="description" cols="50" rows="6"/>
            </td>
        </tr>
        <tr>
           <td colspan="2" class="bottom">
                <input type="button" onclick="check()" class="submitButton" value="保存" style="margin-right:60px"/>
            </td>
        </tr>
    </table>
</s:form>
</body>
</html>
