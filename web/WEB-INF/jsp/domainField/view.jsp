<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
});
</script>
	<table class="view-table" cellpadding="0" cellspacing="1">
		<tbody>
			<tr> 
		      <td class="tdl">列信息:</td>
		      <td class="tdr" >
				<a href="javascript:void(0)"  onclick="viewField('${domainField.field.id}')">
				${domainField.field.name}
				</a>
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">是否可以为空:</td>
		      <td class="tdr" >
				<c:choose>
					<c:when test="${domainField.nullable}">
					是
					</c:when>
					<c:otherwise>
					否
					</c:otherwise>
				</c:choose>
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">是否在列表中显示:</td>
		      <td class="tdr" >
				<c:choose>
					<c:when test="${domainField.listable}">
					是
					</c:when>
					<c:otherwise>
					否
					</c:otherwise>
				</c:choose>
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">是否在修改中显示:</td>
		      <td class="tdr" >
				<c:choose>
					<c:when test="${domainField.editable}">
					是
					</c:when>
					<c:otherwise>
					否
					</c:otherwise>
				</c:choose>
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">是否在hbm文件中显示:</td>
		      <td class="tdr" >
				<c:choose>
					<c:when test="${domainField.hbmable}">
					是
					</c:when>
					<c:otherwise>
					否
					</c:otherwise>
				</c:choose>
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">是否在详情中显示:</td>
		      <td class="tdr" >
				<c:choose>
					<c:when test="${domainField.viewable}">
					是
					</c:when>
					<c:otherwise>
					否
					</c:otherwise>
				</c:choose>
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">是否在搜索条件中显示:</td>
		      <td class="tdr" >
				<c:choose>
					<c:when test="${domainField.searchable}">
					是
					</c:when>
					<c:otherwise>
					否
					</c:otherwise>
				</c:choose>
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">是否在列表中可排序:</td>
		      <td class="tdr" >
				<c:choose>
					<c:when test="${domainField.sortable}">
					是
					</c:when>
					<c:otherwise>
					否
					</c:otherwise>
				</c:choose>
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">列表中顺序:</td>
		      <td class="tdr" >
				${domainField.listOrder}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">修改中顺序:</td>
		      <td class="tdr" >
				${domainField.editOrder}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">详情中顺序:</td>
		      <td class="tdr" >
				${domainField.viewOrder}
		      </td>
		    </tr>
			<tr> 
		      <td class="tdl">搜索条件中顺序:</td>
		      <td class="tdr" >
				${domainField.searchOrder}
		      </td>
		    </tr>
		</tbody>
	</table>
