<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>articletype</title>

<style type="text/css">
#articletype_fm {
	margin: 0;
	padding: 10px 30px;
}

.ftitle {
	font-size: 14px;
	font-weight: bold;
	padding: 5px 0;
	margin-bottom: 10px;
	border-bottom: 1px solid #ccc;
}

.fitem {
	margin-bottom: 5px;
}

.fitem label {
	display: inline-block;
	width: 80px;
}

.fitem input {
	width: 160px;
}
</style>


<link rel="stylesheet" type="text/css"
	href="jquery-easyui-1.4.1/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="jquery-easyui-1.4.1/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="jquery-easyui-1.4.1/themes/color.css">
<link rel="stylesheet" type="text/css"
	href="jquery-easyui-1.4.1/demo/demo.css">
<script type="text/javascript" src="jquery-easyui-1.4.1/jquery.min.js"></script>
<script type="text/javascript"
	src="jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
   <!-- 
	<div style="height: 70px; width: 100%;">
		<form id="ff" method="post">
			<div style="float: left; padding: 20px 0 0 20px;">
				<label for="name">用户名:</label> <input class="easyui-validatebox"
					type="text" name="name" />
			</div>
			<div style="float: left; padding: 20px 0 0 20px;">
				<label for="email">邮箱:</label> <input class="easyui-validatebox"
					type="text" name="email" data-options="validType:'email'" />
			</div>
			<div style="float: left; padding: 20px 0 0 20px;">
				<input class="easyui-validatebox" type="button" value="查询" />
			</div>
		</form>
	</div>
	 -->
	
	<table id="articletype_dg" class="easyui-datagrid" style="height: 670px;"
		url="article/findAlltype.do" toolbar="#articletype_toolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true"
		data-options="fit:false,border:false,pageSize:15,pageList:[5,10,15,20]">
		<thead>
			<tr>
				<th field="atype" width="50">文章类型</th>
			</tr>
		</thead>
	</table>
	<div id="articletype_toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="newarticletype()">新增</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true" onclick="editarticletype()">编辑</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="destroyarticletype()">删除</a>
	</div>

	<div id="articletype_dlg" class="easyui-dialog" style="padding: 10px 20px"
		closed="true" buttons="#articletype_dlg-buttons">
		<div class="ftitle">详细信息</div>
		<form id="articletype_fm" method="post" novalidate>
			<div class="fitem">
				<label>文章类型:</label><input name="atype" class="easyui-textbox"
					required="true">
			</div>
		</form>
	</div>
	<div id="articletype_dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="savearticletype()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#articletype_dlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>
	<script type="text/javascript">
		var url;
		function newarticletype() {
			$('#articletype_dlg').dialog('open').dialog('setTitle', '新增');
			$('#articletype_fm').form('clear');
			url = 'article/addArticleType.do';
		}
		function editarticletype() {
			var row = $('#articletype_dg').datagrid('getSelected');
			if (row) {
				$('#articletype_dlg').dialog('open').dialog('setTitle', '编辑');
				$('#articletype_fm').form('load', row);
				url = 'article/updateArticleType.do?atid=' + row.atid;
			}
		}
		function savearticletype() {
			$('#articletype_fm').form('submit', {
				url : url,
				onSubmit : function() {
					return $(this).form('validate');
				},
				success : function(result) {
					var result = eval('(' + result + ')');
					if (result.errorMsg) {
						$.messager.show({
							title : 'Error',
							msg : result.errorMsg
						});
					} else {
						$('#articletype_dlg').dialog('close'); // close the dialog
						$('#articletype_dg').datagrid('reload'); // reload the articletype data
					}
				}
			});
		}
		function destroyarticletype() {
			var row = $('#articletype_dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm('Confirm', '确定要删除吗?', function(r) {
					if (r) {
						$.post('article/deleteArticleType.do?atid='+row.atid, {
							atid : row.atid
						}, function(result) {
							if (result.success) {
								$('#articletype_dg').datagrid('reload'); // reload the articletype data
							} else {
								$.messager.show({ // show error message
									title : 'Error',
									msg : result.errorMsg
								});
							}
						}, 'json');
					}
				});
			}
		}
	</script>

</body>
</html>