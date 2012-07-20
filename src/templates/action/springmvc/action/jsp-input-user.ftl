<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	$('#inputForm').ajaxForm({
		beforeSubmit : function(){},
		dataType : 'json',
		success : function(data){
			if(data.status == "success"){
				$.info("操作成功");
				$("#mainDiv").renderUrl("<#noparse>$</#noparse>{ctx}/user/main");
			}else if(data.error ) {
				$.info(data.error);
			}else{
				$.info("操作出错，请联系管理员");
			}
			$("#saveBtn").removeAttr("status");
		},
		error : function(data){
			$.info("操作出错，请联系管理员");
			$("#saveBtn").removeAttr("status");
		}
	});
	$.formValidator.initConfig({
		submitButtonID:"saveBtn",
		formID:"inputForm",
		debug:false,
		onSuccess:function(){
			if($("#saveBtn").attr("status")){
				return false;
		    }
		    $("#saveBtn").attr("status","1");
		    return true;
		},
		onError:function(msg,obj,errorlist){
			/**$("#errorlist").empty();
			$.map(errorlist,function(msg){
				$("#errorlist").append("<li>" + msg + "</li>")
			});*/
			$.info(msg);
		},
		ajaxPrompt : '数据提交中...'
	});
	var urlmsg = "该用户已经存在" ; 
	$("#accountId").formValidator({
		onShow:"请输入账号",onFocus:"请输入账号",onCorrect:"校验成功"
	}).inputValidator({
		min:1,max:50,onError:"长度在1-50之间，请确认" 
	}).ajaxValidator({
		dataType : "json",
		type : "POST",
		async : true,
		data : {id : '<c:if test="<#noparse>$</#noparse>{!empty user.id}"><#noparse>$</#noparse>{user.id}</c:if>'},
		url : "<#noparse>$</#noparse>{ctx}/user/checkAccount",
		success : function(data){
			$.info(111);
			if(data.status == "success"){
				var acc = $("#accountId").val();
				$("#emailId").val(acc + "@wanmei.com");
				return true;
			}else if(data.error ) {
				urlmsg = data.error;
				return false;
			}else{
				return false;
			}
		},
		buttons: $("#saveBtn"),
		error: function(jqXHR, textStatus, errorThrown){urlmsg ="服务器没有返回数据，可能服务器忙，请重试"+errorThrown;},
		onError : urlmsg,
		onWait : "正在校验地址..."
	}).defaultPassed();
	$("#emailId").formValidator({
		onShow:"请输入邮箱",onFocus:"请输入6-100个字符的邮箱地址",onCorrect:"校验成功"
	}).inputValidator({
		min:6,max:100,onError:"长度在6-100之间,请确认"
	}).regexValidator({
		regExp:"^([\\w-.]+)@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.)|(([\\w-]+.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(]?)$",onError:"邮箱格式不正确"
	});
	$("#userNameId").formValidator({
		trimValue:true,onShow:"请输入中文名",onFocus:"请输入中文名",onCorrect:"校验成功"
	}).inputValidator({
		min:1,max:20,onError:"长度在1-20之间，请确认"
	});
	$("#passwordId").formValidator({
		trimValue:true,onShow:"请输入密码",onFocus:"请输入密码",onCorrect:"校验成功"
	}).inputValidator({min:1,max:20,onError:"长度在1-20之间，请确认"});
	
	$("#roleId").formValidator({
		empty:false,onShow:"请选择角色",onCorrect:"校验成功",onEmpty : "请选择角色"
	});
	$("#roleId").loadSelect({
		url : "<#noparse>$</#noparse>{ctx}/dict/userRole",//用于获得select中数据的地址
		value : 'key', //取json数据data中，用于表示option的value属性的标示
		text : 'value',//取json数据data中，用于表示option的text属性的标示
		defaultValue : '<#noparse>$</#noparse>{user.role}',//默认被选中的值
		fn : null//装载完以后调用的回调函数
	});
});
</script>
<ul id="errorlist"></ul>
<form class="form" id="inputForm" method="post" action="<#noparse>$</#noparse>{ctx }/user/save" >
	<input type="hidden" name="id" id="idId" value="<#noparse>$</#noparse>{user.id}" />
	<table class="form-table" cellpadding="0" cellspacing="0">
	    <tr> 
	      <td class="righttd">账号:</td>
	      <td class="lefttd"  style="width:200px" ><input class="input" type="text" name="account" id="accountId" maxlength="50" value="<#noparse>$</#noparse>{user.account}" /></td>
	      <td class="lefttd"><div id="accountIdTip" style="width:250px"></div></td>
	    </tr>
	    <tr> 
	      <td class="righttd">邮箱:</td>
	      <td class="lefttd"  style="width:200px" ><input class="input" type="text" name="email" id="emailId" maxlength="50" value="<#noparse>$</#noparse>{user.email}"/></td>
	      <td class="lefttd"><div id="emailIdTip" style="width:250px"></div></td>
	    </tr>
	    <tr> 
	      <td class="righttd">中文名:</td>
	      <td class="lefttd"  style="width:200px" ><input class="input" type="text" name="userName" id="userNameId" maxlength="50" value="<#noparse>$</#noparse>{user.userName}"/></td>
	      <td class="lefttd"><div id="userNameIdTip" style="width:250px"></div></td>
	    </tr>
	    <tr> 
	      <td class="righttd">密码:</td>
	      <td class="lefttd"  style="width:200px" ><input class="input" type="text" name="password" id="passwordId" maxlength="50" value="<#noparse>$</#noparse>{user.password}"/></td>
	      <td class="lefttd"><div id="passwordIdTip" style="width:250px"></div></td>
	    </tr>
	     <tr> 
	      <td class="righttd">角色:</td>
	      <td class="lefttd"  style="width:200px" ><select id="roleId" name="role" style="width: 100px" ></select></td>
	      <td class="lefttd"><div id="roleIdTip" style="width:250px"></div></td>
	    </tr>
	    <tr> 
	    	<td class="righttd"></td>
	      <td colspan="2" class="lefttd">
	      <input type="button" id="saveBtn" value="保存" onclick="$('#inputForm').submit()" />
	      <input type="reset" id="resetBtn" value="重置" />
	      <input type="button" id="backToListBtn" onclick='javascript:$("#mainDiv").renderUrl("<#noparse>$</#noparse>{ctx}/user/main");' value="返回列表" />
	      </td>
	    </tr>
    </table>
</form>