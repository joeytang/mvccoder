<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	$("#userTable table tbody tr").unbind().bind("mouseover",function(){
    	$(this).addClass("hover-tr");
    }).bind("mouseout",function(){
    	$(this).removeClass("hover-tr");
    }).bind("click",function(){
	    $(this).find(":checkbox").removeAttr("checked");
    }).bind("dblclick",function(){
    	$(this).find(":checkbox").attr("checked","checked");
    	view($(this).find(":checkbox").val());
    });
    var spanAsc = $('<span class="icon-ascsort">&nbsp;</span>');
	var spanDesc = $('<span class="icon-descsort">&nbsp;</span>');
	$("#userTable table th[sort]").mouseover(function(){
		$(this).addClass("hover-sort");
	}).mouseout(function(){
		$(this).removeClass("hover-sort");
	});
	$("#userTable table th[sort]").click(function(){
		var $this =  $(this);
		var sort = $this.attr("sort");
		var order = $this.attr("order");
		if(!sort){
			return false;
		}
		if(!order){
			order = "desc";
		}else {
			order = (order == "desc"?"asc":"desc");
		}
		$("#userSearcher #sortPropertyId").val(sort);
		$("#userSearcher #sortOrderId").val(order);
		$("#userTable table th span").remove();
		if(order == "desc"){
			$this.append(spanDesc);
		}else{
			$this.append(spanAsc);
		}
		search();
	});
});
</script>
	<table class="list-table" cellpadding="0" cellspacing="1">
		<thead>
			<tr>
				<th id="selectAll" onclick="checkAllBox(this);">全选</th>
				<th sort="account"  order="<#noparse>$</#noparse>{sort.sortOrder}">账号<c:if test="<#noparse>$</#noparse>{sort != null && sort.sortProperty == 'account'}"><span class="icon-<#noparse>$</#noparse>{sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th>密码</th>
				<th>中文名</th>
				<th sort="role"  order="<#noparse>$</#noparse>{sort.sortOrder}">角色<c:if test="<#noparse>$</#noparse>{sort != null && sort.sortProperty == 'role'}"><span class="icon-<#noparse>$</#noparse>{sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th sort="createTime"  order="<#noparse>$</#noparse>{sort.sortOrder}">创建时间<c:if test="<#noparse>$</#noparse>{sort != null && sort.sortProperty == 'createTime'}"><span class="icon-<#noparse>$</#noparse>{sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th>状态</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="<#noparse>$</#noparse>{ users}" var="user">
			<tr>
				<td><input type="checkbox" value="<#noparse>$</#noparse>{user.id}" /></td>
				<td>				<#noparse>$</#noparse>{user.account}
				</td>
				<td>				<#noparse>$</#noparse>{user.password}
				</td>
				<td>				<#noparse>$</#noparse>{user.userName}
				</td>
				<td>				<#noparse>$</#noparse>{g:var("${project.org}.domain.helper.UserHelper","roleMap")[user.role]}
				</td>
				<td>				<fmt:formatDate value="<#noparse>$</#noparse>{user.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>				<c:choose><c:when test="<#noparse>$</#noparse>{user.status == 0}">正常</c:when><c:otherwise>被禁用</c:otherwise></c:choose>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div style="background-color: #d3eaef;text-align:right;" >
<c:if test="<#noparse>$</#noparse>{!empty commonList && commonList.pageNum>1 }">
	<g:page commonList="<#noparse>$</#noparse>{commonList}"  uri="<#noparse>$</#noparse>{ctx}/user/list" target="#userTable" pageNum="5" model="11"/>  
</c:if>
	</div>
