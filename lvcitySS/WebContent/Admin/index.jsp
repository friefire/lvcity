<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>

<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>JQuery easyui demo</title>

<link rel="stylesheet" type="text/css"
	href="jquery-easyui-1.4.1/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="jquery-easyui-1.4.1/themes/icon.css">
<script type="text/javascript" src="jquery-easyui-1.4.1/jquery.min.js"></script>
<script type="text/javascript"
	src="jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	function open_menu(titleName, menuUrl) {
		if ($("#tt").tabs("exists", titleName)) {
			$("#tt").tabs("select", titleName);
		} else {
			$('#tt').tabs('add', {
				title : titleName,
				href : menuUrl,
				closable : true
			});
		}
		
	}
	function exit(){
		window.location.href='users/exit.do';
	}
</script>

<script type="text/javascript" charset="utf-8" src="kindeditor/kindeditor.js"></script> 
<script src="kindeditor/lang/zh_CN.js" type="text/javascript"></script>
<link href="kindeditor/plugins/code/prettify.css" rel="stylesheet" type="text/css" />
<script src="kindeditor/plugins/code/prettify.js" type="text/javascript"></script>



</head>

<body class="easyui-layout">
	<div id="cc" class="easyui-layout" style="width: 100%;heith:100%; min-height: 800px;">
		<div data-options="region:'north',border:false" style="height: 100px;">
			<img alt="logo" src="images/logo2.png">
		</div>
		<div data-options="region:'west',title:'菜单',split:true"
			style="width: 200px;">
			<div id="aa" class="easyui-accordion"
				data-options="fit:true,border:false">
				
				<div title="bannar广告管理" data-options="iconCls:'icon-save',selected:true"
					style="overflow: auto; padding: 10px;">
					<a  href="javascript:void(0);" class="easyui-linkbutton"
						data-options="plain:true" onclick="open_menu('banar广告管理','Admin/banar.jsp')">banar广告管理</a><br/>
				</div>
				
				<div title="文章管理" data-options="iconCls:'icon-save',selected:true"
					style="overflow: auto; padding: 10px;">
					<a  href="javascript:void(0);" class="easyui-linkbutton"
						data-options="plain:true" onclick="open_menu('文章类型管理','Admin/articletype.jsp')">文章类型管理</a><br/>
					<a  href="javascript:void(0);" class="easyui-linkbutton"
						data-options="plain:true" onclick="open_menu('文章管理','Admin/article.jsp')">历史文章管理</a>
				</div>
				
				<div title="风景旅游管理" data-options="iconCls:'icon-save'"
					style="overflow: auto; padding: 10px;">
					<a  href="javascript:void(0);" class="easyui-linkbutton"
						data-options="plain:true" onclick="open_menu('风景旅游类型管理','Admin/scenictype.jsp')">风景旅游类型管理</a><br/>
					<a  href="javascript:void(0);" class="easyui-linkbutton"
						data-options="plain:true" onclick="open_menu('风景旅游管理','Admin/scenicart.jsp')">风景旅游管理</a>
				</div>
				
				<div title="美食管理" data-options="iconCls:'icon-save'"
					style="overflow: auto; padding: 10px;">
					<a  href="javascript:void(0);" class="easyui-linkbutton"
						data-options="plain:true" onclick="open_menu('美食类型管理','Admin/foodtype.jsp')">美食类型管理</a><br/>
					<a  href="javascript:void(0);" class="easyui-linkbutton"
						data-options="plain:true" onclick="open_menu('美食管理','Admin/food.jsp')">美食管理</a>
				</div>
				
				<div title="动态新闻管理" data-options="iconCls:'icon-save'"
					style="overflow: auto; padding: 10px;">
					<a  href="javascript:void(0);" class="easyui-linkbutton"
						data-options="plain:true" onclick="open_menu('动态新闻类型管理','Admin/noticetype.jsp')">动态新闻类型管理</a><br/>
					<a  href="javascript:void(0);" class="easyui-linkbutton"
						data-options="plain:true" onclick="open_menu('动态新闻管理','Admin/notice.jsp')">动态新闻管理</a>
				</div>
				
				<div title="团队留言管理" data-options="iconCls:'icon-save'"
					style="overflow: auto; padding: 10px;">
					<a  href="javascript:void(0);" class="easyui-linkbutton"
						data-options="plain:true" onclick="open_menu('团队介绍管理','Admin/team.jsp')">团队介绍管理</a><br/>
						
					<a  href="javascript:void(0);" class="easyui-linkbutton"
						data-options="plain:true" onclick="open_menu('联系方式管理','Admin/contact.jsp')">联系方式管理</a><br/>
					<a  href="javascript:void(0);" class="easyui-linkbutton"
						data-options="plain:true" onclick="open_menu('留言管理','Admin/message.jsp')">留言管理</a>
				</div>
				
				<div title="后台用户管理" data-options="iconCls:'icon-save'"
					style="overflow: auto; padding: 10px;">
					<a  href="javascript:void(0);" class="easyui-linkbutton"
						data-options="plain:true" onclick="open_menu('后台用户管理','Admin/users.jsp')">后台用户管理</a><br/>
				</div>
				<div title="退出系统" data-options="iconCls:'icon-save'"
					style="overflow: auto; padding: 10px;">
					<a  href="javascript:void(0);" class="easyui-linkbutton"
						data-options="plain:true" onclick="exit()">退出系统</a><br/>
				</div>
				
			</div>
		</div>

		<div  id="dataContent" data-options="region:'center',border:false,plain:true">
			<div id="tt" class="easyui-tabs" fit=true>
				<div title="首页" style="text-align: center; font-size: 24px;">
					<img alt="logo" src="images/logo.png" style="margin-left:150px;"><br/>
					<a href="http://localhost:8888/lvcityFG" target="new" style="color:blue;text-decoration:none;">点击进入前台页面</a>
				</div>
			</div>
		</div>
		
	</div>
	
	<div style="height: 80px; text-align: center; font-size: 12px;">
		<p>版权所有,&copy;2017-2018</p>
	</div>
</body>
</html>