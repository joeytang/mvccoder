/**
 * 将ajax内容装入jquery selector
 * 
 * @param url
 * @param $target
 * @param type
 *            0 装载内容 1 替换内容
 * @return
 */
function _renderUrl(url, selector, type, fn) {
	var i = url.indexOf("?");
	var p = url.substring(i+ 1);
	url = url.substring(0,i);
	$(selector).html(
			'<img src="' + ctx + '/images/loading.gif" />正在加载信息...');
	$.ajax( {
		url : url,
		cache : false,
		data : p,
		type  : "post",
		success : function(html) {
			$.parseTextResult(html,function(html){
				if (!type || type == 0) { // 默认装载内容
					$(selector).empty().append(html);
				} else{
					$(selector).replaceWith(html); 
				}
				if (fn) {
					fn();
				}
			},function(msg,html){
				$.error(msg);
			});
		},
		error : function() {
			$.error("您访问的页面出错，请稍后再试。");
			$(selector).html("页面出错");
		}
	});
}

/**
 * toPageNo 显示第几页内容
 * pageNo 表示指定页码的变量名称，默认为"pageNo"
 * uri 请求列表的url地址
 * selector 放置列表代码的容器，jquery选择器
 * op 对装载的内容操作 html 放入到容器中，replace将容器替换，prepend 放入容器中的前面，append 放入容器中的后面,before放入容器外前面,after放入容器外后面 默认为html
 * searchStr是用来记录搜索时的条件字符串的，生产格式如下：“&name=abc&id=1&pid=8”;
 */
