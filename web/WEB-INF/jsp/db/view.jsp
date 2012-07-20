<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
});
</script>
	<table class="view-table" cellpadding="0" cellspacing="1">
		<tbody>
				<tr> 
		      <td class="tdl">数据库名:</td>
		      <td class="tdr" >
				${db.name}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">用户名:</td>
		      <td class="tdr" >
				${db.userName}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">密码:</td>
		      <td class="tdr" >
				${db.password}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">数据库连接地址:</td>
		      <td class="tdr" >
				${db.url}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">数据库驱动:</td>
		      <td class="tdr" >
				${db.driver}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">类型:</td>
		      <td class="tdr" >
				${g:var("com.wanmei.domain.DbHelper","typeMap")[db.type]}
		      </td>
		    </tr>
		</tbody>
	</table>
