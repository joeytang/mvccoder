<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
<title>MVC代码生成系统-登录</title>
<STYLE type=text/css>
.style2 {
	COLOR: #003366
}

.style3 {
	COLOR: #ffffff
}

.style4 {
	FONT-WEIGHT: bold;
	COLOR: #3d7acd
}

BODY {
	BACKGROUND-COLOR: #417bc9
}

.STYLE5 {
	FONT-WEIGHT: bold;
	COLOR: #ffffff
}

.STYLE6 {
	COLOR: #ffffff
}
body {
    text-align: center;
}

table {
    font-size: 12px;
    border-collapse: collapse
}

td.left {
    color: #336699;
    text-align: right;
    padding-right: 20px;
    border: #a8cbf1 1px solid;
    background-color: #f1f1f1
}

td.right {
    color: #336699;
    padding-left: 10px;
    border: #a8cbf1 1px solid;
    background-color: #ffffff
}

td.bottom {
    color: #336699;
    text-align: center;
    padding-top: 10px;
    padding-bottom: 10px;
    background-color: #ffffff;
}

</STYLE>
<script type="text/javascript">
	function subLogin(){
		if(document.getElementById("userNameId").value == ""){
			$.error("用户名不能为空");
			return false;
		}
		if(document.getElementById("passwordId").value == ""){
			$.error("密码不能为空");
			return false;
		}
		document.getElementById("loginFormId").submit();
	}
</script>
</head>

<body onload="document.f.j_username.focus();" class=bgcolor >
	<P>&nbsp;</P>
	<P>&nbsp;</P>
	<P>&nbsp;</P>
	<FORM id="loginFormId" name="f" action="<c:url value='/j_spring_security_check'/>"
		method="POST">
		<TABLE height=252 cellSpacing=0 cellPadding=0 width=432 align=center
			border=0>
			<TBODY>
				<TR>
					<TD align=middle background="<c:url value='/images/Login_Top.gif'/>" height=26>
						<TABLE cellSpacing=0 cellPadding=0 width=300 border=0>
							<TBODY>
								<TR>
									<TD vAlign=bottom align=middle height=18><SPAN
										class=STYLE5>欢迎使用后台管理系统</SPAN>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD align=middle background="<c:url value='/images/Login_BG.gif'/>">
						<TABLE height=147 width=400 border=0>
							<TBODY>
								<TR>
									<TD align=right width=147 rowSpan=5><IMG height=130 alt=2 
									src="<c:url value='/images/Login_TT.jpg'/>" width=132>
									</TD>
									<TD align=right height=30> </TD>
									<TD align=middle width=179 colSpan=2 height=30> 
									<c:if test="$(document){not empty param.login_error}">
										<font color="red"> 登录失败请重试.<br /> <br /> 原因: <c:out
												value="<#noparse>$(document){SPRING_SECURITY_LAST_EXCEPTION.message}" />. </font>
									</c:if>
									</TD>
								</TR>
								<TR>
									<TD align=right height=30>用户名：</TD>
									<TD align=middle colSpan=2 height=30>
									<input id="userNameId" type='text' name='j_username' onmouseover="this.style.background='#E1F4EE';"
										style="BORDER-RIGHT: 1px solid; PADDING-RIGHT: 4px; BORDER-TOP: 1px solid; PADDING-LEFT: 4px; PADDING-BOTTOM: 1px; BORDER-LEFT: 1px solid; WIDTH: 160px; PADDING-TOP: 1px; BORDER-BOTTOM: 1px solid"
										onfocus="this.select(); "
										onmouseout="this.style.background='#FFFFFF'" maxLength=20
					value='<c:if test="<#noparse>$(document){not empty param.login_error}"><c:out value="<#noparse>$(document){SPRING_SECURITY_LAST_USERNAME}"/></c:if>' />
									</TD>
								</TR>
								<TR>
									<TD align=right height=30>密 码：</TD>
									<TD align=middle colSpan=2 height=30>
									<INPUT id="passwordId"
										onmouseover="this.style.background='#E1F4EE';"
										style="BORDER-RIGHT: 1px solid; PADDING-RIGHT: 4px; BORDER-TOP: 1px solid; PADDING-LEFT: 4px; PADDING-BOTTOM: 1px; BORDER-LEFT: 1px solid; WIDTH: 160px; PADDING-TOP: 1px; BORDER-BOTTOM: 1px solid"
										onfocus="this.select(); "
										onmouseout="this.style.background='#FFFFFF'" type=password
										maxLength=20 name='j_password' />
									</TD>
								</TR>
								<TR>
									<TD align=right height=30> <INPUT
										onmouseover="this.style.background='#E1F4EE';"
										style="BORDER-RIGHT: 1px solid; PADDING-RIGHT: 4px; BORDER-TOP: 1px solid; PADDING-LEFT: 4px; PADDING-BOTTOM: 1px; BORDER-LEFT: 1px solid; PADDING-TOP: 1px; BORDER-BOTTOM: 1px solid"
										onfocus="this.select(); "
										onmouseout="this.style.background='#FFFFFF'" maxLength=4
										size=6 name=CheckCode type="checkbox" name="_spring_security_remember_me"></TD>
									<TD align=left colSpan=2 height=30> 两周内自动登录
									</TD>
								</TR>
								<TR>
									<TD class=style2 vAlign=center align=right>&nbsp;&nbsp;</TD>
									<TD class=style2 vAlign=center align=right><INPUT
										onmouseover="this.style.backgroundColor='#ffffff'"
										style="BORDER-RIGHT: #e1f4ee 1px solid; BORDER-TOP: #e1f4ee 1px solid; FONT-SIZE: 9pt; BORDER-LEFT: #e1f4ee 1px solid; WIDTH: 60px; COLOR: #000000; BORDER-BOTTOM: #e1f4ee 1px solid; HEIGHT: 19px; BACKGROUND-COLOR: #e1f4ee"
										onmouseout="this.style.backgroundColor='#E1F4EE'" type="button"
										value=" 确&nbsp;认 " onclick="subLogin()" />
									</TD>
									<TD class=style2 vAlign=center align=right><INPUT id=reset
										onmouseover="this.style.backgroundColor='#ffffff'"
										style="BORDER-RIGHT: #e1f4ee 1px solid; BORDER-TOP: #e1f4ee 1px solid; FONT-SIZE: 9pt; BORDER-LEFT: #e1f4ee 1px solid; WIDTH: 60px; COLOR: #000000; BORDER-BOTTOM: #e1f4ee 1px solid; HEIGHT: 19px; BACKGROUND-COLOR: #e1f4ee"
										onmouseout="this.style.backgroundColor='#E1F4EE'" type=reset
										value=" 清&nbsp;除 " name=reset />
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD align=middle background="<c:url value='/images/Login_Down.gif'/>" height=56>
						<TABLE width=400 border=0>
							<TBODY>
								<TR>
									<TD width=144><SPAN class=STYLE6>默认用户名：admin</SPAN>
									</TD>
									<TD width=120><SPAN class=STYLE6>默认密码：1</SPAN>
									</TD>
									<TD width=122><SPAN class=STYLE6>tanghc@163.com</SPAN>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		<TABLE cellSpacing=0 cellPadding=0 width="75%" align=center border=0>
			<TBODY>
				<TR>
					<TD>
						<DIV class=STYLE6 align=center></DIV>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</FORM>
</body>
</html>