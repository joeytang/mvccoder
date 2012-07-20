<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	$('#inputForm').ajaxForm({
		beforeSubmit : function(){},
		dataType : 'json',
		success : function(data){
			$.parseJsonResult(data,function(data){
				$.info("操作成功");
				$("#mainDiv").renderUrl("${ctx}/user/main");
			},function(msg,data){
				$.messager.alert("提示信息",msg,"error");
			});
			$("#saveBtn").removeAttr("status");
		},
		error : function(data){
			$.info("操作出错，请联系管理员");
			$("#saveBtn").removeAttr("status");
		}
	});
	$("#roleId").loadSelect({
		headValue : "", //默认的一个选项的值 eg 0
		headText : "",//默认的一个选项的文本 eg 请选择
		data : null, //select中需要填充的数据，如果提供了该数据，则直接将这个数据填充到色了传统中，若未提供，则根据url去取
		params : {},//用于获得select中数据的地址
		url : "${ctx}/dict/userRole",//用于获得select中数据的地址
		value : 'key', //取json数据data中，用于表示option的value属性的标示
		text : 'value',//取json数据data中，用于表示option的text属性的标示
		defaultValue : '${user.role}',//默认被选中的值
		changeFn : null,//change事件
		fn : null//装载完以后调用的回调函数
	});
	validatorGroup_setting = [];
	$.formValidator.initConfig({
		submitButtonID:"saveBtn",
		debug:false,
		onSuccess:function(){
			if($("#saveBtn").attr("status")){
				return false;
		    }
		    $("#saveBtn").attr("status","1");
		    return true;
		},
		onError:function(msg,obj,errorlist){
			$.info(msg);
		},
		ajaxPrompt : '数据提交中...'
	});
	var urlmsg = "该用户已经存在" ; 
	$("#usernameId").formValidator({
		empty:false,onShow:"请输入账号",onFocus:"请输入账号",onCorrect:"校验成功"
	}).inputValidator({
		min:1,max:50,onError:"长度在1-50之间，请确认" 
	}).ajaxValidator({
		dataType : "json",
		type : "POST",
		async : true,
		data : {id : '<c:if test="${!empty user.id}">${user.id}</c:if>'},
		url : "${ctx}/user/checkUsername",
		success : function(data){
			var st = false;
			$.parseJsonResult(data,function(data){
				var acc = $("#usernameId").val();
				st = true;
			},function(msg,data){
				st = false;
				urlmsg = msg;
				$.messager.alert("提示信息",msg,"error");
			});
			return st;
		},
		buttons: $("#saveBtn"),
		error: function(jqXHR, textStatus, errorThrown){urlmsg ="服务器没有返回数据，可能服务器忙，请重试"+errorThrown;},
		onError : urlmsg,
		onWait : "正在校验地址..."
	}).defaultPassed();
	$("#passwordId").formValidator({
		onShow:"请输入0-50个字符",onFocus:"请输入0-50个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:0,max:50,onError:"请输入0-50个字符"
	});	
	$("#nicknameId").formValidator({
		onShow:"请输入0-50个字符",onFocus:"请输入0-50个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:0,max:50,onError:"请输入0-50个字符"
	});	
	$("#roleId").formValidator({
		empty :false,onShow:"请输入0-50个字符",onFocus:"请输入0-50个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		onError:"请输入0-50个字符"
	});	
});
</script>
<form  class="form" id="inputForm" method="post" action="${ctx }/user/save" >
	<input type="hidden" name="id" id="idId" value="${user.id}" />
	<table class="form-table" cellpadding="0" cellspacing="0">
		<tr> 
	      <td class="righttd">账号:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="username" id="usernameId" maxlength="50" value="${user.username}"/>
	      </td>
	      <td class="lefttd"><div id="usernameIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">密码:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="password" id="passwordId" maxlength="50" value="${user.password}"/>
	      </td>
	      <td class="lefttd"><div id="passwordIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">名称:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="nickname" id="nicknameId" maxlength="50" value="${user.nickname}"/>
	      </td>
	      <td class="lefttd"><div id="nicknameIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">角色:</td>
	      <td class="lefttd"  style="width:300px" >
			<select  style="width:280px;height:20px;" name="role" id="roleId" >
			</select>
	      </td>
	      <td class="lefttd"><div id="roleIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd"></td>
	      <td colspan="2" class="lefttd">
	      <input type="button" id="saveBtn" value="保存" onclick="if($.formValidator.pageIsValid()) $('#inputForm').submit()" />
	      <input type="reset" id="resetBtn" value="重置" />
	      <input type="button" id="backToListBtn" onclick='javascript:$("#mainDiv").renderUrl("${ctx}/user/main");' value="返回列表" />
	      </td>
	    </tr>
	</table>
</form>