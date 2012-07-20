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
				$("#mainDiv").renderUrl("${ctx}/project/main");
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
	$("#proTypeId").loadSelect({
		headValue : "", //默认的一个选项的值 eg 0
		headText : "请选择项目类型",//默认的一个选项的文本 eg 请选择
		data : null, //select中需要填充的数据，如果提供了该数据，则直接将这个数据填充到色了传统中，若未提供，则根据url去取
		params : {},//用于获得select中数据的地址
		url : "${ctx}/dict/projectProType",//用于获得select中数据的地址
		value : 'key', //取json数据data中，用于表示option的value属性的标示
		text : 'value',//取json数据data中，用于表示option的text属性的标示
		defaultValue : '${project.proType}',//默认被选中的值
		changeFn : null,//change事件
		fn : null//装载完以后调用的回调函数
	});
	$("#codeTypeId").loadSelect({
		headValue : "", //默认的一个选项的值 eg 0
		headText : "请选择代码类型",//默认的一个选项的文本 eg 请选择
		data : null, //select中需要填充的数据，如果提供了该数据，则直接将这个数据填充到色了传统中，若未提供，则根据url去取
		params : {},//用于获得select中数据的地址
		url : "${ctx}/dict/projectCodeType",//用于获得select中数据的地址
		value : 'key', //取json数据data中，用于表示option的value属性的标示
		text : 'value',//取json数据data中，用于表示option的text属性的标示
		defaultValue : '${project.codeType}',//默认被选中的值
		changeFn : null,//change事件
		fn : null//装载完以后调用的回调函数
	});
	$("#dbId").comboSelect({
		emptyText : "No Record",//默认没有搜索到结果的提示信息,
		url : "${ctx}/db/listDb",//搜索请求的地址
		keyword : "key", //搜索时关键字变量名
		value : 'id', //取json数据data中，用于表示option的value属性的标示
		text : 'name',//取json数据data中，用于表示option的text属性的标示
		currentText : "${project.db.name}", // 当前显示的字符串
		currentValue : "${project.db.id}"// 当前选中的值
	});
	$("#actionId").loadSelect({
		headValue : "", //默认的一个选项的值 eg 0
		headText : "请选择Action类型",//默认的一个选项的文本 eg 请选择
		data : null, //select中需要填充的数据，如果提供了该数据，则直接将这个数据填充到色了传统中，若未提供，则根据url去取
		params : {},//用于获得select中数据的地址
		url : "${ctx}/action/listAction",//用于获得select中数据的地址
		value : 'id', //取json数据data中，用于表示option的value属性的标示
		text : 'typeName',//取json数据data中，用于表示option的text属性的标示
		defaultValue : '${project.action.id}',//默认被选中的值
		changeFn : null,//change事件
		fn : null//装载完以后调用的回调函数
	});
	$("#daoId").loadSelect({
		headValue : "", //默认的一个选项的值 eg 0
		headText : "请选择Dao类型",//默认的一个选项的文本 eg 请选择
		data : null, //select中需要填充的数据，如果提供了该数据，则直接将这个数据填充到色了传统中，若未提供，则根据url去取
		params : {},//用于获得select中数据的地址
		url : "${ctx}/dao/listDao",//用于获得select中数据的地址
		value : 'id', //取json数据data中，用于表示option的value属性的标示
		text : 'typeName',//取json数据data中，用于表示option的text属性的标示
		defaultValue : '${project.dao.id}',//默认被选中的值
		changeFn : null,//change事件
		fn : null//装载完以后调用的回调函数
	});
	$("#securityId").loadSelect({
		headValue : "", //默认的一个选项的值 eg 0
		headText : "请选择Security类型",//默认的一个选项的文本 eg 请选择
		data : null, //select中需要填充的数据，如果提供了该数据，则直接将这个数据填充到色了传统中，若未提供，则根据url去取
		params : {},//用于获得select中数据的地址
		url : "${ctx}/security/listSecurity",//用于获得select中数据的地址
		value : 'id', //取json数据data中，用于表示option的value属性的标示
		text : 'typeName',//取json数据data中，用于表示option的text属性的标示
		defaultValue : '${project.security.id}',//默认被选中的值
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
		empty :false,onShow:"请输入1-50个字符",onFocus:"请输入1-50个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:1,max:50,onError:"请输入1-50个字符"
	});	
	$("#labelId").formValidator({
		empty :false,onShow:"请输入1-50个字符",onFocus:"请输入1-50个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:1,max:50,onError:"请输入1-50个字符"
	});	
	$("#orgId").formValidator({
		empty :false,onShow:"请输入1-50个字符",onFocus:"请输入1-50个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:1,max:50,onError:"请输入1-50个字符"
	});	
	$("#tablePreId").formValidator({
		onShow:"请输入0-50个字符",onFocus:"请输入0-50个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:0,max:50,onError:"请输入0-50个字符"
	});	
	$("#outputId").formValidator({
		onShow:"请输入0-250个字符",onFocus:"请输入0-250个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:0,max:250,onError:"请输入0-250个字符"
	});	
	$("#versionId").formValidator({
		onShow:"请输入0-250个字符",onFocus:"请输入0-250个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:0,max:250,onError:"请输入0-250个字符"
	});	
	$("#jdkVersionId").formValidator({
		onShow:"请输入0-250个字符",onFocus:"请输入0-250个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:0,max:250,onError:"请输入0-250个字符"
	});	
    $("#proTypeId").formValidator({
		onShow:"请输入0-250个字符",onFocus:"请输入0-250个字符",onCorrect:"恭喜您,输入正确"
	}) ;
    $("#codeTypeId").formValidator({
		onShow:"请输入0-250个字符",onFocus:"请输入0-250个字符",onCorrect:"恭喜您,输入正确"
	}) ;
});
</script>
<form  class="form" id="inputForm" method="post" action="${ctx }/project/save" >
	<input type="hidden" name="id" id="idId" value="${project.id}" />
	<table class="form-table" cellpadding="0" cellspacing="0">
		<tr> 
	      <td class="righttd">项目英文名:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="name" id="nameId" maxlength="50" value="${project.name}"/>
	      </td>
	      <td class="lefttd"><div id="nameIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">项目中文名:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="label" id="labelId" maxlength="50" value="${project.label}"/>
	      </td>
	      <td class="lefttd"><div id="labelIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">代码包组织:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="org" id="orgId" maxlength="50" value="${project.org}"/>
	      </td>
	      <td class="lefttd"><div id="orgIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">数据库表前缀:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="tablePre" id="tablePreId" maxlength="50" value="${project.tablePre}"/>
	      </td>
	      <td class="lefttd"><div id="tablePreIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">代码导出路径:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="output" id="outputId" maxlength="250" value="${project.output}"/>
	      </td>
	      <td class="lefttd"><div id="outputIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">版本号:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="version" id="versionId" maxlength="250" value="${project.version}"/>
	      </td>
	      <td class="lefttd"><div id="versionIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">JDK版本:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="jdkVersion" id="jdkVersionId" maxlength="250" value="${project.jdkVersion}"/>
	      </td>
	      <td class="lefttd"><div id="jdkVersionIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">是否具有tomcat插件:</td>
	      <td class="lefttd"  style="width:300px" >
			<input type="radio" name="needTomcatPlug" value="1" <c:if test="${project.needTomcatPlug}"> checked="checked"</c:if>>是</input>
		    <input type="radio" name="needTomcatPlug" value="0" <c:if test="${!project.needTomcatPlug}"> checked="checked"</c:if>>否</input>
	      </td>
	      <td class="lefttd"><div id="needTomcatPlugIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">项目类型:</td>
	      <td class="lefttd"  style="width:300px" >
			<select  style="width:280px;height:20px;" name="proType" id="proTypeId" >
				<option value="">请选择项目类型</option>
			</select>
	      </td>
	      <td class="lefttd"><div id="proTypeIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">代码类型:</td>
	      <td class="lefttd"  style="width:300px" >
			<select  style="width:280px;height:20px;" name="codeType" id="codeTypeId" >
				<option value="">请选择代码类型</option>
			</select>
	      </td>
	      <td class="lefttd"><div id="codeTypeIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">数据库:</td>
	      <td class="lefttd"  style="width:300px" >
	      	<input type="hidden" name="db.id" id="dbId" value="${project.db.id}"/>
	      </td>
	      <td class="lefttd"><div id="codeTypeIdTip" style="width:250px"></div></td>
	    </tr>
	    <tr> 
	      <td class="righttd">Action类型:</td>
	      <td class="lefttd"  style="width:300px" >
			<select  style="width:280px;height:20px;" name="action.id" id="actionId" >
				<option value="">请选择Action类型</option>
			</select>
	      </td>
	      <td class="lefttd"><div id="actionIdTip" style="width:250px"></div></td>
	    </tr>
	    <tr> 
	      <td class="righttd">Dao类型:</td>
	      <td class="lefttd"  style="width:300px" >
			<select  style="width:280px;height:20px;" name="dao.id" id="daoId" >
				<option value="">请选择Dao类型</option>
			</select>
	      </td>
	      <td class="lefttd"><div id="daoIdTip" style="width:250px"></div></td>
	    </tr>
	    <tr> 
	      <td class="righttd">Security类型:</td>
	      <td class="lefttd"  style="width:300px" >
			<select  style="width:280px;height:20px;" name="security.id" id="securityId" >
				<option value="">请选择Security类型</option>
			</select>
	      </td>
	      <td class="lefttd"><div id="securityIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd"></td>
	      <td colspan="2" class="lefttd">
	      <input type="button" id="saveBtn" value="保存" onclick="if($.formValidator.pageIsValid()) $('#inputForm').submit()" />
	      <input type="reset" id="resetBtn" value="重置" />
	      <input type="button" id="backToListBtn" onclick='javascript:$("#mainDiv").renderUrl("${ctx}/project/main");' value="返回列表" />
	      </td>
	    </tr>
	</table>
</form>