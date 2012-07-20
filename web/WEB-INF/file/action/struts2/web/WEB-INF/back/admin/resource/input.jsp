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
    function check() {
    	if(!isStringLengthValidated(Trim($("#nameId").val()),1,20)){
            alert("资源名称不能为空,且不能大于20字符！");
            return false;
        }
        
    	if(!isStringLengthValidated(Trim($("#typeId").val()),1,40)){
            alert("资源类型不能为空,且不能大于40字符！");
            return false;
        }
        
    	if(!isStringLengthValidated(Trim($("#resStringId").val()),1,40)){
            alert("资源地址不能为空,且不能大于40字符！");
            return false;
        }
        
    	if(!isStringLengthValidated(Trim($("#descnId").val()),0,200)){
            alert("资源描述不能大于200字符！");
            return false;
        }
        document.getElementById("resourceSaveFormId").submit();
        return true;
    }
</script>

<body>
<div class="pageTitle">
    资源详情
</div>

<s:form action="save" namespace="/security/resource" id="resourceSaveFormId" name="resourceSaveForm" method="POST">
    <table class="border" width=90% cellSpacing=0 cellPadding=2 align="center">
        <tr>
            <td class="left" width="20%">
               名称
            </td>
            <td class="right">
                <s:hidden name="id"/>
                <s:textfield id="nameId" name="name" size="25"/>
                <label class="star">*</label>
            </td>
        </tr>
        <tr>
            <td class="left">
                类型
            </td>
            <td class="right">
           		 <select name="type" id="typeId" >
            		<option <c:if test="${resource.type == 'URL'}"> selected="selected"</c:if> value="URL">地址</option>
            		<option <c:if test="${resource.type == 'FUNCTION'}"> selected="selected"</c:if> value="FUNCTION">方法</option>
            		<option <c:if test="${resource.type == 'COMPONENT'}"> selected="selected"</c:if> value="COMPONENT">组件</option>
            	</select>
            </td>
        </tr>
        <tr>
            <td class="left">
               资源串
            </td>
            <td class="right">
                <s:textfield id="resStringId" name="resString" size="80"/>
                <label class="star">*</label>
            </td>
        </tr>
        <tr>
            <td class="left">
              描述
            </td>
            <td class="right">
                <s:textarea id="descnId" name="descn" cols="50" rows="6"/>
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
