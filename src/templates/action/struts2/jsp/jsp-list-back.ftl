<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/admin/common/taglibs.jsp"%>
<html>
<head>
<%@ include file="/admin/common/meta.jsp"%>
<script type="text/javascript">
var url;
<#noparse>
$(document).ready(function(){
	$('#tableId').datagrid({
    	onLoadSuccess : EventFun.error,
    	onLoadError : EventFun.error
     });
    $('#tableId').datagrid('getPager').pagination({displayMsg:'当前显示从{from}到{to}共{total}记录'});
});
function create(){
	//$('#formDilogId').dialog("refresh","${ctx}</#noparse>/security/${domain.domainName?uncap_first}/input.html");
	<#noparse>$('#formDilogId').dialog('open').dialog('setTitle','添加数据');
	$('#inputForm').form('clear');
	url = '${ctx}</#noparse>/security/${domain.domainName?uncap_first}/save.html?r='+Math.random();
}
function edit(){
	var row = $('#tableId').datagrid('getSelected');
	if (row){
		<#noparse>//$('#formDilogId').dialog("refresh","${ctx}</#noparse>/security/${domain.domainName?uncap_first}/input.html?${domain.idName}="+row.${domain.idName});
		<#noparse>$('#formDilogId').dialog('open').dialog('setTitle','修改数据');
		//$('#inputForm').form('load','${ctx}</#noparse>/security/${domain.domainName?uncap_first}/loadOneData.html?r='+Math.random()+'&${domain.idName}='+row.${domain.idName});
		
		if(row.createdate){
			row.createdate = DateParser.format(new Date(row.createdate.time),"yyyy-MM-dd HH:mm:ss");
		}
		
		<#noparse>$('#inputForm').form('load',row);
		url = '${ctx}/</#noparse>security/${domain.domainName?uncap_first}/save.html?r='+Math.random()+'&${domain.idName}='+row.${domain.idName};
	}
}<#noparse>
function save(){
	$('#inputForm').form('submit',{
		url: url,
		onSubmit: function(){
			return $(this).form('validate');
		},
		success: function(data){
			var data = eval('('+data+')');
			if (data.result == "success"){
				$('#formDilogId').dialog('close');		// close the dialog
				$('#tableId').datagrid('reload');	// reload the user data
			} else {
				$.messager.$.info('错误',data.error,"error");
			}
		}
	});
	//$('#inputForm').submit();
}
function remove(){
	var row = $('#tableId').datagrid('getSelections');
	if (row){
		$.messager.confirm('Confirm','确认删除记录?',function(r){
			if (r){
			    var o = "&r="+Math.random();
			    $.each(row,function(i){</#noparse>
			    	o += "&ids="+this.${domain.idName}
			    });
				$.ajax( {
					url : "<#noparse>${ctx}</#noparse>/security/${domain.domainName?uncap_first}/removeMore.html",
					data : o ,
					type  :'POST',
					dataType :'json',
					beforeSend : function() {
					},
					success : function(data) {
						if (data.result == "success"){<#noparse>
							$('#tableId').datagrid('reload');	// reload the user data
						} else {
							$.messager.$.info('错误',data.error,"error");
						}
					},
			        error:function(rs) {
			        }
				});
			}
		});
	}
}
function searcher(value , name){
	$('#tableId').datagrid("load",{
		searchValue:value,
		searchName:name
	});
}
</script>
</head>
<body>
<table id="tableId" iconCls="icon-save"
	fitColumns="true" idField="${domain.idName}" rownumbers="true" title="答案管理" nowrap="false"
	url="${ctx}</#noparse>/security/${domain.domainName?uncap_first}/loadTableData.html" 
	pagination="true" pageSize="10" pageList="[10,15,20,30,50]"
	 toolbar="#tableTbId" >
	<thead>
		<tr>
			<th field="ck" checkbox="true" width="20"></th>
			<#list domain.properties as p>
        	<#if (p.type.name == "boolean")>
        	<th field="${p.name}" sortable="true" width="20"><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if></th>
        	<#elseif (p.type.name == "text")>
        	<th field="${p.name}" formatter="DataGridFun.clobFormater" width="20"><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if></th>
        	<#elseif (p.type.name == "timestamp")>
        	<th field="${p.name}" sortable="true" formatter="DataGridFun.dataTimeFormater" width="20"><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if></th>
        	<#elseif (p.type.name == "date")>
        	<th field="${p.name}" sortable="true" formatter="DataGridFun.dataFormater" width="20"><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if></th>
        	<#elseif (p.type.name == "integer" || p.type.name == "long" || p.type.name == "double")>
        	<th field="${p.name}" sortable="true" width="10"><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if></th>
        	<#else>
        	<th field="${p.name}" sortable="true" width="10"><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if></th>
        	</#if>
        	</#list>
		</tr>
	</thead>
