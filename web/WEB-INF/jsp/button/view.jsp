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
				${g:var("com.wanmei.domain.ButtonHelper","typeMap")[button.type]}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">按钮中文名:</td>
		      <td class="tdr" >
				${button.label}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">JS函数名:</td>
		      <td class="tdr" >
				${button.function}
		      </td>
		    </tr>
		</tbody>
	</table>
