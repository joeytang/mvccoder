<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
});
</script>
	<table class="view-table" cellpadding="0" cellspacing="1">
		<tbody>
				<tr> 
		      <td class="tdl">项目英文名:</td>
		      <td class="tdr" >
				${project.name}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">项目中文名:</td>
		      <td class="tdr" >
				${project.label}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">代码包组织:</td>
		      <td class="tdr" >
				${project.org}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">数据库表前缀:</td>
		      <td class="tdr" >
				${project.tablePre}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">代码导出路径:</td>
		      <td class="tdr" >
				${project.output}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">版本号:</td>
		      <td class="tdr" >
				${project.version}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">JDK版本:</td>
		      <td class="tdr" >
				${project.jdkVersion}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">是否具有tomcat插件:</td>
		      <td class="tdr" >
				<c:choose>
					<c:when test="${project.needTomcatPlug}">
					是
					</c:when>
					<c:otherwise>
					否
					</c:otherwise>
				</c:choose>
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">项目类型:</td>
		      <td class="tdr" >
				${g:var("com.wanmei.domain.ProjectHelper","proTypeMap")[project.proType]}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">代码类型:</td>
		      <td class="tdr" >
				${g:var("com.wanmei.domain.ProjectHelper","codeTypeMap")[project.codeType]}
		      </td>
		    </tr>
		</tbody>
	</table>
