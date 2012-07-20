<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
});
</script>
	<table class="view-table" cellpadding="0" cellspacing="1">
		<tbody>
			<tr> 
		      <td class="tdl">按钮:</td>
		      <td class="tdr" >
				<a href="javascript:void(0)"  onclick="viewButton('${domainButton.button.id}')">
				${domainButton.button.label}
				</a>
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">创建时间:</td>
		      <td class="tdr" >
				<fmt:formatDate value="${domainButton.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
		      </td>
		    </tr>
		</tbody>
	</table>
