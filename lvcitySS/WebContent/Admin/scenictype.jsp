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
<title>JQuery easyui demo</title>

<style type="text/css">
#scenictype_fm {
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

	<table id="scenictype_dg" class="easyui-datagrid" style="height: 670px;"
		url="scenictype/findAll.do" toolbar="#scenictype_toolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true"
		data-options="fit:false,border:false,pageSize:5,pageList:[5,10,15,20]">
		<thead>
			<tr>
			<th field="st" width="50">风景类别</th>
			</tr>
		</thead>
	</table>
	<div id="scenictype_toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="newScenictype()">新增</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true" onclick="editScenictype()">编辑</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="destroyScenictype()">删除</a>
	</div>

	<div id="scenictype_dlg" class="easyui-dialog" style="padding: 10px 20px"
		closed="true" buttons="#scenictype_dlg-buttons">
		<div class="ftitle"></div>
		<form id="scenictype_fm" method="post" novalidate>
		
			<div class="fitem">
				<label>风景类别:</label><br><input name="st" class="easyui-textbox">
			</div>
		</form>
	</div>
	
	<div id="scenictype_dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveScenictype()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#scenictype_dlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>
	<script type="text/javascript">
		var url;
		function newScenictype() {
			$('#scenictype_dlg').dialog('open').dialog('setTitle', '新增');
			$('#scenictype_fm').form('clear');
			url = 'scenictype/addscenictype.do';
		
		}
		
		function editScenictype() {
			var row = $('#scenictype_dg').datagrid('getSelected');
			if (row) {
				$('#scenictype_dlg').dialog('open').dialog('setTitle', '编辑');
				$('#scenictype_fm').form('load', row);
				alert('666');
				url = 'scenictype/updatescenictype.do?stid=' + row.stid;
			}
		
		}
		
		
		function saveScenictype() {
			$('#scenictype_fm').form('submit', {
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
						$('#scenictype_dlg').dialog('close'); // close the dialog
						$('#scenictype_dg').datagrid('reload'); // reload the scenictype data
					}
				}
			});
		
		}
		function destroyScenictype() {
			var row = $('#scenictype_dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm('Confirm', '确定要删除吗?', function(r) {
					if (r) {
						$.post('scenictype/deletescenictype.do', {
							stid : row.stid
						}, function(result) {
							if (result.success) {
								$('#scenictype_dg').datagrid('reload'); // reload the scenictype data
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