</table>
<div id="tableTbId">
	<a id="tableAdd" class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-add" onclick="create()">添加</a>
	<a id="tableEdit" class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-edit" onclick="edit()">修改</a>
	<a id="tableDel" class="easyui-linkbutton" href="javascript:void(0)" iconCls="icon-cut" onclick="remove()">删除</a>
	<input menu="#searchMenuId" id="searchValueId" name="searchValue" class="easyui-searchbox" searcher="searcher" prompt="请输入查询内容"  style="width:200px" />
</div>
<div id="searchMenuId" style="width:150px;" iconCls="icon-ok">
		<#list domain.properties as p>
        <div id="searchMenuItem${p.name?uncap_first}" iconCls="icon-ok" name="${p.name}">按<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if></div>
    	</#list>
</div>

<div id="formDilogId" class="easyui-dialog" style="width:450px;height:280px;padding:10px 20px"
		closed="true" resizable="true" buttons="#formDilogButtonId" >
	<div class="ftitle">${domain.domainCnName}信息</div>
	<form id="inputForm" method="post" >
		<#list domain.properties as p>
    	<#if (p.type.name == "boolean")>
    	<div class="fitem">
			<label><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:</label>
			<input type="text" name="${p.name}" class="easyui-validatebox" <#if (!p.isOptional()) > required="true" validType="length[1,50]"<#else>validType="length[0,50]"</#if> invalidMessage="<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if><#if (!p.isOptional()) >不能为空,且</#if>不能大于50字符" />
		</div>
    	<#elseif (p.type.name == "text")>
    	<div class="fitem">
			<label><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:</label>
			<textarea name="${p.name}" class="easyui-validatebox" <#if (!p.isOptional()) > required="true" validType="length[1,250]"<#else>validType="length[0,50]"</#if> invalidMessage="<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if><#if (!p.isOptional()) >不能为空,且</#if>不能大于250字符" ></textarea>
		</div>
    	<th field="${p.name}" formatter="DataGridFun.clobFormater" width="20"><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if></th>
    	<#elseif (p.type.name == "timestamp")>
    	<div class="fitem">
			<label><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:</label>
			<input type="text" name="${p.name}" class="easyui-datetimebox" <#if (!p.isOptional()) > required="true"</#if> invalidMessage="<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if><#if (!p.isOptional()) >不能为空</#if>" />
		</div>
    	<#elseif (p.type.name == "date")>
    	<div class="fitem">
			<label><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:</label>
			<input type="text" name="${p.name}" class="easyui-datebox" <#if (!p.isOptional()) > required="true"</#if> invalidMessage="<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if><#if (!p.isOptional()) >不能为空</#if>" />
		</div>
    	<#elseif (p.type.name == "integer" || p.type.name == "long")>
    	<div class="fitem">
			<label><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:</label>
			<input type="text" name="${p.name}" class="easyui-numberbox" <#if (!p.isOptional()) > required="true"</#if> min="0" max="9999" invalidMessage="<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if><#if (!p.isOptional()) >不能为空,且</#if>四位以内有效地的正整数" />
		</div>
    	<#elseif (p.type.name == "double")>
    	<div class="fitem">
			<label><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:</label>
			<input type="text" name="${p.name}" class="easyui-numberbox" <#if (!p.isOptional()) > required="true"</#if> min="0" max="9999" precision="2" invalidMessage="<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if><#if (!p.isOptional()) >不能为空,且</#if>四位以内有效地的数字" />
		</div>
    	<#else>
    	<div class="fitem">
			<label><#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if>:</label>
			<input type="text" name="${p.name}" class="easyui-validatebox" <#if (!p.isOptional()) > required="true" validType="length[1,50]"<#else>validType="length[0,50]"</#if> invalidMessage="<#if p.metaAttributes?? && p.metaAttributes["field-description"]?? && p.metaAttributes["field-description"].value?length gt 0>${p.metaAttributes["field-description"].value}<#else>${p.name}</#if><#if (!p.isOptional()) >不能为空,且</#if>不能大于50字符" />
		</div>
    	</#if>
    	</#list>
	</form>
</div>
<div id="formDilogButtonId">
	<a id="dlgSave" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
	<a id="dlgCancel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#formDilogId').dialog('close')">取消</a>
</div>
</body>
</html>
