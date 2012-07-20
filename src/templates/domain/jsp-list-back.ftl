<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
<#noparse>$(document).ready(function(){</#noparse>
	$("#<#if domainMany??>${domainMany.lowerFirstName}${domainManyOther.name}<#else>${domain.lowerFirstName}</#if>Table table tbody tr .checkTd :input").click(function(e){//执行默认checkbox行为阻止事件传播
		e.stopPropagation();
	});
	$("#<#if domainMany??>${domainMany.lowerFirstName}${domainManyOther.name}<#else>${domain.lowerFirstName}</#if>Table table tbody tr").unbind().hover(
		function () {
			$(this).addClass("hover-tr");
		},function () {
			$(this).removeClass("hover-tr");
		}
	).bind("click",function(){
		$(this).find(".checkTd :input").click();
    }).bind("dblclick",function(){
    	view($(this).find(".checkTd :input").val());
    });
	var spanAsc = $('<span class="icon-ascsort">&nbsp;</span>');
	var spanDesc = $('<span class="icon-descsort">&nbsp;</span>');
	$("#<#if domainMany??>${domainMany.lowerFirstName}${domainManyOther.name}<#else>${domain.lowerFirstName}</#if>Table table th[sort]").mouseover(function(){
		$(this).addClass("hover-sort");
	}).mouseout(function(){
		$(this).removeClass("hover-sort");
	});
	$("#<#if domainMany??>${domainMany.lowerFirstName}${domainManyOther.name}<#else>${domain.lowerFirstName}</#if>Table table th[sort]").click(function(){
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
		$("#<#if domainMany??>${domainMany.lowerFirstName}${domainManyOther.name}<#else>${domain.lowerFirstName}</#if>Searcher #sortPropertyId").val(sort);
		$("#<#if domainMany??>${domainMany.lowerFirstName}${domainManyOther.name}<#else>${domain.lowerFirstName}</#if>Searcher #sortOrderId").val(order);
		$("#<#if domainMany??>${domainMany.lowerFirstName}${domainManyOther.name}<#else>${domain.lowerFirstName}</#if>Table table th span").remove();
		if(order == "desc"){
			$this.append(spanDesc);
		}else{
			$this.append(spanAsc);
		}
		if($("#<#if domainMany??>${domainMany.lowerFirstName}${domainManyOther.name}<#else>${domain.lowerFirstName}</#if>Searcher form").length != 0){
			$("#<#if domainMany??>${domainMany.lowerFirstName}${domainManyOther.name}<#else>${domain.lowerFirstName}</#if>Searcher #sortPropertyId").val(sort);
			$("#<#if domainMany??>${domainMany.lowerFirstName}${domainManyOther.name}<#else>${domain.lowerFirstName}</#if>Searcher #sortOrderId").val(order);
			search();
		}else{
			$("#<#if domainMany??>${domainMany.lowerFirstName}${domainManyOther.name}<#else>${domain.lowerFirstName}</#if>Table").renderUrl({
				url:"<#noparse>$</#noparse>{ctx}/<#if domainMany??>${domainMany.lowerFirstName}/list${fieldMany.name?cap_first}<#else>${domain.lowerFirstName}/list</#if>",
				params : {'sortProperty':sort,'sortOrder':order<#if domainMany??>,'${domainMany.id.name}':'<#noparse>$</#noparse>{${domainMany.lowerFirstName}.${domainMany.id.name}}'<#else><#if domain.many2OneOtherRelationField??>,'${domain.many2OneOtherRelationField.name}.${project.domainMap[domain.many2OneOtherRelationField.entityName].id.name}':'<#noparse>${</#noparse>${domain.lowerFirstName}.${domain.many2OneOtherRelationField.name}.${project.domainMap[domain.many2OneOtherRelationField.entityName].id.name}<#noparse>}</#noparse>'</#if></#if>},
				op : "replace"
			});
		}
	});
});
</script>
<div id="<#if domainMany??>${domainMany.lowerFirstName}${domainManyOther.name}<#else>${domain.lowerFirstName}</#if>Table">
	<table class="list-table" cellpadding="0" cellspacing="1">
		<thead>
			<tr title="点击表头进行排序">
				<#if domain.checkType == statics["com.wanmei.domain.DomainHelper"].CHECK_TYPE_CHECKBOX>
				<th id="selectAll" onclick="checkAllBox(this);">全选</th>
				<#elseif domain.checkType == statics["com.wanmei.domain.DomainHelper"].CHECK_TYPE_RADIO>
				<th>选择</th>
				</#if>
				<#list domain.listSortField as f>
				<#if f.sortable>
				<th sort="${f.name}"  order="<#noparse>$</#noparse>{sort.sortOrder}" >${f.label}<c:if test="<#noparse>$</#noparse>{sort != null && sort.sortProperty == '${f.name}'}"><span class="icon-<#noparse>$</#noparse>{sort.sortOrder}sort">&nbsp;</span></c:if></th>
				<#else>
				<th>${f.label}</th>
				</#if>
				</#list>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="<#noparse>${</#noparse> ${domain.lowerFirstName}s<#noparse>}</#noparse>" var="${domain.lowerFirstName}">
			<tr idVar="<#noparse>${</#noparse>${domain.lowerFirstName}.${domain.id.name}<#noparse>}</#noparse>">
				<#if domain.checkType == statics["com.wanmei.domain.DomainHelper"].CHECK_TYPE_CHECKBOX>
				<td class="checkTd""><input type="checkbox" value="<#noparse>${</#noparse>${domain.lowerFirstName}.${domain.id.name}<#noparse>}</#noparse>" /></td>
				<#elseif domain.checkType == statics["com.wanmei.domain.DomainHelper"].CHECK_TYPE_RADIO>
				<td class="checkTd"><input type="radio" value="<#noparse>${</#noparse>${domain.lowerFirstName}.${domain.id.name}<#noparse>}</#noparse>" /></td>
				</#if>
				<#list domain.listSortField as f>
				<td>
				<#if f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE>
				<a href="javascript:void(0)"  onclick="view${project.domainMap[f.entityName].name}('<#noparse>$</#noparse>{${domain.lowerFirstName}.${f.name}.${project.domainMap[f.entityName].id.name}}')">
				<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}.${f.many2OneName}}
				</a>
				<#elseif f.isDict>
				<#noparse>$</#noparse>{g:var("${domain.packageName}.helper.${domain.name}Helper","${f.name}Map")[${domain.lowerFirstName}.${f.name}]}
				<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_DATE)>
				<fmt:formatDate value="<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}<#noparse>}</#noparse>" pattern="yyyy-MM-dd"/>
				<#elseif f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_DATETIME>
				<fmt:formatDate value="<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}<#noparse>}</#noparse>" pattern="yyyy-MM-dd HH:mm:ss"/>
				<#else>
				<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}<#noparse>}</#noparse>
				</#if>
				</td>
				</#list>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<#noparse>
	<div style="background-color: #d3eaef;text-align:right;padding-right:10px;" >
	<c:if test="${!empty commonList && commonList.pageNum>1 }">
	<g:page commonList="${commonList}"  uri="${ctx}</#noparse><#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/security</#if>/<#if domainMany??>${domainMany.lowerFirstName}/list${fieldMany.name?cap_first}?${domainMany.id.name}=<#noparse>$</#noparse>{${domainMany.lowerFirstName}.${domainMany.id.name}}<#else>${domain.lowerFirstName}/list<#if domain.many2OneOtherRelationField??>?${domain.many2OneOtherRelationField.name}.${project.domainMap[domain.many2OneOtherRelationField.entityName].id.name}=<#noparse>${</#noparse>${domain.lowerFirstName}.${domain.many2OneOtherRelationField.name}.${project.domainMap[domain.many2OneOtherRelationField.entityName].id.name}<#noparse>}</#noparse></#if></#if>" target="#<#if domainMany??>${domainMany.lowerFirstName}${domainManyOther.name}<#else>${domain.lowerFirstName}</#if>Table" pageNum="5" model="3" op="replace" />  
	</c:if>
	</div>
</div>