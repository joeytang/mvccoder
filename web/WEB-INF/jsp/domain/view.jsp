<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
});
</script>
	<table class="view-table" cellpadding="0" cellspacing="1">
		<tbody>
			<tr> 
		      <td class="tdl">模块英文名:</td>
		      <td class="tdr" >
				${domain.name}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">模块中文名:</td>
		      <td class="tdr" >
				${domain.label}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">对应表名:</td>
		      <td class="tdr" >
				${domain.table}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">模块描述:</td>
		      <td class="tdr" >
				${domain.description}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">模块包名:</td>
		      <td class="tdr" >
				${domain.packageName}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">列表选框类型:</td>
		      <td class="tdr" >
				${g:var("com.wanmei.domain.DomainHelper","checkTypeMap")[domain.checkType]}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">禁用的Controller:</td>
		      <td class="tdr" >
				${domain.disabledControllers}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">是否为User模块:</td>
		      <td class="tdr" >
				<c:choose>
					<c:when test="${domain.isUser}">
					是
					</c:when>
					<c:otherwise>
					否
					</c:otherwise>
				</c:choose>
		      </td>
		    </tr>
		</tbody>
	</table>
