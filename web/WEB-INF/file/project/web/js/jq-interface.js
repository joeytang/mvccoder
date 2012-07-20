(function($) {
	//jquery遮罩
	$.fn.mask = function(options) {
		var defaults = {
				msg : "loading...",
				classMask : "my-easyui-mask",
				classLoading : "panel-loading",
				fn : function(){
				}
		};
		if(typeof options == "string"){
			options = {url : options};
		}
		options = $.extend(defaults, options);
		this.each(function(){
			var $this = $(this);
			var $div = $("<div class='"+options.classMask+"'></div>");
			var $divLoading = $("<div style='position:absolute' class='"+options.classLoading+"'>"+options.msg+"</div>");
			$div.height($this.outerHeight()?$this.outerHeight():$this.height());
			$div.width($this.outerWidth()?$this.outerWidth():$this.width());
			var offs = $this.offset();
			$div.css("z-index","10000");
			$div.css("opacity","0.9");
			$div.css("background-color","#D2E0F2");
//			$div.css("background-color","#ccc");
			$div.css("position","absolute");
			$div.css("left",offs.left);
			$div.css("top",offs.top);
			
			var widthspace=($div.width()-$divLoading.width());
			var heightspace=($div.height()-$divLoading.height());
			$divLoading.css("position","absolute");
			$divLoading.css("left",widthspace/2-2);
			$divLoading.css("top",heightspace/2-2);
			$div.append($divLoading);
			$this.append($div);
		});
		return this;
	};
	//jquery取消遮罩
	$.fn.unmask = function() {
		this.each(function(){
			$(this).find(".my-easyui-mask").fadeOut("fast",function(){
				$(this).remove();
			});
		});
		return this;
	};
	$.extend({
		parseJsonResult:function(json,succFun,errFun){
			if(json){
				var status = json.status;
				if(!status){
					return ;
				}
				if(status == "200"){
					if(succFun){
						succFun(json);
						return ;
					}
				}else if(status == "601"){
					$.warning("会话超时，请重新登陆",function(){
						doLoginFun();
					});
					return ;
				}else{
					if(errFun){
						errFun((json.error?json.error:_getErrorMsg(status)),json);
						return ;
					}
					
				}
			}
		},
		parseTextResult:function(text,succFun,errFun){
			if(text){
				var data = $.trim(text);
				if(data.indexOf("{") == 0){
					eval("var json="+data);
					$.parseJsonResult(json,succFun,errFun);
				}else{
					if(succFun){
						succFun(text);
						return ;
					}
				}
			}
		}
		,
		alert:function(title, msg, icon, fn){
			$.messager.alert(title, msg, icon, fn);
		},
		confirm:function(title, msg, fn){
			$.messager.confirm(title, msg, fn);
		},
		info:function(msg, fn){
			$.alert("提示信息", msg,"info", fn);
		},
		error:function(msg, fn){
			$.alert("错误信息", msg,"error", fn);
		},
		warning:function(msg, fn){
			$.alert("警告信息", msg,"warning", fn);
		}
	});
	function _getErrorMsg(status){
		var errMsg="";
		if(status == "400"){
			errMsg = "错误请求";	
		}else if(status == "401"){
			errMsg = "请求未被授权";	
		}else if(status == "403"){
			errMsg = "请求被拒绝";	
		}else if(status == "404"){
			errMsg = "请求页面未找到";	
		}else if(status == "405"){
			errMsg = "请求method不被允许";	
		}else if(status == "500"){
			errMsg = "系统错误";	
		}else if(status == "600"){
			errMsg = "参数传递不合法";	
		}else if(status == "601"){
			errMsg = "登陆信息失效";	
		}
		return errMsg;
	}
})(jQuery);