function _tunePage(toPageNo, pageNo, uri, selector, op, searchStr) {
	var topage = 1;
	if(typeof toPageNo == "string"){
		try{toPageNo = parseInt(toPageNo);}catch(_e){}
	}
    if (typeof(toPageNo) != "number" || toPageNo < 1) topage = 1;
    else topage = toPageNo;
    if(!pageNo){
    	pageNo = "pageNo";
    }
    try {
    	var para = pageNo+"=" + topage ;
        if (searchStr && searchStr != "null" && searchStr.length>0) {
            //  alert("add_searchStr_pathname=" + window.location.pathname +"?pageNo="+ toPageNo + searchStr);
            //window.location = window.location.pathname + "?pageNo=" + toPageNo + searchStr;
        	//_renderUrl(uri + "?"+pageNo+"=" + topage + searchStr, selector, replace);
        	para += searchStr;
        }
        else {
          //  _renderUrl(uri + "?"+pageNo+"=" + topage, selector, replace);
        }
        $(selector).renderUrl({
    		url : uri,
    		op : op,
			params : para
    	});
    }
    catch(e) {
       // window.location = window.location.pathname + window.location.search;
       // _renderUrl(uri + "?"+pageNo+"=1", selector, replace);
    	$.error("分页出错");
    }
}
(function($) {
	//ajax装载一个页面到该对象中
	$.fn.renderUrl = function(options) {
		var defaults = {
			op : "html",
			params : {},
			url : "",
			fn : function(){
		
			}
		};
		if(typeof options == "string"){
			options = {url : options};
		}
		options = $.extend(defaults, options);
		
		
		this.each(function(){
			if(options.url){
				var thisContainer = $(this);
				var _img_load_div = $('<div ><img src="' + ctx + '/images/loading.gif" />Loading...</div>');
				thisContainer.prepend(_img_load_div);
				$.ajax( {
					url : options.url,
					data : options.params,
					cache : false,
					success : function(html) {
						_img_load_div.remove();
						$.parseTextResult(html,function(html){
							if(options.op == "replace"){
								$(thisContainer).replaceWith(html); 
							}else if(options.op == "append"){
								$(thisContainer).append(html); 
							}else if(options.op == "prepend"){
								$(thisContainer).prepend(html); 
							}else if(options.op == "before"){
								$(thisContainer).before(html); 
							}else if(options.op == "after"){
								$(thisContainer).after(html); 
							}else{
								$(thisContainer).empty().append(html);
							}
							if (options.fn) {
								options.fn(html);
							}
						},function(msg,html){
							$.error(msg);
						});
					},
					error : function() {
						$.error( "页面出错");
						thisContainer.html("页面出错");
					}
				});
			}
		});
		return this;
	};
	//装载select的选项
	$.fn.loadSelect = function(options) {
		var defaults = {
				headValue : "", //默认的一个选项的值 eg 0
				headText : "",//默认的一个选项的文本 eg 请选择
				data : null, //select中需要填充的数据，如果提供了该数据，则直接将这个数据填充到色了传统中，若未提供，则根据url去取
				params : {},//用于获得select中数据的地址
				url : "",//用于获得select中数据的地址
				value : 'key', //取json数据data中，用于表示option的value属性的标示
				text : 'value',//取json数据data中，用于表示option的text属性的标示
				defaultValue : '',//默认被选中的值
				changeFn : null,//change事件
				fn : null//装载完以后调用的回调函数
		};
		options = $.extend(defaults, options);
		var _loadSelectByData = function (selectDom,data){
			if(data){
				selectDom.options.length="0";
				if(options.headValue){
					var optionDom = document.createElement("option");
					optionDom.value=options.headValue;
					optionDom.innerHTML=options.headText;
					selectDom.appendChild(optionDom);
				}
				//处理返回来的服务器列表
				for(var i = 0;i<data.length;i++){
					var optionDom = document.createElement("option");
					optionDom.value=data[i][options.value];
					optionDom.innerHTML=data[i][options.text];
					selectDom.appendChild(optionDom);
				}
				if(options.defaultValue){
					$(selectDom).val(options.defaultValue);
				}
				if(options.changeFn){
					$(selectDom).change(function (){
						options.changeFn(this);
					});
				}
				if(options.fn){
					options.fn(selectDom);
				}
			}
		};
		this.each(function(){
			var selectDom = this;
			if(options.data){
				_loadSelectByData(this,options.data);
				return ;
			}
			if(options.url){
				$.ajax( {
					url : options.url,
					data : options.params,
					dataType : "json",
					cache : false,
					success : function(data) {
					_loadSelectByData(selectDom,data);
				},
				error : function() {
					$.error( "页面出错");
				}
				});
			}
		});
		return this;
		
	};
	//下拉框搜索
	$.fn.comboSelect = function(options) {
		var defaults = {
				emptyText : "No Record",//默认没有搜索到结果的提示信息,
				url : "",//搜索请求的地址
				keyword : "key", //搜索时关键字变量名
				value : 'key', //取json数据data中，用于表示option的value属性的标示
				text : 'value',//取json数据data中，用于表示option的text属性的标示
				currentText : "", // 当前显示的字符串
				currentValue : "",// 当前选中的值
				fn : function(){ //装载完成后执行函数
				},
				selectFn : function(json){//选择选项时触发函数，参数为该选项对应的后台传回的json对象
				},
				valueFn : function(json){//根据后台传回该行的json对象生成select对应option的value值
					return json[this.value];
				},
				textFn : function(json){//根据后台传回该行的json对象生成select对应option显示字符串
					return json[this.text];
				}
		};
		options = $.extend(defaults, options);
		this.each(function(){
			var $this = $(this);
			var curId = $this.attr("id");
			var $div = $("<div id='"+curId+"_' style='display:none;'></div>");
			$this.wrap($div);
			var $topDiv = $("<div class='suggest_box t1 text fix' id='"+curId+"_top' >"
					+"<div class='suggest_item' style='display:none'>"
					+"<span class='bg'>"
					+"<span class='name'></span>"
					+"<span class='del'>x</span>"
					+"</span>"
					+"</div>"
					+"<div class='suggest_text' >"
					+"<input type='text' id='"+curId+"fid' style='width:250px;'/>"
					+"</div>"
					+"<div class='suggest_list SelectMenu' style='display:none'></div>"
					+"</div>");
			$("#"+curId+"_").replaceWith($topDiv.append($("#"+curId+"_").clone()));
			var $t = $("#"+curId+"_top");
			var isFill=false,index=0,isarr=0;
			
			var input=$t.find(".suggest_text input");
			var list=$t.find(".suggest_list");
			input.bind({
				"click":function(event){
				event.stopPropagation();
			},
			"focus":function(){
				if(isFill){this.blur();return;}
				_searchFriends();
				//list.html("请输入用户昵称").show()
			},
			"keyup":function(event){
				if(isFill){return;}
				if(event.keyCode==40 || event.keyCode==38){
					return;
				}
				_searchFriends();
			},
			"keydown":function(event){
				switch (event.keyCode){
				case 40://down
					if(isarr){
						if(index>=lis.length-1){
							index=0;
						}else{
							index++;
						}
						lis.removeClass("selected");
						lis.eq(index).addClass("selected");
					}
					break;
				case 38://up
					if(isarr){
						if(index<=0){
							index=lis.length-1;
						}else{
							index--;
						}
						lis.removeClass("selected");
						lis.eq(index).addClass("selected");
					}
					break;
				case 13://enter
					if(isarr){
						isFill=true;
						var sel=lis.eq(index);
						$t.find(".suggest_item .name").html(sel.html());
						$t.find(".suggest_item").show();
						$t.find(".suggest_text").hide();//隐藏输入框
						this.value="";
						list.hide();
						$("#"+curId).val(sel.attr("userId"));
						$("#"+curId+"fid").val("");
						options.selectFn(sel.data("json"));
						
					}
					break;
				case 8://backspace
					if(isarr){
						$t.find(".suggest_item").hide();
						isFill=false;
					}
					$("#"+curId).val("");
					break;
				}
			}
			});
			if(options.currentText && options.currentValue){
				$t.find(".suggest_text").hide();
				$t.find(".suggest_item .name").html(options.currentText);
				$t.find(".suggest_item").show();
				$("#"+curId).val(options.currentValue);
			}
			options.fn();
			$t.find(".suggest_item .del").click(function(){
				$t.find(".suggest_item").hide();
				$t.find(".suggest_text").show();//显示输入框
				input.get(0).focus();
				isFill=false;
				$("#"+curId).val("");
			});
			$("html").click(function(){
				list.hide();
			});
			var _fri_search_obj = {};
			function _searchFriends(){
				var keyword = $.trim($("#"+curId+"fid").val());
				if(_fri_search_obj && _fri_search_obj[keyword]){
					_refreshFriListDiv(_fri_search_obj[keyword]);
				}else{
					var params = new Object();
					params['r']=  Math.random();
					params[options.keyword]= keyword;
					$.ajax( {
						url : options.url,
						data : params,
						dataType :'json',
						beforeSend : function() {
						},
						success : function(data) {
							if(data){
								_fri_search_obj[keyword] = data;
								_refreshFriListDiv(data);
							}
						}
					});
				}
			}
			
			function _refreshFriListDiv(friJson){
				var html=[];
				var hasFriend = false;
				$.each(friJson,function(i){
					var $e = this;
					hasFriend = true;
					var $li = $('<li userId="'+options.valueFn($e)+'">'+ options.textFn($e) +'</li>');
					$li.data("json",$e);
					if(i == 0){
						list.html("<ul></ul>");
						list.find("ul").html($li);
					}
					list.find("ul").append("\n");
					list.find("ul").append($li);
					list.show();
					
				});
				index=0;
				list.find("li:first").addClass("selected");
				lis=list.find("li");
				lis.bind({
					"mouseover":function(){
						lis.removeClass("selected");
						$(this).addClass("selected");
						index=$(this).index();
					},
					"click":function(){
						isFill=true;
						$t.find(".suggest_item .name").html($(this).html());
						$t.find(".suggest_item").show();
						$t.find(".suggest_text").hide();//隐藏输入框
						//self.value="";
						$("#"+curId).val($(this).attr("userId"));
						$("#"+curId+"fid").val("");
						options.selectFn($(this).data("json"));
					}
				});
				
				if(!hasFriend){
					list.html(options.emptyText).show();
					isarr=false;
					return;
				}else{
					isarr=1;
				}
			}
			
		});
		return this;
	};
	//下拉框搜索
	$.fn.cascadeSelect = function(options) {
		var defaults = {
				url : "",
				pidName : "pId",
				path : "",
				value : "key",
				text : "value",
				childrenSizeName : "childrenSize",
				headValue : "", //默认的一个选项的值 eg 0
				headText : "",//默认的一个选项的文本 eg 请选择
				leafChangeFn : function(){}
		};
		options = $.extend(defaults, options);
		this.each(function(){
			_initSelect(this);
		});
		function _initSelect(topDom,pDptid){
			var $sel = $(topDom);
			var topDpt = $sel.attr("id");
			if(!topDpt){
				topDpt = "_";
			}
			var params = {};
			if(pDptid){
				params[options.pidName] = pDptid;
			}
			$.ajax( {
				url : options.url,
				data : params,
				dataType : "json",
				cache : false,
				success : function(data) {
					//$sel.get(0).length = 0;
					var _cVal = "0";
					for(var i = 0;i<data.length;i++){
						var $opt = $("<option></option>");
						$opt.val(data[i][options.value]);
						if(options.path){
							if(options.path.indexOf(","+data[i][options.value]+",") != -1){
								_cVal = data[i][options.value];
							}
						}
						$opt.text(data[i][options.text]);
						$opt.attr("cldCnt",data[i][options.childrenSizeName]);
						$sel.append($opt);
					}
					$sel.change(function(){
						$("select[id^='"+topDpt+"_']").remove();
						var $this = $(this);
						var $opt = $this.find("option:selected");
						if($opt.attr("cldCnt") > 0 ){
							var $cSelct = $("<select id='"+topDpt+"_' ><option value='"+options.headValue+"'>"+options.headText+"</option></select>");
							$this.after("&nbsp;&nbsp;");
							$this.after($cSelct);
							_initSelect($("#"+topDpt+"_").get(0),$this.val());
						}else{
							options.leafChangeFn(this);
							options.path = "";
						}
					});
					if(options.path && _cVal && _cVal != "0"){
						$sel.val(_cVal);
						$sel.change();
					}
					//$sel.change();
				},
				error : function() {
					$.error( "页面出错");
				}
			});
		}
		return this;
	};
	//获得多选框选中的值
	$.fn.getCheckedValues = function(options) {
		var defaults = {
		};
		options = $.extend(defaults, options);
		var vs = [];
		this.each(function(){
			var $this = $(this);
			var checkeds = $this.find("input:checked");
			if(checkeds.length == 1){
				vs.push(checkeds.val());
			}else if(checkeds.length > 1){
				checkeds.each(function(){
					vs.push($(this).val());
				});
			}
		});
		return vs;
	};
	//获得多个对象值
	$.fn.vals = function(v) {
		var vals = [];
		this.each(function(){
			if(v || v == "" || v == 0){
				$(this).val(v);
			}else{
				vals.push($(this).val());
			}
		});
		return vals;
	};
	;
	//获得select的option值,可以获得多选的值，结果为一个数组
	$.fn.optionVals = function() {
		var vals = [];
		this.each(function(){
			$(this).find("option:selected").each(function(i){
				vals.push($(this).text());
			});
		});
		return vals;
	};
	//获得select的option值,获得单选值，若有多个则取第一个选中的值
	$.fn.optionVal = function() {
		var vals = "";
		this.each(function(){
			$(this).find("option:selected").each(function(i){
				vals = $(this).text();
				return ;
			});
		});
		return vals;
	};
	$.extend({
		locale:function(url,locale,paramName){
			if(!paramName){
				paramName = "locale" ;
			}
			var params = {};
			params[paramName] = locale;
			$.ajax( {
				url : url,
				data : params,
				dataType : "json",
				cache : false,
				success : function(data) {
					if(data.status == "success"){
						window.location = window.location;
					}else if(data.error ) {
					}else{
					}
				},
				error : function() {
				}
			});
		},
		fadeRedirect:function(url,time){
			setTimeout(function() {
				window.location = url;
			}, time);
		}
	});
})(jQuery);
