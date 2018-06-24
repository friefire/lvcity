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
#message_fm {
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

	<table id="message_dg" class="easyui-datagrid" style="height: 670px;"
		url="message/findAll.do" toolbar="#message_toolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true"
		data-options="fit:false,border:false,pageSize:5,pageList:[5,10,15,20]">
		<thead>
			<tr>
				<th field="name" width="50">姓名</th>
				<th field="tel" width="50">电话</th>
				<th field="sex" width="50">性别</th>
				<th field="message" width="50">内容</th>
			</tr>
		</thead>
	</table>
	<div id="message_toolbar">
		 <a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="destroyMessage()">删除</a>
	</div>

	<div id="message_dlg" class="easyui-dialog" style="width:60%;height:70%;text-align:center;"
		closed="true" buttons="#message_dlg-buttons">
		<div class="ftitle">详细信息</div>
		<form id="message_fm" method="post" novalidate>
			
			<div class="fitem">
				<label>姓名:</label> <input name="name" class="easyui-textbox" required="true">
			</div>
			<div class="fitem">
				<label>电话:</label> <input name="tel" class="easyui-textbox" required="true">
			</div>
			<div class="fitem">
				<label>性别:</label><input  class="easyui-textbox" name="sex" required="true"/>
			</div>
			<div class="fitem">
				<label>内容:</label><textarea id="message" class="con" name="message" style="width:500px;height:300px;"></textarea>
			</div>
			
		</form>
	</div>
	
	<div id="message_dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveMessage()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#message_dlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>
	<script type="text/javascript">
		var url;
		var editor;
		function newMessage() {
			$('#message_dlg').dialog('open').dialog('setTitle', '新增');
			$('#message_fm').form('clear');
			url = 'message/addMessage.do';
			addkind('textarea[name="webSite"]','');
		}
		
		
		function saveMessage() {
			$('#message_fm').form('submit', {
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
						$('#message_dlg').dialog('close'); // close the dialog
						$('#message_dg').datagrid('reload'); // reload the message data
					}
				}
			});
		}
		function destroyMessage() {
			var row = $('#message_dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm('Confirm', '确定要删除吗?', function(r) {
					if (r) {
						$.post('message/deleteMessage.do', {
							mid : row.mid
						}, function(result) {
							if (result.success) {
								$('#message_dg').datagrid('reload'); // reload the message data
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
		
		
		function addkind(kedit,ctext){
		  if(editor!=null){
			  editor.html(ctext);
		  }else{
			  editor = KindEditor.create(kedit,{
				 uploadJson : 'kindeditor/jsp/upload_json.jsp',  
					fileManagerJson : 'kindeditor/jsp/file_manager_json.jsp',  
					allowFileManager : true,
					width: '99%',
					height: '420px',
					afterBlur: function () { editor.sync();},
					allowImageUpload: true
			    });
		  
		  }
		  
		}
		
		function updatekind(kedit,ctext){
			 if(editor!=null){
				  editor.html(ctext);
			  }else{
				  editor = KindEditor.create(kedit,{
					 uploadJson : 'kindeditor/jsp/upload_json.jsp',  
						fileManagerJson : 'kindeditor/jsp/file_manager_json.jsp',  
						allowFileManager : true,
						width: '99%',
						height: '420px',
						afterBlur: function () { editor.sync('.con'); },
						allowImageUpload: true
				    });
			  }
			  
			}
		
	</script>

</body>
</html>