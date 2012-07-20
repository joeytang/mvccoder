<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/admin/common/taglibs.jsp" %>
<div class="ftitle">${domain.domainCnName}信息</div>
	<form id="inputForm" method="post" >
		<#list domain.properties as p>
    	<#if (p.type.name == "boolean")>
    	<div class="fitem">
			<label><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:</label>
			<input type="text" name="${p.name}" class="easyui-validatebox" <#if (!p.isOptional()) > required="true" validType="length[1,50]"<#else>validType="length[0,50]"</#if> invalidMessage="<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if><#if (!p.isOptional()) >不能为空,且</#if>不能大于50字符" />
		</div>
    	<#elseif (p.type.name == "text")>
    	<div class="fitem">
			<label><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:</label>
			<textarea name="${p.name}" class="easyui-validatebox" <#if (!p.isOptional()) > required="true" validType="length[1,250]"<#else>validType="length[0,50]"</#if> invalidMessage="<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if><#if (!p.isOptional()) >不能为空,且</#if>不能大于250字符" ></textarea>
		</div>
    	<th field="${p.name}" formatter="DataGridFun.clobFormater" width="20"><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if></th>
    	<#elseif (p.type.name == "timestamp")>
    	<div class="fitem">
			<label><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:</label>
			<input type="text" name="${p.name}" class="easyui-datetimebox" <#if (!p.isOptional()) > required="true"</#if> invalidMessage="<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if><#if (!p.isOptional()) >不能为空</#if>" />
		</div>
    	<#elseif (p.type.name == "date")>
    	<div class="fitem">
			<label><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:</label>
			<input type="text" name="${p.name}" class="easyui-datebox" <#if (!p.isOptional()) > required="true"</#if> invalidMessage="<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if><#if (!p.isOptional()) >不能为空</#if>" />
		</div>
    	<#elseif (p.type.name == "integer" || p.type.name == "long")>
    	<div class="fitem">
			<label><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:</label>
			<input type="text" name="${p.name}" class="easyui-numberbox" <#if (!p.isOptional()) > required="true"</#if> min="0" max="9999" invalidMessage="<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if><#if (!p.isOptional()) >不能为空,且</#if>四位以内有效地的正整数" />
		</div>
    	<#elseif (p.type.name == "double")>
    	<div class="fitem">
			<label><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:</label>
			<input type="text" name="${p.name}" class="easyui-numberbox" <#if (!p.isOptional()) > required="true"</#if> min="0" max="9999" precision="2" invalidMessage="<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if><#if (!p.isOptional()) >不能为空,且</#if>四位以内有效地的数字" />
		</div>
    	<#else>
    	<div class="fitem">
			<label><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:</label>
			<input type="text" name="${p.name}" class="easyui-validatebox" <#if (!p.isOptional()) > required="true" validType="length[1,50]"<#else>validType="length[0,50]"</#if> invalidMessage="<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if><#if (!p.isOptional()) >不能为空,且</#if>不能大于50字符" />
		</div>
    	</#if>
    	</#list>
	</form>