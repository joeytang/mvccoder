<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	$("#userSearcher").panel();
	$("#userList").panel({title : '列表'});
	$("#userTable").renderUrl("<#noparse>$</#noparse>{ctx}/user/list");
});
function checkAllBox(obj){
	var $this = $(obj);
	if($this.parents("table").find(":checkbox").length){
		if($this.attr("checked")){
			$this.removeAttr("checked");
			$this.parents("table").find(":checkbox").removeAttr("checked");
			$this.html("全选");
		}else{
			$this.attr("checked","1");
			$this.parents("table").find(":checkbox").attr("checked","checked");
			$this.html("反选");
		}
	}
}
function create(){
	$("#mainDiv").renderUrl("<#noparse>$</#noparse>{ctx}/user/input");
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
	$("#mainDiv").renderUrl("<#noparse>$</#noparse>{ctx}/user/input?id="+id);
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
		href : "<#noparse>$</#noparse>{ctx}/user/view?id="+id,
		headerCls : "panelHeader",
		cache : false,
		collapsible : true,
		resizable : true,
		modal : true,
		width : 300,
		height : 300,
		onClose : function(){
			$div.dialog("destroy");
		},
		buttons : [
		{
			text : "修改",
			handler : function(){
				edit(id);
				$div.dialog("destroy");
			}
		},
		{
			text : "删除",
			handler : function(){
				$.confirm("提示信息","确认删除记录",fn(b){
					if(b){
						$.get("<#noparse>$</#noparse>{ctx}/user/remove?id="+id,function(){
							$("#userTable").renderUrl("<#noparse>$</#noparse>{ctx}/user/list");
							$div.dialog("destroy");
						});
					}
				});
			}
		},
		{
			text : "关闭",
			handler : function(){
				$div.dialog("destroy");
			}
		}]
	});
} 
function remove(){
	if(!id){
		var chkVals = $("#userList").find("input:checked").vals();
		if(chkVals.length < 1){
			$.info("请选择一条记录");
			return ;
		}
		id=chkVals[0];
	}
	$.confirm("提示信息","确认删除记录",fn(b){
		if(b){
			$.get("<#noparse>$</#noparse>{ctx}/user/remove?id="+id,function(){
				$("#userTable").renderUrl("<#noparse>$</#noparse>{ctx}/user/list");
			});
		}
	});
}
function removeMore(){
	var chkVals = $("#userList").find("input:checked").vals();
	if(!chkVals || chkVals.length < 1){
		$.info("请选择一条记录");
		return ;
	}
	$.confirm("提示信息","确认删除记录",fn(b){
		if(b){
			$.post("<#noparse>$</#noparse>{ctx}/user/removeMore",$.param({ids:chkVals},true),function(){
				$("#userTable").renderUrl("<#noparse>$</#noparse>{ctx}/user/list");
			});
		}
	});
}
function enableMore(){
	var chkVals = $("#userList").find("input:checked").vals();
	if(!chkVals || chkVals.length < 1){
		$.info("请选择一条记录");
		return ;
	}
	$.confirm("提示信息","确认删除记录",fn(b){
		if(b){
			$.post("<#noparse>$</#noparse>{ctx}/user/enableMore",$.param({ids:chkVals},true),function(){
				$("#userTable").renderUrl("<#noparse>$</#noparse>{ctx}/user/list");
			});
		}
	});
}
function search(){
    $("#userTable").renderUrl({
    	url : "<#noparse>$</#noparse>{ctx}/user/list",
    	params : $("#searchForm").serialize()
    });
}
</script>
<div id="userSearcher" style=" overflow: hidden;">
	<form class="form" id="searchForm" method="post" action="<#noparse>$</#noparse>{ctx }/user/list" >
		<table  cellpadding="0" cellspacing="0">
		    <tr> 
		      <td class="righttd">账号:</td>
		      <td class="lefttd"  style="width:200px" ><input class="input" type="text" name="account" id="accountId" maxlength="50" value="<#noparse>$</#noparse>{user.account}" /></td>
		      <td class="lefttd"><div id="accountIdTip" style="width:250px"></div></td>
		    </tr>
		    <tr> 
		      <td class="righttd">中文名:</td>
		      <td class="lefttd"  style="width:200px" ><input class="input" type="text" name="userName" id="userNameId" maxlength="50" value="<#noparse>$</#noparse>{user.userName}"/></td>
		      <td class="lefttd"><div id="userNameIdTip" style="width:250px"></div></td>
		    </tr>
		    <tr> 
		    	<td class="righttd"></td>
		      <td colspan="2" class="lefttd">
		      <input type="button" id="searchBtn" value="查询" onclick="search()" />
		      <input type="reset" id="resetBtn" value="重置" />
		      </td>
		    </tr>
	    </table>
	</form>
</div>
<div id="userList" class="list" headerCls="panelHeader" title="列表">
	<div align="right">
	<input type="button" value="添加" onclick="create();" />
	<input type="button" value="修改" onclick="edit();" />
	<input type="button" value="查看" onclick="view();" />
	<input type="button" value="启用" onclick="enableMore();" />
	<input type="button" value="禁用" onclick="removeMore();" />
	</div>
	<div id="userTable">
	
	</div>
</div>
