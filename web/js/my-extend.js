(function($) {
	$.fn.toTable = function(options) {
		var defaults = {
			module : "",
			tableDiv : "",
			searchDiv : "",
			searchSortPropertyId : "sortPropertyId",
			searchSortOrderId : "sortOrderId",
			listUrl : ""
		};
		if(typeof options == "string"){
			options = {module : options};
		}
		if(!defaults.tableDiv){
			defaults.tableDiv = "#" + defaults.module + "Table";
		}
		if(!defaults.searchDiv){
			defaults.searchDiv = "#" + defaults.module + "Searcher";
		}
		if(!defaults.listUrl){
			defaults.listUrl = ctx + "/" + defaults.module + "/list";
		}
		options = $.extend(defaults, options);
		this.each(function(){
			$(options.tableDiv + " table tbody tr :checkbox").click(function(e){//执行默认checkbox行为阻止事件传播
				e.stopPropagation();
				return true;
			});
			$(options.tableDiv + " table tbody tr").unbind().bind("mouseover",function(){
		    	$(this).addClass("hover-tr");
		    }).bind("mouseout",function(){
		    	$(this).removeClass("hover-tr");
		    }).bind("click",function(){
		    	$(this).find(":checkbox").click();
		    }).bind("dblclick",function(){
		    	$(this).find(":checkbox").attr("checked","checked");
		    	view($(this).find(":checkbox").val());
		    });
			var spanAsc = $('<span class="icon-ascsort">&nbsp;</span>');
			var spanDesc = $('<span class="icon-descsort">&nbsp;</span>');
			$(options.tableDiv + " table th[sort]").mouseover(function(){
				$(this).addClass("hover-sort");
			}).mouseout(function(){
				$(this).removeClass("hover-sort");
			});
			$(options.tableDiv + " table th[sort]").click(function(){
				var $this =  $(this);
				var sort = $this.attr("sort");
				var order = $this.attr("order");
				if(!sort){
					return false;
				}
				if(!order){
					order = "desc";
				}else {
					order = (order == "desc"?"asc":"desc");
				}
				$(options.searchDiv + " #"+options.searchSortPropertyId).val(sort);
				$(options.searchDiv + " #"+options.searchSortOrderId).val(order);
				$(options.tableDiv + " table th span").remove();
				if(order == "desc"){
					$this.append(spanDesc);
				}else{
					$this.append(spanAsc);
				}
				if($(options.searchDiv + " form").length != 0){
					$(options.searchDiv + " #"+options.searchSortPropertyId).val(sort);
					$(options.searchDiv + " #"+options.searchSortOrderId).val(order);
					search();
				}else{
					var pJson = {};
					var sortPropertyName = $("#"+options.searchSortPropertyId).attr("name");
					var sortOrderName = $("#"+options.searchSortOrderId).attr("name");
					pJson[sortPropertyName] = sort;
					pJson[sortOrderName] = order;
					$(options.tableDiv).renderUrl({
						url:options.listUrl,
						params : pJson,
						op : "replace"
					});
				}
			});
		});
		return this;
	};
	$.fn.changeCheckTable = function(options) {
		var defaults = {
			type : "radio",
			title : "选择",
			selectAllSelector : "#selectAll",
			fn : function(){
			}
		};
		if(typeof options == "string"){
			options = {type : options};
		}
		options = $.extend(defaults, options);
		this.each(function(){
			if($(this).is("table")){
				$(this).find(options.selectAllSelector).removeAttr("onclick");
				$(this).find(options.selectAllSelector).html("选择");
				var eles = [];
				if(options.type="radio"){
					eles = $(this).find(":checkbox");
				}else if(options.type="checkbox"){
					eles = $(this).find(":radio");
				}
				if(eles){
					eles.each(function(){
						var newEle = $(this).clone(true);
						newEle.attr("type",options.type);
						$(this).replaceWith(newEle);
					});
				}
			}
		});
		return this;
	};
})(jQuery);
function doLoginFun(){
	window.location = ctx + "/login.jsp";
}
function checkAllBox(obj){
	var $this = $(obj);
	if($this.closest("table").find(":checkbox").length){
		var c = false;
		if($this.attr("checked")){
			$this.removeAttr("checked");
			$this.html("全选");
		}else{
			c = true;
			$this.attr("checked","1");
			$this.html("反选");
		}
		$this.closest("table").find(":checkbox").each(function(i){
			if($(this).is(":checked") ^ c ){
				$(this).click();
			}
		});
	}
}