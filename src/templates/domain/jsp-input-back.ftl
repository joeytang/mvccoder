<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<#noparse>
$(document).ready(function(){
	$('#inputForm').ajaxForm({
		beforeSubmit : function(){},
		dataType : 'json',
		success : function(data){
			$.parseJsonResult(data,function(data){
				$.info("操作成功",function(){
					$("#mainDiv").renderUrl("${ctx}</#noparse><#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/security</#if>/${domain.lowerFirstName}/main<#if domain.many2OneOtherRelationField??>?${domain.many2OneOtherRelationField.name}.${project.domainMap[domain.many2OneOtherRelationField.entityName].id.name}=<#noparse>${</#noparse>${domain.lowerFirstName}.${domain.many2OneOtherRelationField.name}.${project.domainMap[domain.many2OneOtherRelationField.entityName].id.name}<#noparse>}</#noparse></#if>");
				});
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
	<#list domain.editableFields as f>
	<#if f.relationType!= statics["com.wanmei.domain.FieldHelper"].RELATION_TYPE_NONE && f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE && f.many2OneType==statics["com.wanmei.domain.FieldHelper"].MANY2ONETYPE_LIST>
	$("#select${f.name?cap_first}Id").click(function(){
		var $div = $("<div style='overflow: scroll;'></div>");
		$div.dialog({
			title : "选择${f.label}",
			href : "<#noparse>$</#noparse>{ctx}/${project.domainMap[f.entityName].lowerFirstName}/list",
			cache : false,
			collapsible : true,
			resizable : true,
			modal : true,
			width : 500,
			height : 500,
			onClose : function(){
				$div.dialog("destroy");
			},
			onLoad : function(){
				$div.find("#${project.domainMap[f.entityName].lowerFirstName}Table table").changeCheckTable();
			},
			buttons : [{
				text : "确认",
				handler : function(){
					var $ch = $div.find("#${project.domainMap[f.entityName].lowerFirstName}Table table input:checked");
					var $tr = $ch.closest("tr");
					$("#${f.name}Id").val($ch.val());
					$("#${f.name}Id").next("span").html($tr.find("td:eq(${f.many2OneOrder})").html());
					$div.dialog("destroy");
				}
			},{
				text : "关闭",
				handler : function(){
					$div.dialog("destroy");
				}
			}]
		});
	});
	<#elseif f.relationType!= statics["com.wanmei.domain.FieldHelper"].RELATION_TYPE_NONE && f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE && f.many2OneType==statics["com.wanmei.domain.FieldHelper"].MANY2ONETYPE_SELECT>
	$("#${f.name}Id").comboSelect({
		emptyText : "No Record",//默认没有搜索到结果的提示信息,
		url : "<#noparse>$</#noparse>{ctx}/${project.domainMap[f.entityName].lowerFirstName}/list${project.domainMap[f.entityName].name}",//搜索请求的地址
		keyword : "key", //搜索时关键字变量名
		value : '${project.domainMap[f.entityName].id.name}', //取json数据data中，用于表示option的value属性的标示
		text : '${f.many2OneName}',//取json数据data中，用于表示option的text属性的标示
		currentText : "<#noparse>$</#noparse>{${domain.lowerFirstName}.${f.name}.${f.many2OneName}}", // 当前显示的字符串
		currentValue : "<#noparse>$</#noparse>{${domain.lowerFirstName}.${f.name}.${project.domainMap[f.entityName].id.name}}",// 当前选中的值
		selectFn : function(v){//选择选项时触发函数，参数为该选项对应的后台传回的json对象
		},
		valueFn : function(json){//根据后台传回该行的json对象生成select对应option的value值.可以不用设置，默认为该方式实现
			return json[this.value];
		},
		textFn : function(json){//根据后台传回该行的json对象生成select对应option显示字符串.可以不用设置，默认为该方式实现
			return json[this.text];
		},
		fn:function(){//装载完成后执行函数.可以不用设置，默认为该方式实现
			//var json = {};
			//this.selectFn(json);
		}
	});
	<#elseif f.isDict>
	$("#${f.name}Id").loadSelect({
		<#if f.nullable>
		headValue : "", //默认的一个选项的值 eg 0
		headText : "请选择${f.label}",//默认的一个选项的文本 eg 请选择
	    </#if>
		data : null, //select中需要填充的数据，如果提供了该数据，则直接将这个数据填充到色了传统中，若未提供，则根据url去取
		params : {},//用于获得select中数据的地址
		url : "<#noparse>$</#noparse>{ctx}/dict/${domain.lowerFirstName}${f.name?cap_first}",//用于获得select中数据的地址
		value : 'key', //取json数据data中，用于表示option的value属性的标示
		text : 'value',//取json数据data中，用于表示option的text属性的标示
		defaultValue : '<#noparse>$</#noparse>{${domain.lowerFirstName}.${f.name}}',//默认被选中的值
		changeFn : function(obj){//change事件
		},
		fn : function(obj){//装载完以后调用的回调函数
			$(obj).change();
		}
	});
	</#if>
	</#list>
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
	<#list domain.editableFields as f>
	<#if f.isDict >
	$("#${f.name}Id").formValidator({
		<#if !f.nullable>empty :false,</#if>autoModify:true,onShow:"请选择${f.label}",onFocus:"请选择${f.label}",onCorrect:"恭喜您,操作正确"
	}).inputValidator({
		onError:"请选择${f.label}"
	});	
	<#elseif f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_INT ||  f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_LONG >
	$("#${f.name}Id").formValidator({
		<#if !f.nullable>empty :false,</#if>autoModify:true,onShow:"请输入0-1000之间整数",onFocus:"请输入0-1000之间整数",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		max:10000,type:"value",onError:"请输入0-1000之间整数"
	});
	<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_FLOAT) || (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_DOUBLE)>
	$("#${f.name}Id").formValidator({
		<#if !f.nullable>empty :false,</#if>autoModify:true,onShow:"请输入0-1000之间数字",onFocus:"请输入0-1000之间数字",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		max:10000,type:"value",onError:"请输入0-1000之间数字"
	});	
	<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_STRING)>	
		<#if domain.isUser && f.name == 'username'>
	var urlmsg = "该用户已经存在" ; 
	$("#usernameId").formValidator({
		empty:false,onShow:"请输入账号",onFocus:"请输入账号",onCorrect:"校验成功"
	}).inputValidator({
		min:1,max:50,onError:"长度在1-50之间，请确认" 
	}).ajaxValidator({
		dataType : "json",
		type : "POST",
		async : true,
		data : {id : '<c:if test="<#noparse>$</#noparse>{!empty user.id}"><#noparse>$</#noparse>{user.id}</c:if>'},
		url : "<#noparse>$</#noparse>{ctx}/user/checkUsername",
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
		<#else>
	$("#${f.name}Id").formValidator({
		<#if !f.nullable>empty :false,</#if>onShow:"请输入<#if f.nullable>0<#else>1</#if>-${(f.length?c)?default("250")}个字符",onFocus:"请输入<#if f.nullable>0<#else>1</#if>-${(f.length?c)?default("250")}个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:<#if f.nullable>0<#else>1</#if>,max:${(f.length?c)?default("250")},onError:"请输入<#if f.nullable>0<#else>1</#if>-${(f.length?c)?default("250")}个字符"
	});	
		</#if>
	<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_BOOLEAN)>		
    <#if (!f.nullable) >
    $("input[name='${f.name}").formValidator({
    	onShow:"请选择${f.label}",onFocus:"请选择${f.label}"
    }).inputValidator({
    	min:1,max:1,onError:"至少选择一个，且最多选择一个"
    });
    </#if>
	<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_TEXT)>
    $("#${f.name}Id").formValidator({
		<#if !f.nullable>empty :false,</#if>onShow:"请输入<#if f.nullable>0<#else>1</#if>-${(f.length?c)?default("65500")}个字符",onFocus:"请输入<#if f.nullable>0<#else>1</#if>-${(f.length?c)?default("65500")}个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:<#if f.nullable>0<#else>1</#if>,max:${(f.length?c)?default("65500")},onError:"请输入<#if f.nullable>0<#else>1</#if>-${(f.length?c)?default("65500")}个字符"
	});
	<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_FILE)>
	<#if !f.nullable>
	<c:if test="<#noparse>$</#noparse>{${domain.lowerFirstName}.${domain.id.name} == null}">
    $("#${f.name}Id").formValidator({
		<#if !f.nullable>empty :false,</#if>onShow:"请选择文件"
	}).inputValidator({
		min:<#if f.nullable>0<#else>1</#if>,max:${(f.length?c)?default("250")},onError:"请选择文件"
	});	
	</c:if>
	</#if>
	<#else>
    $("#${f.name}Id").formValidator({
		<#if !f.nullable>empty :false,</#if>onShow:"请输入<#if f.nullable>0<#else>1</#if>-${(f.length?c)?default("250")}个字符",onFocus:"请输入<#if f.nullable>0<#else>1</#if>-${(f.length?c)?default("250")}个字符",onCorrect:"恭喜您,输入正确"
	}).inputValidator({
		min:<#if f.nullable>0<#else>1</#if>,max:${(f.length?c)?default("250")},onError:"请输入<#if f.nullable>0<#else>1</#if>-${(f.length?c)?default("250")}个字符"
	});
	</#if>
	</#list>
});
</script>
<form  class="form" id="inputForm" method="post" action="<#noparse>$</#noparse>{ctx }<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/security</#if>/${domain.lowerFirstName}/save" <#if domain.isMultipart>enctype="multipart/form-data"</#if>>
	<#if (domain.id.type!=statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>
	<input type="hidden" name="${domain.id.name}" id="${domain.id.name}Id" value="<#noparse>${</#noparse>${domain.lowerFirstName}.${domain.id.name}<#noparse>}</#noparse>" />
	</#if>
	<#list domain.one2ManyRelationFields as f >
	<input type="hidden" name="${f.name}.${project.domainMap[f.entityName].id.name}" id="${f.name}Id" value="<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}.${project.domainMap[f.entityName].id.name}<#noparse>}</#noparse>"/>
	</#list>
	<table class="form-table" cellpadding="0" cellspacing="0">
	<#list domain.editSortField as f>
		<tr> 
	      <td class="righttd">${f.label}:</td>
	      <td class="lefttd"  style="width:300px" >
			<#if f.relationType== statics["com.wanmei.domain.FieldHelper"].RELATION_TYPE_SELF && f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE && f.many2OneType==statics["com.wanmei.domain.FieldHelper"].MANY2ONETYPE_LIST>
			<input class="input" style="width:280px;height:20px;" type="hidden" name="${f.name}.${project.domainMap[f.entityName].id.name}" id="${f.name}Id" value="<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}.${project.domainMap[f.entityName].id.name}<#noparse>}</#noparse>"/>
			<span><#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}.${f.many2OneName}}</span>
			<input type="button" id="select${f.name?cap_first}Id" value="选择"/>
			<#elseif f.relationType== statics["com.wanmei.domain.FieldHelper"].RELATION_TYPE_SELF && f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE && f.many2OneType==statics["com.wanmei.domain.FieldHelper"].MANY2ONETYPE_SELECT>
			<input type="hidden" name="${f.name}.${project.domainMap[f.entityName].id.name}" id="${f.name}Id" value="<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}.${project.domainMap[f.entityName].id.name}<#noparse>}</#noparse>"/>
			<#elseif f.isDict>
			<select  style="width:280px;height:20px;" name="${f.name}" id="${f.name}Id" >
			   <#if f.nullable>
				<option value="">请选择${f.label}</option>
			   </#if>
			</select>
			<#elseif f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_DATE>
			<input class="input" type="text" name="${f.name}" id="${f.name}Id" size="30" maxlength="50" class="Wdate" style="width:280px;height:20px;color:#000000;" onfocus="javascript:WdatePicker({dateFmt:'yyyy-MM-dd', isShowWeek:true, readOnly:true});" value="<fmt:formatDate value='<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}<#noparse>}</#noparse>' pattern='yyyy-MM-dd'/>"/>
			<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_DATETIME)>		
			<input class="input" type="text" name="${f.name}" id="${f.name}Id" size="30" maxlength="50" class="Wdate" style="width:280px;height:20px;color:#000000;" onfocus="javascript:WdatePicker({dateFmt:'yyyy-MM-dd HH:mm', isShowWeek:true, readOnly:true});" value="<fmt:formatDate value='<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}<#noparse>}</#noparse>' pattern='yyyy-MM-dd HH:mm'/>"/>
			<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_FILE)>		
			<input class="input" type="file" name="${f.name}File" id="${f.name}FileId" style="width:280px;height:20px;" />
			<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_BOOLEAN)>		
			<input type="radio" name="${f.name}" value="1" <c:if test="<#noparse>$</#noparse>{${domain.lowerFirstName}.${f.name}}"> checked="checked"</c:if>>是</input>
		    <input type="radio" name="${f.name}" value="0" <c:if test="<#noparse>$</#noparse>{!${domain.lowerFirstName}.${f.name}}"> checked="checked"</c:if>>否</input>
			<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_STRING)>		
			<#if domain.isUser && f.name == 'role'>
			<select  style="width:280px;height:20px;" name="${f.name}" id="${f.name}Id" >
			</select>
			<#else>
				<#assign inId=false>
				<#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>
				<#list project.domainMap[domain.id.entityName].fields as ff>
				<#if ff.name == f.name>
				<#assign inId=true>
		     	</#if>
				</#list>
		     	</#if>
		     	<#if inId>
		     <c:if test="<#noparse>$</#noparse>{null != ${domain.id.name}}">
				<input type="hidden" name="${domain.id.name}.${f.name}" value="<#noparse>$</#noparse>{${domain.lowerFirstName}.${domain.id.name}.${f.name}}" />
				<input type="hidden" name="${f.name}" id="${f.name}Id" value="<#noparse>$</#noparse>{${domain.lowerFirstName}.${domain.id.name}.${f.name}}" />
				<#noparse>$</#noparse>{${domain.lowerFirstName}.${domain.id.name}.${f.name}}
		    </c:if>
		     <c:if test="<#noparse>$</#noparse>{null == ${domain.id.name}}">
				<input class="input" style="width:280px;height:20px;" type="text" name="${f.name}" id="${f.name}Id" maxlength="${(f.length?c)?default("250")}" value="<#noparse>${</#noparse>${domain.lowerFirstName}.${domain.id.name}.${f.name}<#noparse>}</#noparse>"/>
		     </c:if>
				<#else>
			<input class="input" style="width:280px;height:20px;" type="text" name="${f.name}" id="${f.name}Id" maxlength="${(f.length?c)?default("250")}" value="<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}<#noparse>}</#noparse>"/>
				</#if>
			</#if>
			<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_TEXT)>
			<textarea class="textarea" style="width:280px;height:100px;" name="${f.name}" id="${f.name}Id"><#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}<#noparse>}</#noparse></textarea>		
			<#else>
				<#assign inId=false>
				<#if (domain.id.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE)>
				<#list project.domainMap[domain.id.entityName].fields as ff>
				<#if ff.name == f.name>
				<#assign inId=true>
		     	</#if>
				</#list>
		     	</#if>
		     	<#if inId>
		     <c:if test="<#noparse>$</#noparse>{null != ${domain.id.name}}">
		     	<input type="hidden" name="${domain.id.name}.${f.name}" value="<#noparse>$</#noparse>{${domain.lowerFirstName}.${domain.id.name}.${f.name}}" />
				<input type="hidden" name="${f.name}" id="${f.name}Id" value="<#noparse>$</#noparse>{${domain.lowerFirstName}.${domain.id.name}.${f.name}}" />
				<#noparse>$</#noparse>{${domain.lowerFirstName}.${domain.id.name}.${f.name}}
		    </c:if>
		     <c:if test="<#noparse>$</#noparse>{null == ${domain.id.name}}">
				<input class="input" style="width:280px;height:20px;" type="text" name="${f.name}" id="${f.name}Id" maxlength="${(f.length?c)?default("250")}" value="<#noparse>${</#noparse>${domain.lowerFirstName}.${domain.id.name}.${f.name}<#noparse>}</#noparse>"/>
		     </c:if>
				<#else>
			<input class="input" style="width:280px;height:20px;" type="text" name="${f.name}" id="${f.name}Id" maxlength="${(f.length?c)?default("250")}" value="<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}<#noparse>}</#noparse>"/>
				</#if>
			</#if>
	      </td>
	      <td class="lefttd"><div id="${f.name}IdTip" style="width:250px"></div></td>
	    </tr>
	</#list>
		<tr> 
	      <td class="righttd"></td>
	      <td colspan="2" class="lefttd">
	      <input type="button" id="saveBtn" value="保存" onclick="if($.formValidator.pageIsValid()) $('#inputForm').submit()" />
	      <input type="reset" id="resetBtn" value="重置" />
	      <input type="button" id="backToListBtn" onclick='javascript:$("#mainDiv").renderUrl("<#noparse>${ctx}</#noparse><#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/security</#if>/${domain.lowerFirstName}/main<#if domain.many2OneOtherRelationField??>?${domain.many2OneOtherRelationField.name}.${project.domainMap[domain.many2OneOtherRelationField.entityName].id.name}=<#noparse>${</#noparse>${domain.lowerFirstName}.${domain.many2OneOtherRelationField.name}.${project.domainMap[domain.many2OneOtherRelationField.entityName].id.name}<#noparse>}</#noparse></#if>");' value="返回列表" />
	      </td>
	    </tr>
	</table>
</form>