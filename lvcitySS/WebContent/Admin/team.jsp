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
#team_fm {
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
  
  
    
  <script type="text/javascript" charset="utf-8" src="kindeditor/kindeditor.js"></script> 
<script src="kindeditor/lang/zh_CN.js" type="text/javascript"></script>
<link href="kindeditor/plugins/code/prettify.css" rel="stylesheet" type="text/css" />
<script src="kindeditor/plugins/code/prettify.js" type="text/javascript"></script>
  

</head>


<body>

	<table id="team_dg" class="easyui-datagrid" style="height: 670px;"
		url="team/findAll.do" toolbar="#team_toolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true"
		data-options="fit:false,border:false,pageSize:5,pageList:[5,10,15,20]">
		<thead>
			<tr>
			<th field="content" width="50">介绍内容</th>
			</tr>
		</thead>
	</table>
	<div id="team_toolbar">
	 <a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true" onclick="editTeam()">编辑</a>
	</div>

	<div id="team_dlg" class="easyui-dialog" style="padding: 10px 20px"
		closed="true" buttons="#team_dlg-buttons">
		<div class="ftitle">详细信息</div>
		<form id="team_fm" method="post" novalidate>
		<div class="fitem">
				<label>文章内容:</label><textarea id="editor_id3"  name="content" style="width:500px;height:300px;"></textarea>
			</div>
			 
			
		</form>
	</div>
	
	<div id="team_dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveTeam()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#team_dlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>
	<script type="text/javascript">
		var url;
		var editory;
		function newTeam() {
			$('#team_dlg').dialog('open').dialog('setTitle', '新增');
			$('#team_fm').form('clear');
			//addkind('textarea[name="content"]','');
			addkind('#editor_id3','');
			url = 'team/addteam.do';
		}
		
		function editTeam() {
			var row = $('#team_dg').datagrid('getSelected');
			if (row) {
				$('#team_dlg').dialog('open').dialog('setTitle', '编辑');
				$('#team_fm').form('load', row);
				url = 'team/updateteam.do?teamid=' + row.teamid;
			}
			//updatekind('textarea[name="content"]',row.content);
			updatekind('#editor_id3',row.content);	
		}
		
		
		function saveTeam() {
			$('#team_fm').form('submit', {
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
						$('#team_dlg').dialog('close'); // close the dialog
						$('#team_dg').datagrid('reload'); // reload the team data
					}
				}
			});
		}
		function destroyTeam() {
			var row = $('#team_dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm('Confirm', '确定要删除吗?', function(r) {
					if (r) {
						$.post('team/deleteteam.do', {
							teamid : row.teamid
						}, function(result) {
							if (result.success) {
								$('#team_dg').datagrid('reload'); // reload the team data
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
		  if(editory!=null){
			  editory.html(ctext);
		  }else{
			  editory = KindEditor.create(kedit,{
				 uploadJson : 'kindeditor/jsp/upload_json.jsp',  
					fileManagerJson : 'kindeditor/jsp/file_manager_json.jsp',  
					allowFileManager : true,
					width: '99%',
					height: '420px',
					afterBlur: function () { editory.sync();},
					allowImageUpload: true
			    });
		  
		  }
		  
		}
		
		function updatekind(kedit,ctext){
			 if(editory!=null){
				  editory.html(ctext);
			  }else{
				  editory = KindEditor.create(kedit,{
					 uploadJson : 'kindeditor/jsp/upload_json.jsp',  
						fileManagerJson : 'kindeditor/jsp/file_manager_json.jsp',  
						allowFileManager : true,
						width: '99%',
						height: '420px',
						afterBlur: function () { editory.sync('.con'); },
						allowImageUpload: true
				    });
			  }
			  
			}
		
	</script>

</body>
</html>