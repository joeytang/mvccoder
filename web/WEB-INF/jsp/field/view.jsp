<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
});
</script>
	<table class="view-table" cellpadding="0" cellspacing="1">
		<tbody>
				<tr> 
		      <td class="tdl">列英文名:</td>
		      <td class="tdr" >
				${field.name}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">列中文名:</td>
		      <td class="tdr" >
				${field.label}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">模块描述:</td>
		      <td class="tdr" >
				${field.description}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">字段类型:</td>
		      <td class="tdr" >
				${g:var("com.wanmei.domain.FieldHelper","typeMap")[field.type]}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">是否字典:</td>
		      <td class="tdr" >
		      <c:if test="${field.isDict}">是</c:if>
		      <c:if test="${!field.isDict}">否</c:if>
		      </td>
			<tr> 
		      <td class="tdl">对应表名:</td>
		      <td class="tdr" >
				${field.table}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">对应列名（或关联多时列名）:</td>
		      <td class="tdr" >
				${field.column}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">对多时列名(被关联的列):</td>
		      <td class="tdr" >
				${field.manyColumn}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">长度限制:</td>
		      <td class="tdr" >
				${field.length}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">关联对象名:</td>
		      <td class="tdr" >
				${field.entityName}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">关联对象包名:</td>
		      <td class="tdr" >
				${field.entityPackage}
		      </td>
		    </tr>
		</tbody>
	</table>
