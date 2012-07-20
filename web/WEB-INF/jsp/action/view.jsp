<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
});
</script>
	<table class="view-table" cellpadding="0" cellspacing="1">
		<tbody>
				<tr> 
		      <td class="tdl">类型:</td>
		      <td class="tdr" >
				${g:var("com.wanmei.domain.ActionHelper","typeMap")[action.type]}
		      </td>
		    </tr>
		</tbody>
	</table>
