<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	$("#securitySearcher").panel();
	$("#securityList").panel();
	$("#securityList").renderUrl({
		url : "${ctx}/security/list",
		op : "append"
	});
});
function create(){
	$("#mainDiv").renderUrl("${ctx}/security/input");
} 
function edit(id){
	if(!id){
		var chkVals = $("#securityList").find("input:checked").vals();
		if(chkVals.length < 1){
			$.info("请选择一条记录");
			return ;
		}
		id=chkVals[0];
	}
	$("#mainDiv").renderUrl("${ctx}/security/update/"+id);
} 
function removeMore(){
	var chkVals = $("#securityList").find("input:checked").vals();
	if(!chkVals || chkVals.length < 1){
		$.info("请选择一条记录");
		return ;
	}
	$.confirm("提示信息","确认批量删除记录",function(b){
		if(b){
			$.ajax( {
				url : "${ctx}/security/removeMore",
				cache : false,
				dataType : "json",
				data : $.param({ids:chkVals},true),
				success : function(data) {
					$.parseJsonResult(data,function(data){
						$("#securityTable").renderUrl("${ctx}/security/list");
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
function view(id){
	if(!id){
		var chkVals = $("#securityList").find("input:checked").vals();
		if(chkVals.length < 1){
			$.info("请选择一条记录");
			return ;
		}
		id=chkVals[0];
	}
	var $div = $("<div style='overflow: scroll;'></div>");
	$div.dialog({
		title : "查看详情",
		href : "${ctx}/security/view/"+id,
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
			text : "修改",
			handler : function(){
				edit(id);
				$div.dialog("destroy");
			}
		},{
			text : "删除",
			handler : function(){
				$.confirm("提示信息","确认删除记录",function(b){
					if(b){
						$.ajax( {
							url : "${ctx}/security/view/"+id,
							cache : false,
							dataType : "json",
							success : function(data) {
								$.parseJsonResult(data,function(data){
									$("#securityTable").renderUrl("${ctx}/security/list");
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
		},{
			text : "关闭",
			handler : function(){
				$div.dialog("destroy");
			}
		}]
	});
} 

</script>
<div id="securitySearcher" style=" overflow: hidden;" class="search-div" border="false">
</div>
<div id="securityList" class="list" >
	<div align="right">
	<input type="button" value="添加" onclick="create();" />
	<input type="button" value="修改" onclick="edit();" />
	<input type="button" value="删除" onclick="removeMore();" />
	<input type="button" value="详情" onclick="view();" />
	</div>
</div>
