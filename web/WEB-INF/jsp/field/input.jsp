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
				$("#mainDiv").renderUrl("${ctx}/field/main");
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
	$("#typeId").loadSelect({
		data : null, //select中需要填充的数据，如果提供了该数据，则直接将这个数据填充到色了传统中，若未提供，则根据url去取
		params : {},//用于获得select中数据的地址
		url : "${ctx}/dict/fieldType",//用于获得select中数据的地址
		value : 'key', //取json数据data中，用于表示option的value属性的标示
		text : 'value',//取json数据data中，用于表示option的text属性的标示
		defaultValue : '${field.type}',//默认被选中的值
		changeFn : function(obj){
			$(".sp").hide();
			var v = $(obj).val();
			if(v == "${g:var('com.wanmei.domain.FieldHelper','TYPE_MANY2ONE')}"){
				$(".many2one").show();
			}else if(v == "${g:var('com.wanmei.domain.FieldHelper','TYPE_ONE2MANY')}"){
				$(".one2many").show();
			}else if(v == "${g:var('com.wanmei.domain.FieldHelper','TYPE_MANY2MANY')}"){
				$(".many2many").show();
			}else{
				$(".comm").show();
			}
		},//change事件
		fn : function(obj){//装载完以后调用的回调函数
			$(obj).change();
		}
	});
	$("#categoryId").loadSelect({
		data : null, //select中需要填充的数据，如果提供了该数据，则直接将这个数据填充到色了传统中，若未提供，则根据url去取
		params : {},//用于获得select中数据的地址
		url : "${ctx}/dict/categoryType",//用于获得select中数据的地址
		value : 'key', //取json数据data中，用于表示option的value属性的标示
		text : 'value',//取json数据data中，用于表示option的text属性的标示
		defaultValue : '${field.category}',//默认被选中的值
		changeFn : null,//change事件
		fn : null//装载完以后调用的回调函数
	});
	$("#entityNameId").comboSelect({
		emptyText : "No Record",//默认没有搜索到结果的提示信息,
		url : "${ctx}/domain/listDomain",//搜索请求的地址
		keyword : "key", //搜索时关键字变量名
		value : 'name', //取json数据data中，用于表示option的value属性的标示
		text : 'name',//取json数据data中，用于表示option的text属.性的标示
		currentText : "<c:if test='${field.entityName != null && field.entityPackage!= null}'>${field.entityPackage}.${field.entityName}</c:if>", // 当前显示的字符串
		currentValue : "<c:if test='${field.entityName != null && field.entityPackage!= null}'>${field.entityPackage}.${field.entityName}</c:if>",// 当前选中的值
		valueFn : function(json){//根据传递后台传回该行的json对象生成select对应option的value值
			return json[this.value];
		},
		textFn : function(json){//根据传递后台传回该行的json对象生成select对应option显示字符串
			return json['packageName']+"."+json[this.text];
		}
	});
	$("#entityPackageId").comboSelect({
		emptyText : "No Record",//默认没有搜索到结果的提示信息,
		url : "${ctx}/domain/listDomainPackageName",//搜索请求的地址
		keyword : "key", //搜索时关键字变量名
		value : 'packageName', //取json数据data中，用于表示option的value属性的标示
		text : 'packageName',//取json数据data中，用于表示option的text属性的标示
		currentText : "${field.entityPackage}", // 当前显示的字符串
		currentValue : "${field.entityPackage}"// 当前选中的值
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
	 $("#categoryId").formValidator({
			empty :false,onShow:"请输入1-250个字符",onFocus:"请输入1-250个字符",onCorrect:"恭喜您,输入正确"
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
	$("#descriptionId").formValidator({
		onShow:"请输入0-250个字符",onFocus:"请输入0-250个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:0,max:250,onError:"请输入0-250个字符"
	});	
   
    $("#typeId").formValidator({
		empty :false,onShow:"请输入1-250个字符",onFocus:"请输入1-250个字符",onCorrect:"恭喜您,输入正确"
	});
	$("#tableId").formValidator({
		onShow:"请输入0-20个字符",onFocus:"请输入0-20个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:0,max:20,onError:"请输入0-20个字符"
	});	
	$("#columnId").formValidator({
		onShow:"请输入0-20个字符",onFocus:"请输入0-20个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:0,max:20,onError:"请输入0-20个字符"
	});	
	$("#manyColumnId").formValidator({
		onShow:"请输入0-20个字符",onFocus:"请输入0-20个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:0,max:20,onError:"请输入0-20个字符"
	});	
	$("#lengthId").formValidator({
		autoModify:true,onShow:"请输入0-1000之间整数",onFocus:"请输入0-1000之间整数",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		max:10000,type:"value",onError:"请输入0-1000之间整数"
	});
	$("#entityNameId").formValidator({
		onShow:"请输入0-250个字符",onFocus:"请输入0-250个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:0,max:250,onError:"请输入0-250个字符"
	});	
	$("#entityPackageId").formValidator({
		onShow:"请输入0-250个字符",onFocus:"请输入0-250个字符",onCorrect:"恭喜您,输入正确"
	}) ;	
});
</script>
<form  class="form" id="inputForm" method="post" action="${ctx }/field/save" >
	<input type="hidden" name="id" id="idId" value="${field.id}" />
	<table class="form-table" cellpadding="0" cellspacing="0">
		<tr> 
	      <td class="righttd">字段类型:</td>
	      <td class="lefttd"  style="width:300px" >
			<select  style="width:280px;height:20px;" name="category" id="categoryId" >
			</select>
	      </td>
	      <td class="lefttd"><div id="categoryIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">列英文名:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="name" id="nameId" maxlength="20" value="${field.name}"/>
	      </td>
	      <td class="lefttd"><div id="nameIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">列中文名:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="label" id="labelId" maxlength="20" value="${field.label}"/>
	      </td>
	      <td class="lefttd"><div id="labelIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">模块描述:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="description" id="descriptionId" maxlength="250" value="${field.description}"/>
	      </td>
	      <td class="lefttd"><div id="descriptionIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">字段数据类型:</td>
	      <td class="lefttd"  style="width:300px" >
			<select  style="width:280px;height:20px;" name="type" id="typeId" >
			</select>
	      </td>
	      <td class="lefttd"><div id="typeIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">是否字典:</td>
	      <td class="lefttd"  style="width:300px" >
	      <input type="radio" name="isDict" value="1" <c:if test="${field.isDict}"> checked="checked"</c:if>>是</input>
		  <input type="radio" name="isDict" value="0" <c:if test="${!field.isDict}"> checked="checked"</c:if>>否</input>
	      </td>
	      <td class="lefttd"><div id="isDictIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">长度限制:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="length" id="lengthId" value="${field.length}"/>
	      </td>
	      <td class="lefttd"><div id="lengthIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">对应列名（或关联多时列名）:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="column" id="columnId" maxlength="20" value="${field.column}"/>
	      </td>
	      <td class="lefttd"><div id="columnIdTip" style="width:250px"></div></td>
	    </tr>
		<tr class="sp many2many one2many " style="display:none;"> 
	      <td class="righttd">对应表名:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="table" id="tableId" maxlength="20" value="${field.table}"/>
	      </td>
	      <td class="lefttd"><div id="tableIdTip" style="width:250px"></div></td>
	    </tr>
		<tr class="sp many2many" style="display:none;"> 
	      <td class="righttd">对多时列名(被关联的列):</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="manyColumn" id="manyColumnId" maxlength="20" value="${field.manyColumn}"/>
	      </td>
	      <td class="lefttd"><div id="manyColumnIdTip" style="width:250px"></div></td>
	    </tr>
		<tr class="sp many2one many2many one2many " style="display:none;"> 
	      <td class="righttd">关联对象名:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="hidden" style="width:280px;height:20px;" type="text" name="entityName" id="entityNameId" maxlength="250" value="${field.entityName}"/>
	      </td>
	      <td class="lefttd"><div id="entityNameIdTip" style="width:250px"></div></td>
	    </tr>
		<tr class="sp many2one many2many one2many " style="display:none;"> 
	      <td class="righttd">关联对象包名:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="hidden" style="width:280px;height:20px;" type="text" name="entityPackage" id="entityPackageId" maxlength="250" value="${field.entityPackage}"/>
	      </td>
	      <td class="lefttd"><div id="entityPackageIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd"></td>
	      <td colspan="2" class="lefttd">
	      <input type="button" id="saveBtn" value="保存" onclick="if($.formValidator.pageIsValid()) $('#inputForm').submit()" />
	      <input type="reset" id="resetBtn" value="重置" />
	      <input type="button" id="backToListBtn" onclick='javascript:$("#mainDiv").renderUrl("${ctx}/field/main");' value="返回列表" />
	      </td>
	    </tr>
	</table>
</form>