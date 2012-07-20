<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	$("#projectTable table tbody tr :checkbox").click(function(e){//执行默认checkbox行为后会再次出发tr的click时间，因此这里将默认行为反向
		e.stopPropagation();
		return true;
	});
	$("#projectTable table tbody tr").unbind().bind("mouseover",function(){
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
	$("#projectTable table th[sort]").mouseover(function(){
		$(this).addClass("hover-sort");
	}).mouseout(function(){
		$(this).removeClass("hover-sort");
	});
	$("#projectTable table th[sort]").click(function(){
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
		$("#projectSearcher #sortPropertyId").val(sort);
		$("#projectSearcher #sortOrderId").val(order);
		$("#projectTable table th span").remove();
		if(order == "desc"){
			$this.append(spanDesc);
		}else{
			$this.append(spanAsc);
		}
		search();
	});
});
</script>
<div id="projectTable">
	<table class="list-table" cellpadding="0" cellspacing="1">
		<thead>
			<tr title="点击表头进行排序">
				<th id="selectAll" onclick="checkAllBox(this);">全选</th>
				<th sort="name"  order="${sort.sortOrder}" >项目英文名<c:if test="${sort != null && sort.sortProperty == 'name'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th sort="label"  order="${sort.sortOrder}" >项目中文名<c:if test="${sort != null && sort.sortProperty == 'label'}"><span class="icon-${sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<th>代码包组织</th>
				<th>数据库表前缀</th>
				<th>代码导出路径</th>
				<th>版本号</th>
				<th>JDK版本</th>
				<th>是否具有tomcat插件</th>
				<th>项目类型</th>
				<th>代码类型</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${ projects}" var="project">
			<tr idVar="${project.id}">
				<td><input type="checkbox" value="${project.id}" /></td>
				<td>
				${project.name}
				</td>
				<td>
				${project.label}
				</td>
				<td>
				${project.org}
				</td>
				<td>
				${project.tablePre}
				</td>
				<td>
				${project.output}
				</td>
				<td>
				${project.version}
				</td>
				<td>
				${project.jdkVersion}
				</td>
				<td>
				${project.needTomcatPlug}
				</td>
				<td>
				${g:var("com.wanmei.domain.ProjectHelper","proTypeMap")[project.proType]}
				</td>
				<td>
				${g:var("com.wanmei.domain.ProjectHelper","codeTypeMap")[project.codeType]}
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div style="background-color: #d3eaef;text-align:right;padding-right:10px;" >
<c:if test="${!empty commonList && commonList.pageNum>1 }">
	<g:page commonList="${commonList}"  uri="${ctx}/project/list" target="#projectTable" pageNum="5" model="3" op="replace" />  
</c:if>
	</div>
</div>