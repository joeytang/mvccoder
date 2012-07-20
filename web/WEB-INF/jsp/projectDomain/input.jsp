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
				$("#mainDiv").renderUrl("${ctx}/projectDomain/main/${projectDomain.project.id}");
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
	$("#domainId").comboSelect({
		emptyText : "No Record",//默认没有搜索到结果的提示信息,
		url : "${ctx}/domain/listDomain",//搜索请求的地址
		keyword : "key", //搜索时关键字变量名
		value : 'idkey', //取json数据data中，用于表示option的value属性的标示
		text : 'name',//取json数据data中，用于表示option的text属性的标示
		currentText : "${projectDomain.domain.name}", // 当前显示的字符串
		currentValue : "${projectDomain.domain.idkey}"// 当前选中的值
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
	$("#menuOrderId").formValidator({
		autoModify:true,onShow:"请输入0-1000之间整数",onFocus:"请输入0-1000之间整数",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		max:10000,type:"value",onError:"请输入0-1000之间整数"
	});
});
</script>
<form  class="form" id="inputForm" method="post" action="${ctx }/projectDomain/save" >
	<input type="hidden" name="id" id="idId" value="${projectDomain.id}" />
	<input type="hidden" name="project.id" id="projectId" value="${projectDomain.project.id}" />
	<table class="form-table" cellpadding="0" cellspacing="0">
		<tr> 
	      <td class="righttd">选择模块:</td>
	      <td class="lefttd"  style="width:300px" >
	      <input type="hidden" name="domain.idkey" id="domainId" value="${projectDomain.domain.idkey}"/>
	      </td>
	      <td class="lefttd"><div id="domainIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">菜单排序:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="menuOrder" id="menuOrderId" value="<c:if test='${projectDomain.id != null}'>${projectDomain.menuOrder}</c:if><c:if test='${projectDomain.id == null}'>${count}</c:if>"/>
	      </td>
	      <td class="lefttd"><div id="menuOrderIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd"></td>
	      <td colspan="2" class="lefttd">
	      <input type="button" id="saveBtn" value="保存" onclick="if($.formValidator.pageIsValid()) $('#inputForm').submit()" />
	      <input type="reset" id="resetBtn" value="重置" />
	      <input type="button" id="backToListBtn" onclick='javascript:$("#mainDiv").renderUrl("${ctx}/projectDomain/main/${projectDomain.project.id}");' value="返回列表" />
	      </td>
	    </tr>
	</table>
</form>