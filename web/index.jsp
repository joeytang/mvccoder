<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>

<html>
<head>
 <%@ include file="/common/meta.jsp" %>
 <title>MVC代码生成系统-首页</title>
 <script type="text/javascript">
 $(document).ready(function(){
 	$("body").layout();
 	$("#mainDiv").panel();
 	$("#w").window();
 	$('#editpass').click(function() {
        $('#w').window('open');
    });
    $('#btnEp').click(function() {
        serverLogin();
    });
	$('#btnCancel').click(function(){
		$('#w').window('close');
	});
    $('#loginOut').click(function() {
        $.confirm('系统提示', '您确定要退出本次登录吗?', function(r) {
            if (r) {
                location.href = '<c:url value='/logout'/>';
            }
        });
    });
    $('.easyui-accordion li a').click(function(){
		var url = $(this).attr("rel");
		var title = $(this).children('.nav').text();
		if(url){
			$("#mainDiv").renderUrl(url);
			$("#mainDiv").panel('setTitle',title);
		}
		$('.easyui-accordion li div').removeClass("selected");
		$(this).parent().addClass("selected");
	}).hover(function(){
		$(this).parent().addClass("hover");
	},function(){
		$(this).parent().removeClass("hover");
	});
    $("body").unmask();
 });
  </script>
</head>
<body>
<script type="text/javascript">
$("body").mask();
</script>
 <div region="north" split="true" border="false" style="overflow: hidden; height: 50px;
      background: url(<c:url value='/images/layout-browser-hd-bg.gif'/>) #7f99be repeat-x center 50%;
      line-height: 20px;color: #fff; font-family: Verdana, 微软雅黑,黑体">
      <span style="float:right; padding-right:20px;padding-top:10px;vertical-align: middle" class="head">欢迎 <sec:authentication property="principal.nickname" />&nbsp;&nbsp;<a href="javascript:void(0)" id="editpass">修改密码</a> <a href="javascript:void(0)" id="loginOut">安全退出</a></span>
      <span style="padding-left:10px;padding-top:50px; font-size: 24px; vertical-align: middle"><img src="<c:url value='/images/blocks.gif'/>" width="20" height="20" /> 代码生成工具MvcCoder</span>
  </div>
  <div region="south" split="true" style="height: 30px; background: #D2E0F2; ">
      <div class="footer">By joeytang E-mail:tanghc@163.com</div>
  </div>
  <div region="west" hide="true" split="true" title="导航菜单" style="width:180px;overflow: hidden;" id="west">
  	<div id="nav" class="easyui-accordion">
  	<sec:authorize ifAnyGranted="${g:var('com.wanmei.domain.helper.UserHelper','ROLE_ADMIN')}" >
  		<div iconCls="icon icon-users" title="用户管理" id="menu1" >
			<ul>
				<li>
					<div>
						<a href="javascript:void(0)" rel="<c:url value='/user/main'/>" > 
							<span class="icon icon-role">&nbsp;</span>
							<span class="nav">用户管理</span>
						</a>
					</div>
				</li>
			</ul>
		</div>
	  </sec:authorize>
  		<div iconCls="icon icon-menus" title="数据库配置" id="menu2" >
			<ul>
				<li>
					<div>
						<a href="javascript:void(0)" rel="<c:url value='/db/main'/>" > 
							<span class="icon icon-sys">&nbsp;</span>
							<span class="nav">数据库配置</span>
						</a>
					</div>
				</li>
			</ul>
		</div>
  		<div iconCls="icon icon-menus" title="Action配置" id="menu3" >
			<ul>
				<li>
					<div>
						<a href="javascript:void(0)" rel="<c:url value='/action/main'/>" > 
							<span class="icon icon-sys">&nbsp;</span>
							<span class="nav">Action配置</span>
						</a>
					</div>
				</li>
			</ul>
		</div>
  		<div iconCls="icon icon-menus" title="Dao配置" id="menu4" >
			<ul>
				<li>
					<div>
						<a href="javascript:void(0)" rel="<c:url value='/dao/main'/>" > 
							<span class="icon icon-sys">&nbsp;</span>
							<span class="nav">Dao配置</span>
						</a>
					</div>
				</li>
			</ul>
		</div>
  		<div iconCls="icon icon-menus" title="SpringSecurity配置" id="menu5" >
			<ul>
				<li>
					<div>
						<a href="javascript:void(0)" rel="<c:url value='/security/main'/>" > 
							<span class="icon icon-sys">&nbsp;</span>
							<span class="nav">SpringSecurity配置</span>
						</a>
					</div>
				</li>
			</ul>
		</div>
  		<div iconCls="icon icon-menus" title="字段" id="menu7" >
			<ul>
				<li>
					<div>
						<a href="javascript:void(0)" rel="<c:url value='/field/main'/>" > 
							<span class="icon icon-sys">&nbsp;</span>
							<span class="nav">字段</span>
						</a>
					</div>
				</li>
			</ul>
		</div>
		<div iconCls="icon icon-menus" title="自定义的Controller" id="menu9" >
			<ul>
				<li>
					<div>
						<a href="javascript:void(0)" rel="<c:url value='/controller/main'/>" > 
							<span class="icon icon-sys">&nbsp;</span>
							<span class="nav">自定义的Controller</span>
						</a>
					</div>
				</li>
			</ul>
		</div>
		<div iconCls="icon icon-menus" title="按钮" id="menu6" >
			<ul>
				<li>
					<div>
						<a href="javascript:void(0)" rel="<c:url value='/button/main'/>" > 
							<span class="icon icon-sys">&nbsp;</span>
							<span class="nav">按钮</span>
						</a>
					</div>
				</li>
			</ul>
		</div>
		<div iconCls="icon icon-menus" title="模块" id="menu6" >
			<ul>
				<li>
					<div>
						<a href="javascript:void(0)" rel="<c:url value='/domain/main'/>" > 
							<span class="icon icon-sys">&nbsp;</span>
							<span class="nav">模块</span>
						</a>
					</div>
				</li>
			</ul>
		</div>
		<div iconCls="icon icon-menus" title="项目" id="menu11" >
			<ul>
				<li>
					<div>
						<a href="javascript:void(0)" rel="<c:url value='/project/main'/>" > 
							<span class="icon icon-sys">&nbsp;</span>
							<span class="nav">项目</span>
						</a>
					</div>
				</li>
			</ul>
		</div>
 	</div>
  </div>
  <div id="mainDiv" region="center"  style="background: #eee;padding: 2px;" title="欢迎" headerCls="panelHeader"style=" overflow: scroll;" >
		   欢迎使用后台管理系统 
  </div>
 <!--修改密码窗口-->
  <div id="w"  title="修改密码" collapsible="false" minimizable="false"
      maximizable="false" icon="icon-save" width="300" height="165" modal="true" 
      modal="true" shadow="true" closed="true" resizable="true"
      style=" width: 300px; height: 165px; padding: 5px; background: #fafafa;">
      <div class="easyui-layout" fit="true">
          <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
              <table cellpadding=3>
                  <tr>
                      <td>新密码：</td>
                      <td><input id="txtNewPass" type="Password" class="txt01" /></td>
                  </tr>
                  <tr>
                      <td>确认密码：</td>
                      <td><input id="txtRePass" type="Password" class="txt01" /></td>
                  </tr>
              </table>
          </div>
          <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
              <a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" > 确定</a> 
              <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)">取消</a>
          </div>
      </div>
  </div>
 
</body>
</html>