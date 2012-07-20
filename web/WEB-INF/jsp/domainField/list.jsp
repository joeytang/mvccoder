<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	$("#domainFieldTable table tbody tr :checkbox").click(function(e){//执行默认checkbox行为后会再次出发tr的click时间，因此这里将默认行为反向
		e.stopPropagation();
		return true;
	});
	$("#domainFieldTable table tbody tr").unbind().bind("mouseover",function(){
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
	$("#domainFieldTable table th[sort]").mouseover(function(){
		$(this).addClass("hover-sort");
	}).mouseout(function(){
		$(this).removeClass("hover-sort");
	});
	$("#domainFieldTable table th[sort]").click(function(){
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
		$("#domainFieldTable table th span").remove();
		if(order == "desc"){
			$this.append(spanDesc);
		}else{
			$this.append(spanAsc);
		}
		if($("#domainFieldSearcher form").length != 0){
			$("#domainFieldSearcher #sortPropertyId").val(sort);
			$("#domainFieldSearcher #sortOrderId").val(order);
			search();
		}else{
			$("#domainFieldTable").renderUrl({
				url:"${ctx}/domainField/list/${id}",
				params : {'sortProperty':sort,'sortOrder':order},
				op : "replace"
			});
		}
	});
});
</script>
<div id="domainFieldTable">
	<table class="list-table" cellpadding="0" cellspacing="1">
		<thead>
			<tr title="点击表头进行排序">
				<th id="selectAll" onclick="checkAllBox(this);">全选</th>
				<th >列信息</th>
				<th >列类型</th>
				<th >关系维护</th>
				<th>是否可以为空</th>
				<th sort="listable"  order="${sort.sortOrder}" >是否在列表中显示<c:if test="${sort != null && sort.sortProperty == 'listable'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th sort="editable"  order="${sort.sortOrder}" >是否在修改中显示<c:if test="${sort != null && sort.sortProperty == 'editable'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th sort="hbmable"  order="${sort.sortOrder}" >是否在hbm文件中显示<c:if test="${sort != null && sort.sortProperty == 'hbmable'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th sort="viewable"  order="${sort.sortOrder}" >是否在详情中显示<c:if test="${sort != null && sort.sortProperty == 'viewable'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th sort="searchable"  order="${sort.sortOrder}" >是否在搜索条件中显示<c:if test="${sort != null && sort.sortProperty == 'searchable'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th sort="sortable"  order="${sort.sortOrder}" >是否在列表中可排序<c:if test="${sort != null && sort.sortProperty == 'sortable'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th sort="listOrder"  order="${sort.sortOrder}" >列表中顺序<c:if test="${sort != null && sort.sortProperty == 'listOrder'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th sort="editOrder"  order="${sort.sortOrder}" >修改中顺序<c:if test="${sort != null && sort.sortProperty == 'editOrder'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th sort="viewOrder"  order="${sort.sortOrder}" >详情中顺序<c:if test="${sort != null && sort.sortProperty == 'viewOrder'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th sort="searchOrder"  order="${sort.sortOrder}" >搜索条件中顺序<c:if test="${sort != null && sort.sortProperty == 'searchOrder'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${ domainFields}" var="domainField">
			<tr idVar="${domainField.id}">
				<td><input type="checkbox" value="${domainField.id}" /></td>
				<td>
				<a href="javascript:void(0)"  onclick="viewField('${domainField.field.id}')">
				${domainField.field.name}
				</a>
				</td>
				<td>
				${g:var("com.wanmei.domain.FieldHelper","typeMap")[domainField.field.type]}
				</td>
				<td>
				${g:var("com.wanmei.domain.FieldHelper","relationTypeMap")[domainField.relationType]}
				</td>
				<td>
				${domainField.nullable}
				</td>
				<td>
				${domainField.listable}
				</td>
				<td>
				${domainField.editable}
				</td>
				<td>
				${domainField.hbmable}
				</td>
				<td>
				${domainField.viewable}
				</td>
				<td>
				${domainField.searchable}
				</td>
				<td>
				${domainField.sortable}
				</td>
				<td>
				${domainField.listOrder}
				</td>
				<td>
				${domainField.editOrder}
				</td>
				<td>
				${domainField.viewOrder}
				</td>
				<td>
				${domainField.searchOrder}
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div style="background-color: #d3eaef;text-align:right;padding-right:10px;" >
<c:if test="${!empty commonList && commonList.pageNum>1 }">
	<g:page commonList="${commonList}"  uri="${ctx}/domainField/list/${id}" target="#domainFieldTable" pageNum="5" model="3" op="replace" />  
</c:if>
	</div>
</div>