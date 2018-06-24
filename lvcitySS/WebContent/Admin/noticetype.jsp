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
#noticetype_fm {
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

	<table id="noticetype_dg" class="easyui-datagrid" style="height: 670px;"
		url="noticetype/findAll.do" toolbar="#noticetype_toolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true"
		data-options="fit:false,border:false,pageSize:5,pageList:[5,10,15,20]">
		<thead>
			<tr>
			<th field="nt" width="50">动态新闻类型管理</th>
			</tr>
		</thead>
	</table>
	<div id="noticetype_toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="newNoticetype()">新增</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-edit" plain="true" onclick="editNoticetype()">编辑</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="destroyNoticetype()">删除</a>
	</div>

	<div id="noticetype_dlg" class="easyui-dialog" style="padding: 10px 20px"
		closed="true" buttons="#noticetype_dlg-buttons">
		<div class="ftitle">详细信息</div>
		<form id="noticetype_fm" method="post" novalidate>
		<div class="fitem">
				<label>联系人:</label><br><input name="nt" class="easyui-textbox" required="true">
			</div>

			<!--<div class="fitem">
				<label>网站地址:</label><textarea id="content" class="con" name="web" style="width:500px;height:300px;"></textarea>
			</div>
			<div class="fitem">
				<label>传真编号:</label><textarea id="content" class="con" name="fax" style="width:500px;height:300px;"></textarea>
			</div>
			  <div class="fitem">
				<label>图片:</label><input id="imgPicker" type="file" name="image" onchange="xmTanUploadImg(this)">
			</div>
			<div class="fitem" style="margin-top:10px;line-height:120px">
				<label>浏览图片:</label><img id="xmTanImg" width="300px" height="200px"/>
			</div>
			
			   <script type="text/javascript">            
            //判断浏览器是否支持FileReader接口
            if (typeof FileReader == 'undefined') {
                document.getElementById("xmTanDiv").InnerHTML = "<h1>当前浏览器不支持FileReader接口</h1>";
                //使选择控件不可操作
                document.getElementById("xdaTanFileImg").setAttribute("disabled", "disabled");
            }

            //选择图片，马上预览
            function xmTanUploadImg(obj) {
                var file = obj.files[0];
                
                console.log(obj);console.log(file);
                console.log("file.size = " + file.size);  //file.size 单位为byte

                var reader = new FileReader();

                //读取文件过程方法
                reader.onloadstart = function (e) {
                    console.log("开始读取....");
                }
                reader.onprogress = function (e) {
                    console.log("正在读取中....");
                }
                reader.onabort = function (e) {
                    console.log("中断读取....");
                }
                reader.onerror = function (e) {
                    console.log("读取异常....");
                }
                reader.onload = function (e) {
                    console.log("成功读取....");

                    var img = document.getElementById("xmTanImg");
                    img.src = e.target.result;
                    //或者 img.src = this.result;  //e.target == this
                }

                reader.readAsDataURL(file)
            }
        </script>
		    -->
		</form>
	</div>
	
	<div id="noticetype_dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveNoticetype()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#noticetype_dlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>
	<script type="text/javascript">
		var url;
		var editor;
		function newNoticetype() {
			$('#noticetype_dlg').dialog('open').dialog('setTitle', '新增');
			$('#noticetype_fm').form('clear');
			url = 'noticetype/addnoticetype.do';
			addkind('textarea[name="webSite"]','');
		}
		
		function editNoticetype() {
			var row = $('#noticetype_dg').datagrid('getSelected');
			if (row) {
				$('#noticetype_dlg').dialog('open').dialog('setTitle', '编辑');
				$('#noticetype_fm').form('load', row);
				url = 'noticetype/updatenoticetype.do?ntid=' + row.ntid;
			}
			updatekind('textarea[name="webSite"]',row.webSite);
		}
		
		
		function saveNoticetype() {
			$('#noticetype_fm').form('submit', {
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
						$('#noticetype_dlg').dialog('close'); // close the dialog
						$('#noticetype_dg').datagrid('reload'); // reload the contact data
					}
				}
			});
		}
		function destroyNoticetype() {
			var row = $('#noticetype_dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm('Confirm', '确定要删除吗?', function(r) {
					if (r) {
						$.post('noticetype/deletenoticetype.do', {
							ntid : row.ntid
						}, function(result) {
							if (result.success) {
								$('#noticetype_dg').datagrid('reload'); // reload the contact data
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