<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	$("#userTable table tbody tr :checkbox").click(function(e){//执行默认checkbox行为后会再次出发tr的click时间，因此这里将默认行为反向
		e.stopPropagation();
		return true;
	});
	$("#userTable table tbody tr").unbind().bind("mouseover",function(){
    	$(this).addClass("hover-tr");
    }).bind("mouseout",function(){
    	$(this).removeClass("hover-tr");
    }).bind("click",function(){
    	$(this).find(":checkbox").click();
    }).bind("dblclick",function(){
    	
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
<div id="userTable">
	<table class="list-table" cellpadding="0" cellspacing="1">
		<thead>
			<tr title="点击表头进行排序">
				<th id="selectAll" onclick="checkAllBox(this);">全选</th>
				<th sort="username"  order="${sort.sortOrder}" >账号<c:if test="${sort != null && sort.sortProperty == 'username'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th sort="password"  order="${sort.sortOrder}" >密码<c:if test="${sort != null && sort.sortProperty == 'password'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th sort="nickname"  order="${sort.sortOrder}" >名称<c:if test="${sort != null && sort.sortProperty == 'nickname'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th sort="role"  order="${sort.sortOrder}" >角色<c:if test="${sort != null && sort.sortProperty == 'role'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th>状态</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${ users}" var="user">
			<tr idVar="${user.id}">
				<td><input type="checkbox" value="${user.id}" /></td>
				<td>
				${user.username}
				</td>
				<td>
				${user.password}
				</td>
				<td>
				${user.nickname}
				</td>
				<td>
				${user.role}
				</td>
				<td>
				${user.status}
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div style="background-color: #d3eaef;text-align:right;padding-right:10px;" >
<c:if test="${!empty commonList && commonList.pageNum>1 }">
	<g:page commonList="${commonList}"  uri="${ctx}/user/list" target="#userTable" pageNum="5" model="3" op="replace" />  
</c:if>
	</div>
</div>