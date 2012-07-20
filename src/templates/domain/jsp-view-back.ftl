<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
});
</script>
	<table class="view-table" cellpadding="0" cellspacing="1">
		<tbody>
	<#list domain.viewSortField as f>
			<tr> 
		      <td class="tdl">${f.label}:</td>
		      <td class="tdr" >
		      	<#if f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE>
				<a href="javascript:void(0)"  onclick="view${project.domainMap[f.entityName].name}('<#noparse>$</#noparse>{${domain.lowerFirstName}.${f.name}.${project.domainMap[f.entityName].id.name}}')">
				<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}.${f.many2OneName}}
				</a>
				<#elseif f.isDict>
				<#noparse>$</#noparse>{g:var("${domain.packageName}.helper.${domain.name}Helper","${f.name}Map")[${domain.lowerFirstName}.${f.name}]}
				<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_DATE)>
				<fmt:formatDate value="<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}<#noparse>}</#noparse>" pattern="yyyy-MM-dd"/>
				<#elseif f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_DATETIME>
				<fmt:formatDate value="<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}<#noparse>}</#noparse>" pattern="yyyy-MM-dd HH:mm:ss"/>
				<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_FILE)>
				
				<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_BOOLEAN)>	
				<c:choose>
					<c:when test="<#noparse>$</#noparse>{${domain.lowerFirstName}.${f.name}}">
					是
					</c:when>
					<c:otherwise>
					否
					</c:otherwise>
				</c:choose>
				<#else>
				<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}<#noparse>}</#noparse>
				</#if>
		      </td>
		    </tr>
	</#list>
		</tbody>
	</table>
