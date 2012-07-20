<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
<#noparse>$(document).ready(function(){</#noparse>
	<#noparse>$</#noparse>("#${domain.lowerFirstName}List").panel();
	<#noparse>$</#noparse>("#${domain.lowerFirstName}List").renderUrl({
		url : "<#noparse>$</#noparse>{ctx}/${domain.lowerFirstName}/list<#if domain.many2OneOtherRelationField??>?${domain.many2OneOtherRelationField.name}.${project.domainMap[domain.many2OneOtherRelationField.entityName].id.name}=<#noparse>${</#noparse>${domain.lowerFirstName}.${domain.many2OneOtherRelationField.name}.${project.domainMap[domain.many2OneOtherRelationField.entityName].id.name}<#noparse>}</#noparse></#if>",
		op : "append"
	});
});
<#if domain.buttons??>
<#list domain.buttons as b>
<#if b.type== statics["com.wanmei.domain.ButtonHelper"].TYPE_ADD>
function ${b.function}(){
	<#noparse>$</#noparse>("#mainDiv").renderUrl("<#noparse>$</#noparse>{ctx}<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/security</#if>/${domain.lowerFirstName}/input<#if domain.many2OneOtherRelationField??>?${domain.many2OneOtherRelationField.name}.${project.domainMap[domain.many2OneOtherRelationField.entityName].id.name}=<#noparse>${</#noparse>${domain.lowerFirstName}.${domain.many2OneOtherRelationField.name}.${project.domainMap[domain.many2OneOtherRelationField.entityName].id.name}<#noparse>}</#noparse></#if>");
} 
<#elseif b.type== statics["com.wanmei.domain.ButtonHelper"].TYPE_EDIT>
function ${b.function}(id){
	if(!id){
		var chkVals = $("#${domain.lowerFirstName}List").find("input:checked").vals();
		if(chkVals.length < 1){
			$.info("请选择一条记录");
			return ;
		}
		id=chkVals[0];
	}
	<#noparse>$</#noparse>("#mainDiv").renderUrl("<#noparse>$</#noparse>{ctx}<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/security</#if>/${domain.lowerFirstName}/update/"+id);
} 
<#elseif b.type== statics["com.wanmei.domain.ButtonHelper"].TYPE_VIEW>
function ${b.function}(id){
	if(!id){
		var chkVals = $("#${domain.lowerFirstName}List").find("input:checked").vals();
		if(chkVals.length < 1){
			$.info("请选择一条记录");
			return ;
		}
		id=chkVals[0];
	}
	var $div = $("<div style='overflow: scroll;'></div>");
	$div.dialog({
		title : "查看详情",
		href : "<#noparse>$</#noparse>{ctx}/${domain.lowerFirstName}/${b.function}/"+id,
		cache : false,
		collapsible : true,
		resizable : true,
		modal : true,
		width : 500,
		height : 500,
		onClose : function(){
			$div.dialog("destroy");
		},
		buttons : [<#if domain.hasEdit>{
			text : "修改",
			handler : function(){
				edit(id);
				$div.dialog("destroy");
			}
		},</#if><#if domain.hasDel>{
			text : "删除",
			handler : function(){
				$.confirm("提示信息","确认删除记录",function(b){
					if(b){
						$.ajax( {
							url : "<#noparse>$</#noparse>{ctx}<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/security</#if>/${domain.lowerFirstName}/removeMore",
							cache : false,
							data : $.param({ids:[id]},true),
							success : function(data) {
								$.parseJsonResult(data,function(data){
									<#noparse>$</#noparse>("#${domain.lowerFirstName}Table").renderUrl("<#noparse>$</#noparse>{ctx}<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/security</#if>/${domain.lowerFirstName}/list<#if domain.many2OneOtherRelationField??>?${domain.many2OneOtherRelationField.name}.${project.domainMap[domain.many2OneOtherRelationField.entityName].id.name}=<#noparse>${</#noparse>${domain.lowerFirstName}.${domain.many2OneOtherRelationField.name}.${project.domainMap[domain.many2OneOtherRelationField.entityName].id.name}<#noparse>}</#noparse></#if>");
									$div.dialog("destroy");
								},function(msg,data){
									$.error(msg);
								});
							},
							error : function() {
								$.error("系统错误,请联系管理员");
							}
						});
					}
				});
			}
		},</#if>{
			text : "关闭",
			handler : function(){
				$div.dialog("destroy");
			}
		}]
	});
} 
<#elseif b.type== statics["com.wanmei.domain.ButtonHelper"].TYPE_DEL>
function ${b.function}(id){
	if(!id){
		var chkVals = $("#${domain.lowerFirstName}List").find("input:checked").vals();
		if(chkVals.length < 1){
			$.info("请选择一条记录");
			return ;
		}
		id=chkVals[0];
	}
	$.confirm("提示信息","确认${b.label}记录",function(b){
		if(b){
			$.ajax( {
				url : "<#noparse>$</#noparse>{ctx}<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/security</#if>/${domain.lowerFirstName}/${b.function}/"+id,
				cache : false,
				dataType : "json",
				success : function(data) {
					$.parseJsonResult(data,function(data){
						<#noparse>$</#noparse>("#${domain.lowerFirstName}Table").renderUrl("<#noparse>$</#noparse>{ctx}<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/security</#if>/${domain.lowerFirstName}/list<#if domain.many2OneOtherRelationField??>?${domain.many2OneOtherRelationField.name}.${project.domainMap[domain.many2OneOtherRelationField.entityName].id.name}=<#noparse>${</#noparse>${domain.lowerFirstName}.${domain.many2OneOtherRelationField.name}.${project.domainMap[domain.many2OneOtherRelationField.entityName].id.name}<#noparse>}</#noparse></#if>");
					},function(msg,data){
						$.error(msg);
					});
				},
				error : function() {
					$.error("系统错误,请联系管理员");
				}
			});
		}
	});
}
<#elseif b.type== statics["com.wanmei.domain.ButtonHelper"].TYPE_DELMORE>
function ${b.function}(){
	var chkVals = <#noparse>$</#noparse>("#${domain.lowerFirstName}List").find("input:checked").vals();
	if(!chkVals || chkVals.length < 1){
		$.info("请选择一条记录");
		return ;
	}
	$.confirm("提示信息","确认${b.label}记录",function(b){
		if(b){
			$.ajax( {
				url : "<#noparse>$</#noparse>{ctx}<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/security</#if>/${domain.lowerFirstName}/${b.function}",
				cache : false,
				dataType : "json",
				data : $.param({ids:chkVals},true),
				success : function(data) {
					$.parseJsonResult(data,function(data){
						<#noparse>$</#noparse>("#${domain.lowerFirstName}Table").renderUrl("<#noparse>$</#noparse>{ctx}<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/security</#if>/${domain.lowerFirstName}/list<#if domain.many2OneOtherRelationField??>?${domain.many2OneOtherRelationField.name}.${project.domainMap[domain.many2OneOtherRelationField.entityName].id.name}=<#noparse>${</#noparse>${domain.lowerFirstName}.${domain.many2OneOtherRelationField.name}.${project.domainMap[domain.many2OneOtherRelationField.entityName].id.name}<#noparse>}</#noparse></#if>");
					},function(msg,data){
						$.error(msg);
					});
				},
				error : function() {
					$.error("系统错误,请联系管理员");
				}
			});
		}
	});
}
</#if>
</#list>
</#if>
<#list domain.listableFields as f>
<#if f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_MANY2ONE>
function view${project.domainMap[f.entityName].name}(id){
	if(!id){
		var chkVals = $("#${project.domainMap[f.entityName].lowerFirstName}List").find("input:checked").vals();
		if(chkVals.length < 1){
			$.info("请选择一条记录");
			return ;
		}
		id=chkVals[0];
	}
	var $div = $("<div style='overflow: scroll;'></div>");
	$div.dialog({
		title : "查看${f.label}详情",
		href : "<#noparse>$</#noparse>{ctx}/${project.domainMap[f.entityName].lowerFirstName}/view/"+id,
		cache : false,
		collapsible : true,
		resizable : true,
		modal : true,
		width : 500,
		height : 500,
		onClose : function(){
			$div.dialog("destroy");
		},
		buttons : [{
			text : "关闭",
			handler : function(){
				$div.dialog("destroy");
			}
		}]
	});
} 
</#if>
</#list>
<#if domain.isOne2ManyRelationBean>
function create${domain.one2ManyRelationField.domain.name}(id){
	if(!id){
		var chkVals = $("#${domain.lowerFirstName}List").find("input:checked").vals();
		if(chkVals.length < 1){
			$.info("请选择一条记录");
			return ;
		}
		id=chkVals[0];
	}
	<#noparse>$</#noparse>("#mainDiv").renderUrl("<#noparse>$</#noparse>{ctx}<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/security</#if>/${domain.one2ManyRelationField.domain.lowerFirstName}/main?${domain.one2ManyRelationField.name}.${project.domainMap[domain.one2ManyRelationField.entityName].id.name}="+id);
}
</#if>
<#list domain.many2ManyRelationFields as f>
function manager${f.name?cap_first}(id){
	if(!id){
		var chkVals = $("#${domain.lowerFirstName}List").find("input:checked").vals();
		if(chkVals.length < 1){
			$.info("请选择一条记录");
			return ;
		}
		id=chkVals[0];
	}
	<#noparse>$</#noparse>("#mainDiv").renderUrl("<#noparse>$</#noparse>{ctx}<#if project.codeType == statics["com.wanmei.domain.ProjectHelper"].CODE_TYPE_ALL>/security</#if>/${domain.lowerFirstName}/main${f.name?cap_first}?${domain.id.name}="+id);
}
</#list>
<#if domain.searchSortField??>
function search(){
    $("#${domain.lowerFirstName}Table").renderUrl({
    	url : "<#noparse>$</#noparse>{ctx}/${domain.lowerFirstName}/list",
    	params : <#noparse>$</#noparse>("#searchForm").serialize()
    });
}
</#if>
</script>
<div id="${domain.lowerFirstName}Searcher" class="search-div" >
<#if domain.searchSortField??>
<form class="form" id="searchForm" method="post" action="<#noparse>$</#noparse>{ctx }/${domain.lowerFirstName}/list" >
<input type="hidden" id="sortPropertyId" name="sortProperty" value="${domain.id.name}" />
<input type="hidden" id="sortOrderId" name="sortOrder" value="desc" />
<#list domain.one2ManyRelationFields as f >
<input type="hidden" name="${f.name}.${project.domainMap[f.entityName].id.name}" id="${f.name}Id" value="<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}.${project.domainMap[f.entityName].id.name}<#noparse>}</#noparse>"/>
</#list>
	<#list domain.searchSortField as f>
	<div class="search-div-elment">${f.label}:
		<#if f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_DATE>
		<input class="input" type="text" name="${f.name}" id="${f.name}Id" maxlength="50" class="Wdate" onfocus="javascript:WdatePicker({dateFmt:'yyyy-MM-dd', isShowWeek:true});" value="<fmt:formatDate value='<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}<#noparse>}</#noparse>' pattern='yyyy-MM-dd'/>"/>
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_DATETIME)>		
		<input class="input" type="text" name="${f.name}" id="${f.name}Id" maxlength="50" class="Wdate" onfocus="javascript:WdatePicker({dateFmt:'yyyy-MM-dd HH:mm', isShowWeek:true});" value="<fmt:formatDate value='<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}<#noparse>}</#noparse>' pattern='yyyy-MM-dd HH:mm'/>"/>
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_FILE)>		
		<input class="input" type="file" name="${f.name}File" id="${f.name}FileId" />
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_BOOLEAN)>		
		<input type="radio" name="${f.name}" value="1" <c:if test="<#noparse>$</#noparse>{${domain.lowerFirstName}.${f.name}}"> checked="checked"</c:if>>是</input>
	    <input type="radio" name="${f.name}" value="0" <c:if test="<#noparse>$</#noparse>{!${domain.lowerFirstName}.${f.name}}"> checked="checked"</c:if>>否</input>
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_STRING)>		
		<input class="input" type="text" name="${f.name}" id="${f.name}Id" maxlength="${(f.length?c)?default("250")}" value="<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}<#noparse>}</#noparse>"/>
		<#elseif (f.type==statics["com.wanmei.domain.FieldHelper"].TYPE_TEXT)>
		<textarea class="textarea" name="${f.name}" id="${f.name}Id"><#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}<#noparse>}</#noparse></textarea>		
		<#else>
		<input class="input" type="text" name="${f.name}" id="${f.name}Id" value="<#noparse>${</#noparse>${domain.lowerFirstName}.${f.name}<#noparse>}</#noparse>"/>
		</#if>
	</div>
	</#list>
	<div style="text-align:left;padding-left:5px;"><input type="button" id="searchBtn" style="font-size:10px;" value="查询" onclick="search()" /></div>
</form>
</#if>
</div>
<div id="${domain.lowerFirstName}List" class="list" >
	<div align="right">
	<#if domain.buttons??>
	<#list domain.buttons as b>
	<input type="button" value="${b.label}" onclick="${b.function}();" />
	</#list>
	</#if>
	<#if domain.isOne2ManyRelationBean>
	<input type="button" value="创建${domain.one2ManyRelationField.domain.label}" onclick="create${domain.one2ManyRelationField.domain.name}();" />
	</#if>
	<#list domain.many2ManyRelationFields as f>
	<input type="button" value="管理${f.label}" onclick="manager${f.name?cap_first}();" />
	</#list>
	</div>
</div>
