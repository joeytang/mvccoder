<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	$("#userSearcher").panel();
	$("#userList").panel();
	$("#userList").renderUrl({
		url : "${ctx}/user/list",
		op : "append"
	});
});
function create(){
	$("#mainDiv").renderUrl("${ctx}/user/input");
} 
function edit(id){
	if(!id){
		var chkVals = $("#userList").find("input:checked").vals();
		if(chkVals.length < 1){
			$.info("请选择一条记录");
			return ;
		}
		id=chkVals[0];
	}
	$("#mainDiv").renderUrl("${ctx}/user/update/"+id);
} 
function removeMore(){
	var chkVals = $("#userList").find("input:checked").vals();
	if(!chkVals || chkVals.length < 1){
		$.info("请选择一条记录");
		return ;
	}
	$.confirm("提示信息","确认批量删除记录",function(b){
		if(b){
			$.ajax( {
				url : "${ctx}/user/removeMore",
				cache : false,
				dataType : "json",
				data : $.param({ids:chkVals},true),
				success : function(data) {
					$.parseJsonResult(data,function(data){
						$("#userTable").renderUrl("${ctx}/user/list");
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
		var chkVals = $("#userList").find("input:checked").vals();
		if(chkVals.length < 1){
			$.info("请选择一条记录");
			return ;
		}
		id=chkVals[0];
	}
	var $div = $("<div style='overflow: scroll;'></div>");
	$div.dialog({
		title : "查看详情",
		href : "${ctx}/user/view/"+id,
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
							url : "${ctx}/user/view/"+id,
							cache : false,
							dataType : "json",
							success : function(data) {
								$.parseJsonResult(data,function(data){
									$("#userTable").renderUrl("${ctx}/user/list");
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
function enableMore(){
	var chkVals = $("#userList").find("input:checked").vals();
	if(!chkVals || chkVals.length < 1){
		$.info("请选择一条记录");
		return ;
	}
	$.confirm("提示信息","确认启用记录",function(b){
		if(b){
			$.ajax( {
				url : "${ctx}/user/enableMore",
				cache : false,
				dataType : "json",
				data : $.param({ids:chkVals},true),
				success : function(data) {
					$.parseJsonResult(data,function(data){
						$("#userTable").renderUrl("${ctx}/user/list");
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
function disableMore(){
	var chkVals = $("#userList").find("input:checked").vals();
	if(!chkVals || chkVals.length < 1){
		$.info("请选择一条记录");
		return ;
	}
	$.confirm("提示信息","确认禁用记录",function(b){
		if(b){
			$.ajax( {
				url : "${ctx}/user/disableMore",
				cache : false,
				dataType : "json",
				data : $.param({ids:chkVals},true),
				success : function(data) {
					$.parseJsonResult(data,function(data){
						$("#userTable").renderUrl("${ctx}/user/list");
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
function search(){
    $("#userTable").renderUrl({
    	url : "${ctx}/user/list",
    	params : $("#searchForm").serialize()
    });
}

</script>
<div id="userSearcher" style=" overflow: hidden;" class="search-div" border="false">
<form class="form" id="searchForm" method="post" action="${ctx }/user/list" >
<input type="hidden" id="sortPropertyId" name="sortProperty" value="id" />
<input type="hidden" id="sortOrderId" name="sortOrder" value="desc" />
	<div>账号:
		<input class="input" type="text" name="username" id="usernameId" maxlength="50" value="${user.username}"/>
	</div>
	<div>名称:
		<input class="input" type="text" name="nickname" id="nicknameId" maxlength="50" value="${user.nickname}"/>
	</div>
	<div style="text-align:left;padding-left:5px;"><input type="button" id="searchBtn" style="font-size:10px;" value="查询" onclick="search()" /></div>
</form>
</div>
<div id="userList" class="list" >
	<div align="right">
	<input type="button" value="添加" onclick="create();" />
	<input type="button" value="修改" onclick="edit();" />
	<input type="button" value="删除" onclick="removeMore();" />
	<input type="button" value="详情" onclick="view();" />
	<input type="button" value="启用" onclick="enableMore();" />
	<input type="button" value="禁用" onclick="disableMore();" />
	</div>
</div>
