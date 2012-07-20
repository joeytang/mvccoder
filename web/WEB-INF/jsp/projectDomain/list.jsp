<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	$("#projectDomainTable table tbody tr :checkbox").click(function(e){//执行默认checkbox行为后会再次出发tr的click时间，因此这里将默认行为反向
		e.stopPropagation();
		return true;
	});
	$("#projectDomainTable table tbody tr").unbind().bind("mouseover",function(){
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
	$("#projectDomainTable table th[sort]").mouseover(function(){
		$(this).addClass("hover-sort");
	}).mouseout(function(){
		$(this).removeClass("hover-sort");
	});
	$("#projectDomainTable table th[sort]").click(function(){
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
		$("#projectDomainSearcher #sortPropertyId").val(sort);
		$("#projectDomainSearcher #sortOrderId").val(order);
		$("#projectDomainTable table th span").remove();
		if(order == "desc"){
			$this.append(spanDesc);
		}else{
			$this.append(spanAsc);
		}
		search();
	});
});
</script>
<div id="projectDomainTable">
	<table class="list-table" cellpadding="0" cellspacing="1">
		<thead>
			<tr title="点击表头进行排序">
				<th id="selectAll" onclick="checkAllBox(this);">全选</th>
				<th>模块</th>
				<th>菜单排序</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${ projectDomains}" var="projectDomain">
			<tr idVar="${projectDomain.id}">
				<td><input type="checkbox" value="${projectDomain.id}" /></td>
				<td>
				<a href="javascript:void(0)"  onclick="viewDomain('${projectDomain.domain.idkey}')">
				${projectDomain.domain.name}--${projectDomain.domain.label}
				</a>
				</td>
				<td>
				${projectDomain.menuOrder}
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div style="background-color: #d3eaef;text-align:right;padding-right:10px;" >
<c:if test="${!empty commonList && commonList.pageNum>1 }">
	<g:page commonList="${commonList}"  uri="${ctx}/projectDomain/list" target="#projectDomainTable" pageNum="5" model="3" op="replace" />  
</c:if>
	</div>
</div>