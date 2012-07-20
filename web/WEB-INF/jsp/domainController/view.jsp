<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
});
</script>
	<table class="view-table" cellpadding="0" cellspacing="1">
		<tbody>
			<tr> 
		      <td class="tdl">Controller:</td>
		      <td class="tdr" >
				<a href="javascript:void(0)"  onclick="viewController('${domainController.controller.id}')">
				${domainController.controller.name}
				</a>
		      </td>
		    </tr>
				<tr> 
		      <td class="tdl">创建时间:</td>
		      <td class="tdr" >
				<fmt:formatDate value="${domainController.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
		      </td>
		    </tr>
		</tbody>
	</table>
