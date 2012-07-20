<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	$("#domainButtonSearcher").panel();
	$("#domainButtonList").panel();
	$("#domainButtonList").renderUrl({
		url : "${ctx}/domainButton/list/${id}",
		op : "append"
	});
});
function create(){
	$("#mainDiv").renderUrl("${ctx}/domainButton/input/${id}");
} 
function edit(id){
	if(!id){
		var chkVals = $("#domainButtonList").find("input:checked").vals();
		if(chkVals.length < 1){
			$.info("请选择一条记录");
			return ;
		}
		id=chkVals[0];
	}
	$("#mainDiv").renderUrl("${ctx}/domainButton/update/"+id);
} 
function removeMore(){
	var chkVals = $("#domainButtonList").find("input:checked").vals();
	if(!chkVals || chkVals.length < 1){
		$.info("请选择一条记录");
		return ;
	}
	$.confirm("提示信息","确认批量删除记录",function(b){
		if(b){
			$.ajax( {
				url : "${ctx}/domainButton/removeMore",
				cache : false,
				dataType : "json",
				data : $.param({ids:chkVals},true),
				success : function(data) {
					$.parseJsonResult(data,function(data){
						$("#domainButtonTable").renderUrl("${ctx}/domainButton/list/${id}");
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
		var chkVals = $("#domainButtonList").find("input:checked").vals();
		if(chkVals.length < 1){
			$.info("请选择一条记录");
			return ;
		}
		id=chkVals[0];
	}
	var $div = $("<div style='overflow: scroll;'></div>");
	$div.dialog({
		title : "查看详情",
		href : "${ctx}/domainButton/view/"+id,
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
							url : "${ctx}/domainButton/view/"+id,
							cache : false,
							dataType : "json",
							success : function(data) {
								$.parseJsonResult(data,function(data){
									$("#domainButtonTable").renderUrl("${ctx}/domainButton/list/${id}");
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
function addAll(id){
	$.ajax( {
		url : "${ctx}/domainButton/addAll/${id}",
		cache : false,
		dataType : "json",
		success : function(data) {
			$.parseJsonResult(data,function(data){
				$.info("添加成功",function(){
					$("#domainButtonTable").renderUrl("${ctx}/domainButton/list/${id}");
				});
			},function(msg,data){
				$.error(msg);
			});
		},
		error : function() {
			$.error("系统错误,请联系管理员");
		}
	});
} 
</script>
<div id="domainButtonSearcher" style=" overflow: hidden;" class="search-div" border="false">
</div>
<div id="domainButtonList" class="list" >
	<div align="right">
	<input type="button" value="添加" onclick="create();" />
	<input type="button" value="添加全部按钮" onclick="addAll();" />
	<input type="button" value="修改" onclick="edit();" />
	<input type="button" value="删除" onclick="removeMore();" />
	<input type="button" value="详情" onclick="view();" />
	</div>
</div>
