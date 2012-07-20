<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
});
</script>
	<table class="view-table" cellpadding="0" cellspacing="1">
		<tbody>
				<tr> 
		      <td class="tdl">方法名:</td>
		      <td class="tdr" >
				${controller.name}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">类型:</td>
		      <td class="tdr" >
				${g:var("com.wanmei.domain.ControllerHelper","typeMap")[controller.type]}
		      </td>
		    </tr>
		</tbody>
	</table>
