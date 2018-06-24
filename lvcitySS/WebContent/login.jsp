<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>登录页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="jquery-easyui-1.4.1/themes/icon.css"/>
	<link rel="stylesheet" type="text/css" href="jquery-easyui-1.4.1/themes/gray/easyui.css">
	<link rel="stylesheet" type="text/css" href="jquery-easyui-1.4.1/themes/default/easyui.css">
	<script type="text/javascript" src="jquery-easyui-1.4.1/jquery.min.js"></script>
    <script type="text/javascript" src="jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
  </head>
  <%
  	String message = (String) request.getAttribute("message");
		if (message == null) {
			message = "";
		}
		if (!message.trim().equals("")) {
			out.println("<script language='javascript'>");
			out.println("alert('"+message+"')");
			out.println("</script>");
		}
		//request.removeAttribute("message");
		 %>
  <body style=”width:100%;height:100%;">
	<div id="login" class="easyui-window" style="padding-top: 50px;padding-left: 15px">
		<form id="loginForm" action='Admin/User?action=login' method="post">
		<table>
		<tr>
			<td>
				<table>
				
				<tr><td>用户名</td><td><input  class="easyui-validatebox"   id="name" name="name" type="text"/></td><td></td></tr>
				<tr><td>密 码</td><td><input  class="easyui-validatebox"  id="passwd" name="passwd" type="password"></td><td></td></tr>
				<div style="text-align: center;color: red;" id="showMsg"></div>
				</table>
			</td>
			<td>
			<img style="width:80px;" src="images/head.png"/>
			</td>
			</tr>			
		</table>
		</form>
	</div>
	<script type="text/javascript">
		$(function() {
			$("#login").dialog({
				title : '登录',
				backcolor:'#00f',
				iconCls : 'icon-lock',	
				width : '420',
				height : '230',
				closable : false,
				minimizable : false,
				maximizable : false,
				resizable : false,
				modal : true,
				buttons : [ {
					text : '登录',
					iconCls : 'icon-ok',
					handler:function(){
					doLogin();
					}
				} ]
			});
		});
		function doLogin(){
		 if($("input[name='name']").val()=="" || $("input[name='passwd']").val()==""){
         $("#showMsg").html("用户名或密码为空，请输入");
         $("input[name='login']").focus();}else{
		$("#login").dialog("close");
		$("#loginForm").get(0).submit();
		}
		}
	</script>
  </body>
</html>
