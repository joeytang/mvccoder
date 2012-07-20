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
				$("#mainDiv").renderUrl("${ctx}/domainController/main/${domainController.domain.idkey}");
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
	$("#ButtonId").comboSelect({
		emptyText : "No Record",//默认没有搜索到结果的提示信息,
		url : "${ctx}/controller/listController",//搜索请求的地址
		keyword : "key", //搜索时关键字变量名
		value : 'id', //取json数据data中，用于表示option的value属性的标示
		text : 'name',//取json数据data中，用于表示option的text属性的标示
		currentText : "${domainController.controller.name}", // 当前显示的字符串
		currentValue : "${domainController.controller.id}"// 当前选中的值
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
});
</script>
<form  class="form" id="inputForm" method="post" action="${ctx }/domainController/save" >
	<input type="hidden" name="id" id="idId" value="${domainController.id}" />
	<input type="hidden" name="domain.idkey" id="domainId" value="${domainController.domain.idkey}" />
	<table class="form-table" cellpadding="0" cellspacing="0">
		<tr> 
	      <td class="righttd">选择自定义Controller:</td>
	      <td class="lefttd"  style="width:300px" >
	      <input type="hidden" name="controller.id" id="controllerId" value="${domainController.controller.id}"/>
	      </td>
	      <td class="lefttd"><div id="controllerIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd"></td>
	      <td colspan="2" class="lefttd">
	      <input type="button" id="saveBtn" value="保存" onclick="if($.formValidator.pageIsValid()) $('#inputForm').submit()" />
	      <input type="reset" id="resetBtn" value="重置" />
	      <input type="button" id="backToListBtn" onclick='javascript:$("#mainDiv").renderUrl("${ctx}/domainController/main/${domainController.domain.idkey}");' value="返回列表" />
	      </td>
	    </tr>
	</table>
</form>