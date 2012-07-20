<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/admin/common/taglibs.jsp" %>
<html>
<head>
    <%@ include file="/admin/common/meta.jsp" %>
    <script language="javascript">
	     <#noparse>$(document).ready(function(){
		    $.infoMessage("<g:msg/>");
	     });</#noparse>
        function check() {
        <#list domain.properties as p>
        <#if (p.type.name == "integer")>
        	<#if (p.isOptional()) >
            if(<#noparse>$</#noparse>("#${p.name}Id").val() != ""){
            	if(!/^[1-9]+(\d)*$/.test(<#noparse>$</#noparse>("#${p.name}Id").val())){
            		$.info("请输入正整数");
            		return false;
            	}else{
            		var num = eval($("#${p.name}Id").val());
            		if(num < 1 || num > 9999){
            			$.info("请输入四位以内有效地的正整数");
            			return false;
            		}
            	}
            }
			<#else>
            if(!isStringLengthValidated(Trim(<#noparse>$</#noparse>("#${p.name}Id").val()),1,4)){
                $.info("<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>不能为空,且不能大于4字符！");
                return false;
            }else{
            	if(!/^[1-9]+(\d)*$/.test(<#noparse>$</#noparse>("#${p.name}Id").val())){
            		$.info("请输入正整数");
            		return false;
            	}else{
            		var num = eval($("#${p.name}Id").val());
            		if(num < 1 || num > 9999){
            			$.info("请输入四位以内有效地的正整数");
            			return false;
            		}
            	}
            }
            </#if>
        <#elseif (p.type.name == "text")>
        
        	<#if (p.isOptional()) >
            if(!isStringLengthValidated(Trim(<#noparse>$</#noparse>("#${p.name}Id").val()),0,200)){
                $.info("<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>不能大于200字符！");
                return false;
            }
			<#else>
	        if(!isStringLengthValidated(Trim(<#noparse>$</#noparse>("#${p.name}Id").val()),1,200)){
                $.info("<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>不能为空,且不能大于200字符！");
                return false;
            }
            </#if>
        <#elseif (p.type.name == "boolean")>
        	<#if (!p.isOptional()) >
            if(<#noparse>$</#noparse>("input[id^='${p.name}_']:checked").length == 0){
            	$.info("<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>必须选择！");
                return false;
            }
			<#else>
            </#if>
		<#else>
        	<#if (p.isOptional()) >
            if(!isStringLengthValidated(Trim(<#noparse>$</#noparse>("#${p.name}Id").val()),0,50)){
                $.info("<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>不能大于50字符！");
                return false;
            }
			<#else>
	        if(!isStringLengthValidated(Trim(<#noparse>$</#noparse>("#${p.name}Id").val()),1,50)){
                $.info("<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>不能为空,且不能大于50字符！");
                return false;
            }
            </#if>
		</#if>
        </#list>
            <#noparse>$</#noparse>("#${domain.domainName?uncap_first}EditForm").submit();
            return true;
        }
    </script>
</head>
<body>
<div class="pageTitle">
    新建/修改${domain.domainCnName}信息
</div>

<s:form action="save" namespace="/view/${domain.domainName?uncap_first}" id="${domain.domainName?uncap_first}EditForm" name="${domain.domainName?uncap_first}EditForm" >
    <div id="left" style="float: left;width: 100%">
    <s:hidden name="${domain.idName}"/>
         <table class="border" width=90% cellSpacing=0 cellPadding=2 align="center">
			<#list domain.properties as p>
        <#if (p.type.name == "integer")>
        	<tr>
                <td class="left" width="20%">
                  <#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:
                </td>
                <td class="right">
                    <s:textfield name="${p.name}" size="30" id="${p.name}Id" maxlength="4"/>
                    <#if (!p.isOptional()) >
                    <label class="star">*</label>
            		</#if>
                </td>
            </tr>
        <#elseif (p.type.name == "text")>
        	<tr>
                <td class="left" width="20%">
                  <#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:
                </td>
                <td class="right">
                	<s:textarea name="${p.name}"  id="${p.name}Id" cols="32" rows="5" wrap="soft"/>
                    <#if (!p.isOptional()) >
                    <label class="star">*</label>
            		</#if>
                </td>
            </tr>
        <#elseif (p.type.name == "timestamp")>
        	<tr>
                <td class="left" width="20%">
                  <#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:
                </td>
                <td class="right">
                <s:textfield name="${p.name}" size="30" id="${p.name}Id" maxlength="50" cssClass="Wdate" cssStyle="width:180px;height:20px;" onfocus="javascript:new WdatePicker(this,'%Y-%M-%D %h:%m:%s',true);" value="%{@${project.org}.util.DateTimeUtil@forMatDate(${domain.domainName?uncap_first}.${p.name})}"/>
                    <#if (!p.isOptional()) >
                    <label class="star">*</label>
            		</#if>
                </td>
            </tr>
        <#elseif (p.type.name == "boolean")>
        	<tr>
                <td class="left" width="20%">
                  <#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:
                </td>
                <td class="right">
                	<s:radio list="<#noparse>#{true:'是',false:'否'</#noparse>}" name="${p.name}" id="${p.name}_"/>
                    <#if (!p.isOptional()) >
                    <label class="star">*</label>
            		</#if>
                </td>
            </tr>
		<#else>
        	<tr>
                <td class="left" width="20%">
                  <#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:
                </td>
                <td class="right">
                    <s:textfield name="${p.name}" size="30" id="${p.name}Id" maxlength="50"/>
                    <#if (!p.isOptional()) >
                    <label class="star">*</label>
            		</#if>
                </td>
            </tr>
		</#if>
        </#list>
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