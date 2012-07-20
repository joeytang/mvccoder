<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
});
</script>
	<table class="view-table" cellpadding="0" cellspacing="1">
		<tbody>
			<tr> 
		      <td class="tdl">模块:</td>
		      <td class="tdr" >
				<a href="javascript:void(0)"  onclick="viewDomain('${projectDomain.domain.idkey}')">
				${projectDomain.domain.name}--${projectDomain.domain.label}
				</a>
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">菜单排序:</td>
		      <td class="tdr" >
				${projectDomain.menuOrder}
		      </td>
		    </tr>
		</tbody>
	</table>
