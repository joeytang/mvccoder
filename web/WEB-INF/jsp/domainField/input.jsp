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
				$("#mainDiv").renderUrl("${ctx}/domainField/main/${domainField.domain.idkey}");
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
	$("#fieldId").comboSelect({
		emptyText : "No Record",//默认没有搜索到结果的提示信息,
		url : "${ctx}/field/listField",//搜索请求的地址
		keyword : "key", //搜索时关键字变量名
		value : 'id', //取json数据data中，用于表示option的value属性的标示
		text : 'name',//取json数据data中，用于表示option的text属性的标示
		currentText : "${domainField.field.name}", // 当前显示的字符串
		currentValue : "${domainField.field.id}",// 当前选中的值
		selectFn : function(v){
			var t = v.type;
			if(t=="${g:var('com.wanmei.domain.FieldHelper','TYPE_MANY2ONE')}" ){
				$(".rela,.many2one").show();
			}else if(t=="${g:var('com.wanmei.domain.FieldHelper','TYPE_MANY2MANY')}"){
				$(".rela").show();
			}
		},
		valueFn : function(json){
			return json[this.value];
		},
		textFn : function(json){
			return json[this.text];
		},
		fn:function(){
			var json = {};
			json["id"] = "${domainField.field.id}";
			json["name"] = "${domainField.field.id}";
			json["type"] = "${domainField.field.type}";
			this.selectFn(json);
		}
	});
	$("#relationTypeId").loadSelect({
		headValue : "0", //默认的一个选项的值 eg 0
		headText : "请选择关联类型",//默认的一个选项的文本 eg 请选择
		data : null, //select中需要填充的数据，如果提供了该数据，则直接将这个数据填充到色了传统中，若未提供，则根据url去取
		params : {},//用于获得select中数据的地址
		url : "${ctx}/dict/relationType",//用于获得select中数据的地址
		value : 'key', //取json数据data中，用于表示option的value属性的标示
		text : 'value',//取json数据data中，用于表示option的text属性的标示
		defaultValue : '${domainField.relationType}',//默认被选中的值
		changeFn : function(obj){
			var v = $(obj).val();
			$(".many2onetype").hide();
			$(".listOne").hide();
			if(v == "${g:var('com.wanmei.domain.FieldHelper','RELATION_TYPE_SELF')}"){
				$(".many2one").show();
				$(".listOne").show();
				$(".many2onetype").show();
			}
		},//change事件
		fn : function(obj){//装载完以后调用的回调函数
			$(obj).change();
		}
	});
	$("#many2OneTypeId").loadSelect({
		headValue : "0", //默认的一个选项的值 eg 0
		headText : "请选择多对一类型",//默认的一个选项的文本 eg 请选择
		data : null, //select中需要填充的数据，如果提供了该数据，则直接将这个数据填充到色了传统中，若未提供，则根据url去取
		params : {},//用于获得select中数据的地址
		url : "${ctx}/dict/many2OneType",//用于获得select中数据的地址
		value : 'key', //取json数据data中，用于表示option的value属性的标示
		text : 'value',//取json数据data中，用于表示option的text属性的标示
		defaultValue : '${domainField.many2OneType}',//默认被选中的值
		changeFn : function(obj){
			var v = $(obj).val();
			if(v == "${g:var('com.wanmei.domain.FieldHelper','MANY2ONETYPE_LIST')}" && $("#relationTypeId").val() == "${g:var('com.wanmei.domain.FieldHelper','RELATION_TYPE_SELF')}"){
				$(".listOne").show();
			}else if(v == "${g:var('com.wanmei.domain.FieldHelper','MANY2ONETYPE_SELECT')}"){
				$(".listOne").hide();
			}
		},//change事件
		fn : function(obj){//装载完以后调用的回调函数
			$(obj).change();
		}
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
	$("#listOrderId").formValidator({
		autoModify:true,onShow:"请输入0-1000之间整数",onFocus:"请输入0-1000之间整数",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		max:10000,type:"value",onError:"请输入0-1000之间整数"
	});
	$("#editOrderId").formValidator({
		autoModify:true,onShow:"请输入0-1000之间整数",onFocus:"请输入0-1000之间整数",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		max:10000,type:"value",onError:"请输入0-1000之间整数"
	});
	$("#viewOrderId").formValidator({
		autoModify:true,onShow:"请输入0-1000之间整数",onFocus:"请输入0-1000之间整数",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		max:10000,type:"value",onError:"请输入0-1000之间整数"
	});
	$("#searchOrderId").formValidator({
		autoModify:true,onShow:"请输入0-1000之间整数",onFocus:"请输入0-1000之间整数",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		max:10000,type:"value",onError:"请输入0-1000之间整数"
	});
});
</script>
<form  class="form" id="inputForm" method="post" action="${ctx }/domainField/save" >
	<input type="hidden" name="id" id="idId" value="${domainField.id}" />
	<input type="hidden" name="domain.idkey" id="domainId" value="${domainField.domain.idkey}" />
	<table class="form-table" cellpadding="0" cellspacing="0">
		<tr> 
	      <td class="righttd">选择列:</td>
	      <td class="lefttd"  style="width:300px" >
	      <input type="hidden" name="field.id" id="fieldId" value="${domainField.field.id}"/>
	      </td>
	      <td class="lefttd"><div id="fieldIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">是否可以为空:</td>
	      <td class="lefttd"  style="width:300px" >
			<input type="radio" name="nullable" value="1" <c:if test="${domainField.nullable}"> checked="checked"</c:if>>是</input>
		    <input type="radio" name="nullable" value="0" <c:if test="${!domainField.nullable}"> checked="checked"</c:if>>否</input>
	      </td>
	      <td class="lefttd"><div id="nullableIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">是否在列表中显示:</td>
	      <td class="lefttd"  style="width:300px" >
			<input type="radio" name="listable" value="1" <c:if test="${domainField.listable}"> checked="checked"</c:if>>是</input>
		    <input type="radio" name="listable" value="0" <c:if test="${!domainField.listable}"> checked="checked"</c:if>>否</input>
	      </td>
	      <td class="lefttd"><div id="listableIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">是否在修改中显示:</td>
	      <td class="lefttd"  style="width:300px" >
			<input type="radio" name="editable" value="1" <c:if test="${domainField.editable}"> checked="checked"</c:if>>是</input>
		    <input type="radio" name="editable" value="0" <c:if test="${!domainField.editable}"> checked="checked"</c:if>>否</input>
	      </td>
	      <td class="lefttd"><div id="editableIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">是否在hbm文件中显示:</td>
	      <td class="lefttd"  style="width:300px" >
			<input type="radio" name="hbmable" value="1" <c:if test="${domainField.hbmable}"> checked="checked"</c:if>>是</input>
		    <input type="radio" name="hbmable" value="0" <c:if test="${!domainField.hbmable}"> checked="checked"</c:if>>否</input>
	      </td>
	      <td class="lefttd"><div id="hbmableIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">是否在详情中显示:</td>
	      <td class="lefttd"  style="width:300px"  >
			<input type="radio" name="viewable" value="1" <c:if test="${domainField.viewable}"> checked="checked"</c:if>>是</input>
		    <input type="radio" name="viewable" value="0" <c:if test="${!domainField.viewable}"> checked="checked"</c:if>>否</input>
	      </td>
	      <td class="lefttd"><div id="viewableIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">是否在搜索条件中显示:</td>
	      <td class="lefttd"  style="width:300px" >
			<input type="radio" name="searchable" value="1" <c:if test="${domainField.searchable}"> checked="checked"</c:if>>是</input>
		    <input type="radio" name="searchable" value="0" <c:if test="${!domainField.searchable}"> checked="checked"</c:if>>否</input>
	      </td>
	      <td class="lefttd"><div id="searchableIdTip" style="width:250px"></div></td>
	    </tr>
		<tr  class="rela" style="display:none;"> 
	      <td class="righttd">维护关联关系类型:</td>
	      <td class="lefttd"  style="width:300px" >
	      <select  style="width:280px;height:20px;" name="relationType" id="relationTypeId" >
			</select>
	      </td>
	      <td class="lefttd"><div id="relationTypeIdTip" style="width:250px"></div></td>
	    </tr>
	    <tr class="many2one many2onetype" style="display:none;"> 
	      <td class="righttd">多对一关联显示类型:</td>
	      <td class="lefttd"  style="width:300px" >
			<select  style="width:280px;height:20px;" name="many2OneType" id="many2OneTypeId" >
			</select>
	      </td>
	      <td class="lefttd"><div id="many2OneTypeIdTip" style="width:250px"></div></td>
	    </tr>
		<tr class="many2one listOne" style="display:none;"> 
	      <td class="righttd">显示关联对象属性在列表中列序号从0开始:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="many2OneOrder" id="many2OneOrderId" value="${domainField.many2OneOrder}"/>
	      </td>
	      <td class="lefttd"><div id="many2OneOrderIdTip" style="width:250px"></div></td>
	    </tr>
		<tr class="many2one" style="display:none;">
	      <td class="righttd">显示关联对象属性名:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="many2OneName" id="many2OneNameId" value="${domainField.many2OneName}"/>
	      </td>
	      <td class="lefttd"><div id="many2OneNameIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">是否在列表中可排序:</td>
	      <td class="lefttd"  style="width:300px" >
			<input type="radio" name="sortable" value="1" <c:if test="${domainField.sortable}"> checked="checked"</c:if>>是</input>
		    <input type="radio" name="sortable" value="0" <c:if test="${!domainField.sortable}"> checked="checked"</c:if>>否</input>
	      </td>
	      <td class="lefttd"><div id="sortableIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">列表中顺序:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="listOrder" id="listOrderId" value="<c:if test='${domainField.id != null}'>${domainField.listOrder}</c:if><c:if test='${domainField.id == null}'>${count}</c:if>"/>
	      </td>
	      <td class="lefttd"><div id="listOrderIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">修改中顺序:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="editOrder" id="editOrderId" value="<c:if test='${domainField.id != null}'>${domainField.editOrder}</c:if><c:if test='${domainField.id == null}'>${count}</c:if>"/>
	      </td>
	      <td class="lefttd"><div id="editOrderIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">详情中顺序:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="viewOrder" id="viewOrderId" value="<c:if test='${domainField.id != null}'>${domainField.viewOrder}</c:if><c:if test='${domainField.id == null}'>${count}</c:if>"/>
	      </td>
	      <td class="lefttd"><div id="viewOrderIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd">搜索条件中顺序:</td>
	      <td class="lefttd"  style="width:300px" >
			<input class="input" style="width:280px;height:20px;" type="text" name="searchOrder" id="searchOrderId" value="<c:if test='${domainField.id != null}'>${domainField.searchOrder}</c:if><c:if test='${domainField.id == null}'>${count}</c:if>"/>
	      </td>
	      <td class="lefttd"><div id="searchOrderIdTip" style="width:250px"></div></td>
	    </tr>
		<tr> 
	      <td class="righttd"></td>
	      <td colspan="2" class="lefttd">
	      <input type="button" id="saveBtn" value="保存" onclick="if($.formValidator.pageIsValid()) $('#inputForm').submit()" />
	      <input type="reset" id="resetBtn" value="重置" />
	      <input type="button" id="backToListBtn" onclick='javascript:$("#mainDiv").renderUrl("${ctx}/domainField/main/${domainField.domain.idkey}");' value="返回列表" />
	      </td>
	    </tr>
	</table>
</form>