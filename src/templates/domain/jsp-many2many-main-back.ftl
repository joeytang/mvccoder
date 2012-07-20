<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
<#noparse>$(document).ready(function(){</#noparse>
	<#noparse>$</#noparse>("#${domainMany.lowerFirstName}${domainManyOther.name}Searcher").panel();
	<#noparse>$</#noparse>("#${domainMany.lowerFirstName}${domainManyOther.name}List").panel();
	<#noparse>$</#noparse>("#${domainMany.lowerFirstName}${domainManyOther.name}List").renderUrl({
		url : "<#noparse>$</#noparse>{ctx}/${domainMany.lowerFirstName}/list${fieldMany.name?cap_first}?${domainMany.id.name}=<#noparse>$</#noparse>{${domainMany.lowerFirstName}.${domainMany.id.name}}",
		op : "append"
	});
});
function add${fieldMany.name?cap_first}(){
	var $div = $("<div style='overflow: scroll;'></div>");
	$div.dialog({
		title : "列出${domainManyOther.label}",
		href : "<#noparse>$</#noparse>{ctx}/${domainManyOther.lowerFirstName}/list",
		cache : false,
		collapsible : true,
		resizable : true,
		modal : true,
		width : 500,
		height : 500,
		onClose : function(){
			$div.dialog("destroy");
		},
		buttons : [{
			text : "确认",
			handler : function(){
				$.ajax( {
					url : "<#noparse>$</#noparse>{ctx}<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/security</#if>/${domainMany.lowerFirstName}/add${fieldMany.name?cap_first}",
					cache : false,
					dataType : "json",
					data : $.param({${domainMany.id.name}:'<#noparse>$</#noparse>{${domainMany.lowerFirstName}.${domainMany.id.name}}',ids:$div.find("input:checked").vals()},true),
					success : function(data) {
						$.parseJsonResult(data,function(data){
							<#noparse>$</#noparse>("#${domainMany.lowerFirstName}${domainManyOther.name}Table").renderUrl("<#noparse>$</#noparse>{ctx}/${domainMany.lowerFirstName}/list${fieldMany.name?cap_first}?${domainMany.id.name}=<#noparse>$</#noparse>{${domainMany.lowerFirstName}.${domainMany.id.name}}");
							$div.dialog("destroy");
						},function(msg,data){
							$.error(msg);
						});
					},
					error : function() {
						$.error("系统错误,请联系管理员");
					}
				});
			}
		},{
			text : "关闭",
			handler : function(){
				$div.dialog("destroy");
			}
		}]
	});
	
}
function remove${fieldMany.name?cap_first}(){
	var chkVals = <#noparse>$</#noparse>("#${domainMany.lowerFirstName}${domainManyOther.name}List").find("input:checked").vals();
	if(!chkVals || chkVals.length < 1){
		$.info("请选择一条记录");
		return ;
	}
	$.confirm("提示信息","确认${fieldMany.label}记录",function(b){
		if(b){
			$.ajax( {
				url : "<#noparse>$</#noparse>{ctx}<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/security</#if>/${domainMany.lowerFirstName}/remove${fieldMany.name?cap_first}",
				cache : false,
				dataType : "json",
				data : $.param({${domainMany.id.name}:'<#noparse>$</#noparse>{${domainMany.lowerFirstName}.${domainMany.id.name}}',ids:chkVals},true),
				success : function(data) {
					$.parseJsonResult(data,function(data){
						<#noparse>$</#noparse>("#${domainMany.lowerFirstName}${domainManyOther.name}Table").renderUrl("<#noparse>$</#noparse>{ctx}/${domainMany.lowerFirstName}/list${fieldMany.name?cap_first}?${domainMany.id.name}=<#noparse>$</#noparse>{${domainMany.lowerFirstName}.${domainMany.id.name}}");
						$div.dialog("destroy");
					},function(msg,data){
						$.error(msg);
					});
				},
				error : function() {
					$.error("系统错误,请联系管理员");
				}
			});
		}
	});
}
</script>
<div id="${domainMany.lowerFirstName}${domainManyOther.name}Searcher" style=" overflow: hidden;" class="search-div" border="false">
</div>
<div id="${domainMany.lowerFirstName}${domainManyOther.name}List" class="list" >
	<div align="right">
	<input type="button" value="添加${fieldMany.label}" onclick="add${fieldMany.name?cap_first}();" />
	<input type="button" value="删除${fieldMany.label}" onclick="remove${fieldMany.name?cap_first}();" />
	</div>
</div>
