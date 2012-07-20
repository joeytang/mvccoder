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
				$("#mainDiv").renderUrl("${ctx}/domain/main");
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
	$("#checkTypeId").loadSelect({
		data : null, //select中需要填充的数据，如果提供了该数据，则直接将这个数据填充到色了传统中，若未提供，则根据url去取
		params : {},//用于获得select中数据的地址
		url : "${ctx}/dict/domainCheckType",//用于获得select中数据的地址
		value : 'key', //取json数据data中，用于表示option的value属性的标示
		text : 'value',//取json数据data中，用于表示option的text属性的标示
		defaultValue : '${domain.checkType}',//默认被选中的值
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
	$("#nameId").formValidator({
		empty :false,onShow:"请输入1-20个字符",onFocus:"请输入1-20个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:1,max:20,onError:"请输入1-20个字符"
	});	
	$("#labelId").formValidator({
		empty :false,onShow:"请输入1-20个字符",onFocus:"请输入1-20个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:1,max:20,onError:"请输入1-20个字符"
	});	
	$("#tableId").formValidator({
		onShow:"请输入0-20个字符",onFocus:"请输入0-20个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:0,max:20,onError:"请输入0-20个字符"
	});	
	$("#descriptionId").formValidator({
		onShow:"请输入0-250个字符",onFocus:"请输入0-250个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:0,max:250,onError:"请输入0-250个字符"
	});	
	$("#packageNameId").formValidator({
		empty :false,onShow:"请输入1-20个字符",onFocus:"请输入1-20个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:1,max:20,onError:"请输入1-20个字符"
	});	
	$("#disabledControllersId").formValidator({
		onShow:"请输入0-250个字符",onFocus:"请输入0-250个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:0,max:250,onError:"请输入0-250个字符"
	});	
});
</script>
<form  class="form" id="inputForm" method="post" action="${ctx }/domain/save" >
	<input type="hidden" name="idkey" id="idkeyId" value="${domain.idkey}" />
	<table class="form-table" cellpadding="0" cellspacing="0">
		<tr> 
	      <td class="righttd">模块英文名:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="name" id="nameId" maxlength="20" value="${domain.name}"/>
	      </td>
	      <td class="lefttd"><div id="nameIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">模块中文名:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="label" id="labelId" maxlength="20" value="${domain.label}"/>
	      </td>
	      <td class="lefttd"><div id="labelIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">对应表名:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="table" id="tableId" maxlength="20" value="${domain.table}"/>
	      </td>
	      <td class="lefttd"><div id="tableIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">模块描述:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="description" id="descriptionId" maxlength="250" value="${domain.description}"/>
	      </td>
	      <td class="lefttd"><div id="descriptionIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">模块包名:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="packageName" id="packageNameId" maxlength="20" value="${domain.packageName}"/>
	      </td>
	      <td class="lefttd"><div id="packageNameIdTip" style="width:250px"></div></td>
	    </tr>
	    <tr> 
	      <td class="righttd">列表选框类型:</td>
	      <td class="lefttd"  style="width:300px" >
			<select  style="width:280px;height:20px;" name="checkType" id="checkTypeId" >
			</select>
	      </td>
	      <td class="lefttd"><div id="typeIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">禁用的Controller:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="disabledControllers" id="disabledControllersId" maxlength="250" value="${domain.disabledControllers}"/>
	      </td>
	      <td class="lefttd"><div id="disabledControllersIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">是否为User模块:</td>
	      <td class="lefttd"  style="width:300px" >
			<input type="radio" name="isUser" value="1" <c:if test="${domain.isUser}"> checked="checked"</c:if>>是</input>
		    <input type="radio" name="isUser" value="0" <c:if test="${!domain.isUser}"> checked="checked"</c:if>>否</input>
	      </td>
	      <td class="lefttd"><div id="isUserIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">是否作为复合主键:</td>
	      <td class="lefttd"  style="width:300px" >
			<input type="radio" name="isComposeId" value="1" <c:if test="${domain.isComposeId}"> checked="checked"</c:if>>是</input>
		    <input type="radio" name="isComposeId" value="0" <c:if test="${!domain.isComposeId}"> checked="checked"</c:if>>否</input>
	      </td>
	      <td class="lefttd"><div id="isComposeIdIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd"></td>
	      <td colspan="2" class="lefttd">
	      <input type="button" id="saveBtn" value="保存" onclick="if($.formValidator.pageIsValid()) $('#inputForm').submit()" />
	      <input type="reset" id="resetBtn" value="重置" />
	      <input type="button" id="backToListBtn" onclick='javascript:$("#mainDiv").renderUrl("${ctx}/domain/main");' value="返回列表" />
	      </td>
	    </tr>
	</table>
</form>