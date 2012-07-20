<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	$("#fieldSearcher").panel();
	$("#fieldList").panel();
	$("#fieldList").renderUrl({
		url : "${ctx}/field/list",
		op : "append"
	});
});
function create(){
	$("#mainDiv").renderUrl("${ctx}/field/input");
} 
function edit(id){
	if(!id){
		var chkVals = $("#fieldList").find("input:checked").vals();
		if(chkVals.length < 1){
			$.info("请选择一条记录");
			return ;
		}
		id=chkVals[0];
	}
	$("#mainDiv").renderUrl("${ctx}/field/update/"+id);
} 
function removeMore(){
	var chkVals = $("#fieldList").find("input:checked").vals();
	if(!chkVals || chkVals.length < 1){
		$.info("请选择一条记录");
		return ;
	}
	$.confirm("提示信息","确认批量删除记录",function(b){
		if(b){
			$.ajax( {
				url : "${ctx}/field/removeMore",
				cache : false,
				dataType : "json",
				data : $.param({ids:chkVals},true),
				success : function(data) {
					$.parseJsonResult(data,function(data){
						$("#fieldTable").renderUrl("${ctx}/field/list");
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
		var chkVals = $("#fieldList").find("input:checked").vals();
		if(chkVals.length < 1){
			$.info("请选择一条记录");
			return ;
		}
		id=chkVals[0];
	}
	var $div = $("<div style='overflow: scroll;'></div>");
	$div.dialog({
		title : "查看详情",
		href : "${ctx}/field/view/"+id,
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
							url : "${ctx}/field/view/"+id,
							cache : false,
							dataType : "json",
							success : function(data) {
								$.parseJsonResult(data,function(data){
									$("#fieldTable").renderUrl("${ctx}/field/list");
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
function search(){
    $("#fieldTable").renderUrl({
    	url : "${ctx}/field/list",
    	params : $("#searchForm").serialize()
    });
}

</script>
<div id="fieldSearcher" style=" overflow: hidden;" class="search-div" border="false">
<form class="form" id="searchForm" method="post" action="${ctx }/field/list" >
<input type="hidden" id="sortPropertyId" name="sortProperty" value="id" />
<input type="hidden" id="sortOrderId" name="sortOrder" value="desc" />
	<div>列英文名:
		<input class="input" type="text" name="name" id="nameId" maxlength="10" value="${field.name}"/>
	</div>
	<div>列中文名:
		<input class="input" type="text" name="label" id="labelId" maxlength="20" value="${field.label}"/>
	</div>
	<div style="text-align:left;padding-left:5px;"><input type="button" id="searchBtn" style="font-size:10px;" value="查询" onclick="search()" /></div>
</form>
</div>
<div id="fieldList" class="list" >
	<div align="right">
	<input type="button" value="添加" onclick="create();" />
	<input type="button" value="修改" onclick="edit();" />
	<input type="button" value="删除" onclick="removeMore();" />
	<input type="button" value="详情" onclick="view();" />
	</div>
</div>
