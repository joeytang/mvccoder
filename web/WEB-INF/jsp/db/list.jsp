<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	$("#dbTable table tbody tr :checkbox").click(function(e){//执行默认checkbox行为后会再次出发tr的click时间，因此这里将默认行为反向
		e.stopPropagation();
		return true;
	});
	$("#dbTable table tbody tr").unbind().bind("mouseover",function(){
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
	$("#dbTable table th[sort]").mouseover(function(){
		$(this).addClass("hover-sort");
	}).mouseout(function(){
		$(this).removeClass("hover-sort");
	});
	$("#dbTable table th[sort]").click(function(){
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
		$("#dbSearcher #sortPropertyId").val(sort);
		$("#dbSearcher #sortOrderId").val(order);
		$("#dbTable table th span").remove();
		if(order == "desc"){
			$this.append(spanDesc);
		}else{
			$this.append(spanAsc);
		}
		search();
	});
});
</script>
<div id="dbTable">
	<table class="list-table" cellpadding="0" cellspacing="1">
		<thead>
			<tr title="点击表头进行排序">
				<th id="selectAll" onclick="checkAllBox(this);">全选</th>
				<th sort="name"  order="${sort.sortOrder}" >数据库名<c:if test="${sort != null && sort.sortProperty == 'name'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th>用户名</th>
				<th>密码</th>
				<th>数据库连接地址</th>
				<th>数据库驱动</th>
				<th>类型</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${ dbs}" var="db">
			<tr idVar="${db.id}">
				<td><input type="checkbox" value="${db.id}" /></td>
				<td>
				${db.name}
				</td>
				<td>
				${db.userName}
				</td>
				<td>
				${db.password}
				</td>
				<td>
				${db.url}
				</td>
				<td>
				${db.driver}
				</td>
				<td>
				${g:var("com.wanmei.domain.DbHelper","typeMap")[db.type]}
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div style="background-color: #d3eaef;text-align:right;padding-right:10px;" >
<c:if test="${!empty commonList && commonList.pageNum>1 }">
	<g:page commonList="${commonList}"  uri="${ctx}/db/list" target="#dbTable" pageNum="5" model="3" op="replace" />  
</c:if>
	</div>
</div>