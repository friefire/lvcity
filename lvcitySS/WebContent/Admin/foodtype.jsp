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
<title>foodtype</title>

<style type="text/css">
#foodtype_fm {
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
	
	<table id="foodtype_dg" class="easyui-datagrid" style="height: 670px;"
		url="food/findAlltype.do" toolbar="#foodtype_toolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true"
		data-options="fit:false,border:false,pageSize:5,pageList:[5,10,15,20]">
		<thead>
			<tr>
				<th field="ft" width="50">美食类型</th>
			</tr>
		</thead>
	</table>
	<div id="foodtype_toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="newfoodtype()">新增</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true" onclick="editfoodtype()">编辑</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="destroyfoodtype()">删除</a>
	</div>

	<div id="foodtype_dlg" class="easyui-dialog" style="padding: 10px 20px"
		closed="true" buttons="#foodtype_dlg-buttons">
		<div class="ftitle">详细信息</div>
		<form id="foodtype_fm" method="post" novalidate>
			<div class="fitem">
				<label>美食类型:</label><input name="ft" class="easyui-textbox"
					required="true">
			</div>
		</form>
	</div>
	<div id="foodtype_dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="savefoodtype()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#foodtype_dlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>
	<script type="text/javascript">
		var url;
		function newfoodtype() {
			$('#foodtype_dlg').dialog('open').dialog('setTitle', '新增');
			$('#foodtype_fm').form('clear');
			url = 'food/addFoodType.do';
		}
		function editfoodtype() {
			var row = $('#foodtype_dg').datagrid('getSelected');
			if (row) {
				$('#foodtype_dlg').dialog('open').dialog('setTitle', '编辑');
				$('#foodtype_fm').form('load', row);
				url = 'food/updateFoodType.do?ftid=' + row.ftid;
			}
		}
		function savefoodtype() {
			$('#foodtype_fm').form('submit', {
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
						$('#foodtype_dlg').dialog('close'); // close the dialog
						$('#foodtype_dg').datagrid('reload'); // reload the foodtype data
					}
				}
			});
		}
		function destroyfoodtype() {
			var row = $('#foodtype_dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm('Confirm', '确定要删除吗?', function(r) {
					if (r) {
						$.post('food/deleteFoodType.do', {
							ftid : row.ftid
						}, function(result) {
							if (result.success) {
								$('#foodtype_dg').datagrid('reload'); // reload the foodtype data
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