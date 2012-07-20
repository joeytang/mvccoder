<%--
  Created by IntelliJ IDEA.
  User: linhao
  Date: 2009-6-9
  Time: 9:43:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>

<%
    Throwable ex = null;
    if (exception != null)
        ex = exception;
    if (request.getAttribute("javax.servlet.error.exception") != null)
        ex = (Exception) request.getAttribute("javax.servlet.error.exception");
%>

<html>
<head><title>系统异常</title></head>
<body>
<table border="0" width="100%" height="100%">
    <tr align="center" valign="middle">
        <td align="center" valign="middle">
            <h1>系统运行异常，请联系系统管理员。</h1>
        </td>
    </tr>
</table>

<div style="visibility:hidden;display:none;">
    <% if (ex != null) { %>
		<pre>
			<% ex.printStackTrace(new java.io.PrintWriter(out)); %>
		</pre>
    <% } %>
</div>

</body>
</html>