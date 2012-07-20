<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
});
</script>
	<table class="view-table" cellpadding="0" cellspacing="1">
		<tbody>
				<tr> 
		      <td class="tdl">账号:</td>
		      <td class="tdr" >
				${user.username}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">密码:</td>
		      <td class="tdr" >
				${user.password}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">名称:</td>
		      <td class="tdr" >
				${user.nickname}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">角色:</td>
		      <td class="tdr" >
				${user.role}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">状态:</td>
		      <td class="tdr" >
				${user.status}
		      </td>
		    </tr>
		</tbody>
	</table>
