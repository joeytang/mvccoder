<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	$("#fieldTable table tbody tr :checkbox").click(function(e){//执行默认checkbox行为后会再次出发tr的click时间，因此这里将默认行为反向
		e.stopPropagation();
		return true;
	});
	$("#fieldTable table tbody tr").unbind().bind("mouseover",function(){
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
	$("#fieldTable table th[sort]").mouseover(function(){
		$(this).addClass("hover-sort");
	}).mouseout(function(){
		$(this).removeClass("hover-sort");
	});
	$("#fieldTable table th[sort]").click(function(){
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
		$("#fieldSearcher #sortPropertyId").val(sort);
		$("#fieldSearcher #sortOrderId").val(order);
		$("#fieldTable table th span").remove();
		if(order == "desc"){
			$this.append(spanDesc);
		}else{
			$this.append(spanAsc);
		}
		search();
	});
});
</script>
<div id="fieldTable">
	<table class="list-table" cellpadding="0" cellspacing="1">
		<thead>
			<tr title="点击表头进行排序">
				<th id="selectAll" onclick="checkAllBox(this);">全选</th>
				<th sort="name"  order="${sort.sortOrder}" >列英文名<c:if test="${sort != null && sort.sortProperty == 'name'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th sort="label"  order="${sort.sortOrder}" >列中文名<c:if test="${sort != null && sort.sortProperty == 'label'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th>模块描述</th>
				<th>字段类型</th>
				<th>是否字典</th>
				<th>对应表名</th>
				<th>对应列名（或关联多时列名）</th>
				<th>对多时列名(被关联的列)</th>
				<th>长度限制</th>
				<th>关联对象名</th>
				<th>关联对象包名</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${ fields}" var="field">
			<tr idVar="${field.id}">
				<td><input type="checkbox" value="${field.id}" /></td>
				<td>
				${field.name}
				</td>
				<td>
				${field.label}
				</td>
				<td>
				${field.description}
				</td>
				<td>
				${g:var("com.wanmei.domain.FieldHelper","typeMap")[field.type]}
				</td>
				<td>
				<c:if test="${field.isDict}">是</c:if>
		      	<c:if test="${!field.isDict}">否</c:if>
				</td>
				<td>
				${field.table}
				</td>
				<td>
				${field.column}
				</td>
				<td>
				${field.manyColumn}
				</td>
				<td>
				${field.length}
				</td>
				<td>
				${field.entityName}
				</td>
				<td>
				${field.entityPackage}
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div style="background-color: #d3eaef;text-align:right;padding-right:10px;" >
<c:if test="${!empty commonList && commonList.pageNum>1 }">
	<g:page commonList="${commonList}"  uri="${ctx}/field/list" target="#fieldTable" pageNum="5" model="3" op="replace" />  
</c:if>
	</div>
</div>